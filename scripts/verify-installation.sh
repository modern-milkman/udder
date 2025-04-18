#!/bin/sh
# Script to verify Udder tools installation and security compliance

set -e

# Configuration
SCRIPT_DIR="$(dirname "$0")"
OS_TYPE="$(uname -s)"
ARCH="$(uname -m)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Print header
print_header() {
  echo "\n${GREEN}===============================================${NC}"
  echo "${GREEN}== Modern Milkman Udder Installation Verifier ==${NC}"
  echo "${GREEN}===============================================${NC}\n"
}

# Check system type
check_system() {
  echo "${GREEN}System Information:${NC}"
  echo "Operating System: ${OS_TYPE}"
  echo "Architecture: ${ARCH}"
  
  case "${OS_TYPE}" in
    Linux)
      if command -v apt-get >/dev/null 2>&1; then
        echo "Package Manager: APT (Debian/Ubuntu)"
        check_apt_installation
      else
        echo "${YELLOW}This Linux distribution is not using APT.${NC}"
        echo "${YELLOW}Verification for this platform not implemented yet.${NC}"
      fi
      ;;
    Darwin)
      echo "Package Manager: Homebrew (macOS)"
      check_homebrew_installation
      ;;
    MINGW*|MSYS*|CYGWIN*|Windows*)
      echo "Package Manager: WinGet (Windows)"
      echo "${YELLOW}Windows verification not implemented in this script.${NC}"
      echo "${YELLOW}Please use PowerShell script instead.${NC}"
      ;;
    *)
      echo "${RED}Unknown operating system: ${OS_TYPE}${NC}"
      echo "${RED}Verification not supported.${NC}"
      ;;
  esac
}

# Check APT installation
check_apt_installation() {
  echo "\n${GREEN}Checking APT Repository Configuration:${NC}"
  
  # Check source list
  if [ -f /etc/apt/sources.list.d/modernmilkman-udder.list ]; then
    echo "✅ Repository source list is configured."
    grep -q "modern-milkman.github.io/udder/apt" /etc/apt/sources.list.d/modernmilkman-udder.list && \
      echo "✅ Repository URL is correct." || \
      echo "${RED}❌ Repository URL is incorrect.${NC}"
  else
    echo "${RED}❌ Repository source list not found.${NC}"
    echo "${YELLOW}To configure the repository:${NC}"
    echo "echo \"deb [signed-by=/usr/share/keyrings/modernmilkman-udder-archive-keyring.gpg] https://modern-milkman.github.io/udder/apt stable main\" | sudo tee /etc/apt/sources.list.d/modernmilkman-udder.list"
  fi
  
  # Check GPG key
  if [ -f /usr/share/keyrings/modernmilkman-udder-archive-keyring.gpg ]; then
    echo "✅ Repository GPG key is installed."
  else
    echo "${RED}❌ Repository GPG key not found.${NC}"
    echo "${YELLOW}To install the GPG key:${NC}"
    echo "curl -fsSL https://modern-milkman.github.io/udder/KEY.gpg | sudo gpg --dearmor -o /usr/share/keyrings/modernmilkman-udder-archive-keyring.gpg"
  fi
  
  # List installed packages
  echo "\n${GREEN}Installed Packages from Udder Repository:${NC}"
  dpkg-query -W -f='${Package}\t${Version}\t${Status}\n' 2>/dev/null | grep "modernmilkman" | grep "installed" || echo "No packages found."
}

# Check Homebrew installation
check_homebrew_installation() {
  echo "\n${GREEN}Checking Homebrew Tap Configuration:${NC}"
  
  # Check if brew is installed
  if ! command -v brew >/dev/null 2>&1; then
    echo "${RED}❌ Homebrew is not installed.${NC}"
    echo "${YELLOW}Please install Homebrew first:${NC}"
    echo "/bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    return 1
  fi
  
  # Check if tap is added
  if brew tap | grep -q "modern-milkman/udder"; then
    echo "✅ Modern Milkman tap is configured."
  else
    echo "${RED}❌ Modern Milkman tap is not configured.${NC}"
    echo "${YELLOW}To add the tap:${NC}"
    echo "brew tap modern-milkman/udder"
  fi
  
  # List installed packages from the tap
  echo "\n${GREEN}Installed Packages from Udder Tap:${NC}"
  brew list --full-name | grep "modern-milkman/udder" || echo "No packages found."
}

# Main function
main() {
  print_header
  check_system
  
  echo "\n${GREEN}Installation verification complete.${NC}"
}

# Run the main function
main