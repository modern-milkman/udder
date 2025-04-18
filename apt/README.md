---
layout: default
---

# 🐧 APT Repository

This directory contains the APT repository structure for Modern Milkman internal tools.

## 📁 Directory Structure

```
apt/
├── dists/
│   └── stable/
│       ├── main/
│       │   ├── binary-amd64/
│       │   │   ├── Packages
│       │   │   ├── Packages.gz
│       │   │   └── Release
│       │   └── binary-arm64/
│       │       ├── Packages
│       │       ├── Packages.gz
│       │       └── Release
│       ├── Release
│       ├── Release.gpg
│       └── InRelease
└── pool/
    └── main/
        ├── tool-name-1/
        │   ├── tool-name_1.0.0_amd64.deb
        │   └── tool-name_1.0.0_arm64.deb
        └── tool-name-2/
            ├── tool-name-2_1.2.3_amd64.deb
            └── tool-name-2_1.2.3_arm64.deb
```

## 📦 Adding New Packages

1. Create a directory for your tool in `apt/pool/main/`
2. Add your `.deb` files for each architecture to the directory
3. Run the repository update script:
   ```
   ./scripts/update-apt-repository.sh
   ```

## 🔑 Repository Signing

The repository is signed with a GPG key to ensure package authenticity. The public key is available at `docs/KEY.gpg`.

## 🧪 Testing Your Packages

Before committing new packages:

1. Verify your `.deb` packages:
   ```
   dpkg-deb -I your-package.deb
   dpkg-deb -c your-package.deb
   ```

2. Test installation locally:
   ```
   sudo apt install ./apt/pool/main/your-tool/your-tool_version_arch.deb
   ```

3. Ensure the package is properly signed

## 🏗️ Debian Package Structure Requirements

Your `.deb` packages should:

1. Follow the Debian package naming convention: `<package-name>_<version>_<architecture>.deb`
2. Include proper control file with all required fields
3. Have correct file permissions (executables must be 755)
4. Be digitally signed
5. Include a postinst script that requires authentication or VPN access
