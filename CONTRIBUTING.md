# 🥛 Contributing to Udder

This guide explains how to add new tools to the Udder repository to make them available across platforms.

## 📋 Prerequisites

1. Your application must:
   - Require authentication or VPN access after installation
   - Not contain any sensitive information
   - Be digitally signed

2. You'll need binaries compiled for all supported platforms:
   - Linux: `amd64` (x86_64), `arm64`
   - macOS: `x86_64` (Intel), `arm64` (Apple Silicon)
   - Windows: `x86_64`, `arm64`

## 🚀 Publishing Process

### 1️⃣ Create Package Files

#### 🐧 For APT (Debian/Ubuntu)

1. Create a `.deb` package for each Linux architecture
2. Place them in the appropriate directories:
   ```
   apt/pool/main/<package-name>/<package-name>_<version>_amd64.deb
   apt/pool/main/<package-name>/<package-name>_<version>_arm64.deb
   ```

#### 🍎 For Homebrew (macOS)

1. Create a Ruby formula file in the `Formula` directory:
   ```
   Formula/<package-name>.rb
   ```

2. Use the following template:
   ```ruby
   class PackageName < Formula
     desc "Description of your tool"
     homepage "https://github.com/modern-milkman/udder"
     version "1.0.0"

     on_macos do
       on_arm do
         url "https://github.com/modern-milkman/udder/releases/download/v#{version}/package-name-#{version}-darwin-arm64.tar.gz"
         sha256 "sha256sum-here"
       end
       on_intel do
         url "https://github.com/modern-milkman/udder/releases/download/v#{version}/package-name-#{version}-darwin-x86_64.tar.gz"
         sha256 "sha256sum-here"
       end
     end

     def install
       bin.install "package-name"
     end

     test do
       system "#{bin}/package-name", "--version"
     end
   end
   ```

#### 🪟 For WinGet (Windows)

1. Create manifest files in the `manifests/<package-name>/<version>` directory:
   ```
   manifests/ModernMilkman.<package-name>/<version>/ModernMilkman.<package-name>.yaml
   manifests/ModernMilkman.<package-name>/<version>/ModernMilkman.<package-name>.installer.yaml
   manifests/ModernMilkman.<package-name>/<version>/ModernMilkman.<package-name>.locale.en-GB.yaml
   ```

2. Use the standard WinGet manifest format with architecture-specific installers

### 2️⃣ Upload Release Binaries

1. Create a new release in GitHub
2. Upload all architecture-specific binaries
3. Tag the release with a semantic version (e.g., `v1.0.0`)

### 3️⃣ Update Repository Metadata

Run the update scripts (automated through GitHub Actions when you create a PR):

```bash
# For APT
./scripts/update-apt-repository.sh

# For Homebrew - no additional actions needed

# For WinGet - validation happens automatically
```

### 4️⃣ Create a Pull Request

1. Create a PR with your changes
2. Wait for the validation workflow to complete
3. Address any issues that the workflow identifies

## 🧪 Testing Locally

To test your packages locally before submitting:

### 🐧 APT

```bash
# Validate .deb packages
dpkg-deb -I your-package.deb
```

### 🍎 Homebrew

```bash
# Test formula locally
brew install --build-from-source ./Formula/your-package.rb
```

### 🪟 WinGet

```bash
# Validate manifest
winget validate manifests/ModernMilkman.<package-name>/<version>
```

## ❓ Need Help?

Contact the Engineering team if you need assistance with the publishing process.
