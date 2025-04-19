---
layout: default
---

# 🥛 Modern Milkman Udder

Repository for Modern Milkman internal tools binaries, available as APT repository, Homebrew tap, and WinGet source for easy installation across platforms.

## 📦 Installation Instructions

### 🐧 Debian/Ubuntu Linux

```sh
# Add the GPG key
curl -fsSL https://modern-milkman.github.io/udder/KEY.gpg | sudo gpg --dearmor -o /usr/share/keyrings/modernmilkman-udder-archive-keyring.gpg

# Add the repository to sources list
echo "deb [signed-by=/usr/share/keyrings/modernmilkman-udder-archive-keyring.gpg] https://modern-milkman.github.io/udder/apt stable main" | sudo tee /etc/apt/sources.list.d/modernmilkman-udder.list

# Update and install packages
sudo apt update
sudo apt install <package-name>
```

### 🍎 macOS (Homebrew)

```sh
# Add the tap
brew tap modern-milkman/udder

# Install packages
brew install modern-milkman/udder/<package-name>
```

### 🪟 Windows (WinGet)

```powershell
# Add the Modern Milkman source to WinGet
winget source add -n ModernMilkman -u https://raw.githubusercontent.com/modern-milkman/udder/main/manifests

# Install packages
winget install ModernMilkman.<package-name>
```

## 📋 Available Packages

For a full list of available packages, see the [repository on GitHub](https://github.com/modern-milkman/udder).

## ✅ Verifying Your Installation

Run our verification script to ensure everything is set up correctly:

```sh
# Linux/macOS
curl -fsSL https://raw.githubusercontent.com/modern-milkman/udder/main/scripts/verify-installation.sh | sh

# Windows
Invoke-WebRequest -Uri https://raw.githubusercontent.com/modern-milkman/udder/main/scripts/Verify-Installation.ps1 -OutFile .\Verify-Installation.ps1
powershell -ExecutionPolicy Bypass -File .\Verify-Installation.ps1
```
