#!/bin/sh
# Script to list all available packages in the Udder repository

set -e

# Configuration
SCRIPT_PATH="$(readlink -f "$0" 2>/dev/null || realpath "$0" 2>/dev/null || echo "$0")"
REPO_DIR="$(cd "$(dirname "$SCRIPT_PATH")/.." && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print header
echo "${GREEN}==================================${NC}"
echo "${GREEN}== Modern Milkman Udder Tools ==${NC}"
echo "${GREEN}==================================${NC}"

# List APT packages
echo "\n${BLUE}APT Packages (Debian/Ubuntu):${NC}"
find "${REPO_DIR}/apt/pool/main" -name "*.deb" | sort | while read -r pkg; do
  pkg_name=$(basename "$pkg" | sed -E 's/(.*)_[0-9].*/\1/')
  pkg_version=$(basename "$pkg" | sed -E 's/.*_([0-9][^_]*).*/\1/')
  pkg_arch=$(basename "$pkg" | sed -E 's/.*_([^\.]+)\.deb/\1/')
  echo "${GREEN}${pkg_name}${NC} (${YELLOW}v${pkg_version}${NC}) [${pkg_arch}]"
done

# List Homebrew formulas
echo "\n${BLUE}Homebrew Formulas (macOS):${NC}"
find "${REPO_DIR}/Formula" -name "*.rb" | sort | while read -r formula; do
  formula_name=$(basename "$formula" .rb)
  version=$(grep -E '^\s*version\s+' "$formula" | head -1 | sed -E 's/[^"]*"([^"]*).*/\1/')
  echo "${GREEN}${formula_name}${NC} (${YELLOW}v${version}${NC}) [x86_64, arm64]"
done

# List WinGet packages
echo "\n${BLUE}WinGet Packages (Windows):${NC}"
find "${REPO_DIR}/manifests" -name "*.yaml" | grep -v "installer\|locale" | sort | while read -r manifest; do
  pkg_id=$(grep "PackageIdentifier:" "$manifest" | head -1 | sed 's/PackageIdentifier:\s*//')
  pkg_version=$(grep "PackageVersion:" "$manifest" | head -1 | sed 's/PackageVersion:\s*//')
  echo "${GREEN}${pkg_id}${NC} (${YELLOW}v${pkg_version}${NC}) [x86_64, arm64]"
done

echo "\n${GREEN}Use the appropriate package manager to install these tools:${NC}"
echo "${YELLOW}Linux:${NC} sudo apt install <package-name>"
echo "${YELLOW}macOS:${NC} brew install modern-milkman/udder/<package-name>"
echo "${YELLOW}Windows:${NC} winget install ModernMilkman.<package-name>"