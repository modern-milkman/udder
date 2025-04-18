---
name: Add New Tool
about: Use this template when adding a new tool to the repository
title: 'Add [TOOL NAME] to Udder'
labels: new-tool
---

## Tool Information

**Name:** <!-- Tool name -->
**Version:** <!-- Tool version -->
**Description:** <!-- Brief description of the tool -->

## Security Requirements Checklist

- [ ] Tool requires authentication or VPN access after installation
- [ ] Tool does not contain any sensitive information or secrets
- [ ] Tool binaries are digitally signed
- [ ] DEB packages include postinst script for authentication
- [ ] All architecture-specific binaries are provided

## Platforms Support

- [ ] Linux (amd64)
- [ ] Linux (arm64)
- [ ] macOS (x86_64/Intel)
- [ ] macOS (arm64/Apple Silicon)
- [ ] Windows (x64)
- [ ] Windows (arm64)

## Testing Checklist

- [ ] Tested installation on all supported platforms
- [ ] Verified authentication/VPN requirement works
- [ ] Run package validation workflows locally
- [ ] Verified security compliance
