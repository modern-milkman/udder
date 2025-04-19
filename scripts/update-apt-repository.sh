#!/bin/sh
# Script to update APT repository metadata (POSIX compliant)

set -e

# Configuration
SCRIPT_PATH="$(readlink -f "$0" 2>/dev/null || realpath "$0" 2>/dev/null || echo "$0")"
REPO_DIR="$(cd "$(dirname "$SCRIPT_PATH")/.." && pwd)"
APT_DIR="${REPO_DIR}/apt"
DIST_DIR="${APT_DIR}/dists/stable"
KEY_FILE="${REPO_DIR}/docs/KEY.gpg"

# Make sure we have the required tools
for cmd in dpkg-scanpackages apt-ftparchive gpg; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Error: $cmd not found. Please install required dependencies."
    exit 1
  fi
done

# Generate Packages files for each architecture
for ARCH in amd64 arm64; do
  echo "Generating Packages for ${ARCH}..."

  # Create Packages file for this architecture
  (cd "${APT_DIR}" && \
   dpkg-scanpackages --arch "${ARCH}" pool/ > "dists/stable/main/binary-${ARCH}/Packages")

  # Compress the Packages file
  gzip -9fk "${DIST_DIR}/main/binary-${ARCH}/Packages"

  # Create Release file for this architecture
  cat > "${DIST_DIR}/main/binary-${ARCH}/Release" << EOF
Archive: stable
Component: main
Architecture: ${ARCH}
Origin: Modern Milkman
Label: Udder
Description: Modern Milkman internal tools repository
EOF
done

echo "Generate Release file"
(cd "${APT_DIR}/dists/stable" && \
 apt-ftparchive release . > Release)

# If a signing key exists, sign the Release file
if [ -f "${REPO_DIR}/.gnupg/private-key.asc" ]; then
  echo "Signing Release file..."

  echo "Import the private key if it hasn't been imported yet"
  if ! gpg --list-secret-keys "udder-apt-repository" >/dev/null 2>&1; then
    gpg --import "${REPO_DIR}/.gnupg/private-key.asc"
  fi

  echo "Sign the Release file"
  (cd "${APT_DIR}/dists/stable" && \
   gpg --default-key "udder-apt-repository" -abs -o Release.gpg Release && \
   gpg --default-key "udder-apt-repository" --clearsign -o InRelease Release)

  echo "Export public key to docs directory for users to download"
  gpg --armor --export "udder-apt-repository" > "${KEY_FILE}"
else
  echo "Warning: No GPG key found at ${REPO_DIR}/.gnupg/private-key.asc"
  echo "Release file will not be signed. Repository will not be secure!"
fi

echo "APT repository metadata updated successfully!"
