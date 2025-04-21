#!/bin/sh
# Script to generate a GPG key for signing the APT repository

set -e

# Configuration
SCRIPT_PATH="$(readlink -f "$0" 2>/dev/null || realpath "$0" 2>/dev/null || echo "$0")"
REPO_DIR="$(cd "$(dirname "$SCRIPT_PATH")/.." && pwd)"
KEY_DIR="${REPO_DIR}/.gnupg"
KEY_NAME="modern-milkman-udder"
KEY_EMAIL="tech-engineering@themodernmilkman.co.uk"
KEY_COMMENT="Modern Milkman Udder APT Repository Signing Key"

# Check if GPG is installed
if ! command -v gpg >/dev/null 2>&1; then
  echo "Error: gpg is not installed. Please install it and try again."
  exit 1
fi

# Create key directory if it doesn't exist
mkdir -p "${KEY_DIR}"
chmod 700 "${KEY_DIR}"

# Check if key already exists
if gpg --list-secret-keys "${KEY_NAME}" >/dev/null 2>&1; then
  echo "A key with name '${KEY_NAME}' already exists."
  read -p "Do you want to create a new key anyway? (y/N): " confirm
  if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
    echo "Exiting without creating a new key."
    exit 0
  fi
fi

# Generate batch file for unattended key generation
cat > "${KEY_DIR}/key-gen-batch" << EOF
%echo Generating APT repository signing key
Key-Type: RSA
Key-Length: 4096
Name-Real: ${KEY_NAME}
Name-Comment: ${KEY_COMMENT}
Name-Email: ${KEY_EMAIL}
Expire-Date: 0
%no-protection
%commit
%echo Key generation completed
EOF

# Generate the key
echo "Generating GPG key for APT repository signing..."
gpg --batch --generate-key "${KEY_DIR}/key-gen-batch"

# Export the private key
gpg --armor --export-secret-keys "${KEY_NAME}" > "${KEY_DIR}/private-key.asc"
chmod 600 "${KEY_DIR}/private-key.asc"

# Export the public key
gpg --armor --export "${KEY_NAME}" > "${REPO_DIR}/docs/KEY.gpg"

# Cleanup
rm "${KEY_DIR}/key-gen-batch"

echo "GPG key generation complete!"
echo ""
echo "Private key saved to: ${KEY_DIR}/private-key.asc"
echo "Public key saved to: ${REPO_DIR}/docs/KEY.gpg"
echo ""
echo "IMPORTANT: For GitHub Actions to sign the repository, add the"
echo "private key content to GitHub Secrets as APT_GPG_PRIVATE_KEY"
echo ""
echo "To display the private key for copying:"
echo "cat ${KEY_DIR}/private-key.asc"
