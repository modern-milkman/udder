# 🔄 GitHub Workflows

This directory contains CI/CD workflows for the Udder repository.

## 🛡️ Package Validation Workflow

The `validate-packages.yml` workflow automatically runs when:
- A pull request is created against the `main` branch
- Code is pushed to the `main` branch

### 🧪 Validation Steps

The workflow performs the following checks:

#### 🐧 APT Packages
- Validates the structure of all `.deb` packages
- Verifies package signatures
- Ensures correct file permissions

#### 🍎 Homebrew Formulas
- Validates Ruby syntax for all formula files
- Checks that SHA256 sums are provided for all architectures
- Verifies URLs point to valid resources

#### 🪟 WinGet Manifests
- Validates YAML syntax for all manifest files
- Ensures all required fields are present
- Verifies installer URLs for all architectures

#### 🌉 Cross-Platform Verification
- Ensures each tool has packages for all required architectures:
  - Linux: `amd64` (x86_64), `arm64`
  - macOS: `x86_64` (Intel), `arm64` (Apple Silicon)
  - Windows: `x86_64`, `arm64`

## 📤 Repository Update Workflow

The `update-repository.yml` workflow:
1. Automatically updates APT repository metadata when new packages are added
2. Signs the repository with the GPG key (if configured)
3. Deploys updates to GitHub Pages for the APT repository
4. Runs when changes are pushed to the `main` branch or manually triggered

To set up the GPG signing key:
1. Generate a GPG key pair if you don't already have one
2. Add the private key to GitHub Secrets as `APT_GPG_PRIVATE_KEY`
3. The public key will automatically be published to `docs/KEY.gpg`

## 🔐 Security Verification Workflow

The `security-check.yml` workflow:
1. Verifies that all binaries are properly signed
2. Checks for any sensitive information in package manifests
3. Ensures all packages require authentication or VPN access after installation
4. Runs on pull requests to main branch or when manually triggered

This workflow performs the following checks:
- Scans Debian packages for postinst scripts that implement authentication
- Checks binaries for proper digital signatures
- Scans repository files for potential sensitive information
- Reports findings as warnings or errors in the GitHub Actions interface