# 🪟 WinGet Manifests

This directory contains WinGet manifests for Modern Milkman internal tools.

## 📁 Directory Structure

Each tool should follow this structure:
```
manifests/
└── ModernMilkman.ToolName/
    └── x.y.z/
        ├── ModernMilkman.ToolName.yaml
        ├── ModernMilkman.ToolName.installer.yaml
        └── ModernMilkman.ToolName.locale.en-GB.yaml
```

## 📄 Manifest Templates

### 📌 Version Manifest (ModernMilkman.ToolName.yaml)

```yaml
# Created using WinGet Automation (https://github.com/microsoft/winget-create)
PackageIdentifier: ModernMilkman.ToolName
PackageVersion: x.y.z
DefaultLocale: en-GB
ManifestType: version
ManifestVersion: 1.4.0
```

### 🔧 Installer Manifest (ModernMilkman.ToolName.installer.yaml)

```yaml
# Created using WinGet Automation
PackageIdentifier: ModernMilkman.ToolName
PackageVersion: x.y.z
InstallerLocale: en-GB
MinimumOSVersion: 10.0.0.0
InstallerType: exe  # Or appropriate type (msi, msix, inno, nullsoft, etc.)
Scope: user  # or machine
InstallModes:
  - silent
  - silentWithProgress
InstallerSwitches:
  Silent: /S
  SilentWithProgress: /S
UpgradeBehavior: install
Installers:
  - Architecture: x64
    InstallerUrl: https://github.com/modern-milkman/udder/releases/download/tool-name-vx.y.z/tool-name-x.y.z-windows-amd64.exe
    InstallerSha256: SHA256-HASH-HERE
  - Architecture: arm64
    InstallerUrl: https://github.com/modern-milkman/udder/releases/download/tool-name-vx.y.z/tool-name-x.y.z-windows-arm64.exe
    InstallerSha256: SHA256-HASH-HERE
ManifestType: installer
ManifestVersion: 1.4.0
```

### 🌐 Locale Manifest (ModernMilkman.ToolName.locale.en-GB.yaml)

```yaml
# Created using WinGet Automation
PackageIdentifier: ModernMilkman.ToolName
PackageVersion: x.y.z
PackageLocale: en-GB
Publisher: Modern Milkman
PublisherUrl: https://github.com/modern-milkman
PublisherSupportUrl: https://github.com/modern-milkman/udder/issues
PackageName: Tool Name
PackageUrl: https://github.com/modern-milkman/udder
License: MIT  # Or appropriate license
ShortDescription: Short description of the tool
Description: More detailed description of what the tool does
Moniker: tool-name
Tags:
  - modern-milkman
  - internal-tool
ManifestType: defaultLocale
ManifestVersion: 1.4.0
```

## ✅ Validation

Before submitting a new manifest:

1. Ensure all files use proper YAML syntax
2. Verify SHA256 hashes match the installer files
3. Test the manifest on a Windows machine if possible
4. Make sure installer URLs are accessible
5. Ensure both x64 and arm64 architectures are included
