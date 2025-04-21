---
layout: default
---

# 🌐 GitHub Pages for Modern Milkman Udder

This directory contains files for the GitHub Pages site that provides documentation and access to the APT repository.

## 📂 Directory Structure

- `_config.yml` - Jekyll configuration file
- `index.md` - Main page content
- `images/` - Directory for images and assets
- `KEY.gpg` - GPG public key for the APT repository

## 🧩 Jekyll Configuration

The site uses the "architect" Jekyll theme with configuration to prevent Jekyll from processing the APT repository files, which would break the repository functionality.

## 🚨 Important Notes

- Do not modify or delete the `.nojekyll` files in the root and apt directories
- The `_config.yml` file includes exclusions for the APT repository
- The GitHub Actions workflow ensures the site is deployed correctly
