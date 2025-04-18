# Udder

Repository for Modern Milkman internal tools binaries, available as APT repository, Homebrew tap, and WinGet source for easy installation across platforms.

## 📦 Installation Instructions

### 🐧 Debian/Ubuntu Linux

```bash
# Add the GPG key
curl -fsSL https://modern-milkman.github.io/udder/KEY.gpg | sudo gpg --dearmor -o /usr/share/keyrings/modernmilkman-udder-archive-keyring.gpg

# Add the repository to sources list
echo "deb [signed-by=/usr/share/keyrings/modernmilkman-udder-archive-keyring.gpg] https://modern-milkman.github.io/udder/apt stable main" | sudo tee /etc/apt/sources.list.d/modernmilkman-udder.list

# Update and install packages
sudo apt update
sudo apt install <package-name>
```

### 🍎 macOS (Homebrew)

```bash
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

## ✅ Verifying Your Installation

To verify that Udder is correctly installed on your system, run our verification scripts:

### Linux/macOS

```bash
curl -fsSL https://raw.githubusercontent.com/modern-milkman/udder/main/scripts/verify-installation.sh | bash
```

### Windows

```powershell
Invoke-WebRequest -Uri https://raw.githubusercontent.com/modern-milkman/udder/main/scripts/Verify-Installation.ps1 -OutFile .\Verify-Installation.ps1
powershell -ExecutionPolicy Bypass -File .\Verify-Installation.ps1
```

## 💻 Supported Platforms

- Linux: `amd64` (x86_64), `arm64`
- macOS: `x86_64` (Intel), `arm64` (Apple Silicon)
- Windows: `x86_64`, `arm64`

## 🔒 Security Note

All applications in this repository:
- Require authentication or VPN access after installation
- Do not contain sensitive information
- Are digitally signed

## 📚 For Developers

Publishing new tools requires:
1. Adding package manifests for all three systems
2. Building binaries for all supported architectures
3. Ensuring security compliance requirements are met
4. Passing the automated verification workflow

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed instructions on publishing tools.
