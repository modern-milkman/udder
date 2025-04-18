# 🍺 Homebrew Formula

This directory contains Homebrew formulae for Modern Milkman internal tools.

## 📝 Formula Template

```ruby
class ToolName < Formula
  desc "Description of the tool"
  homepage "https://github.com/modern-milkman/udder"
  version "1.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/modern-milkman/udder/releases/download/tool-name-v#{version}/tool-name-#{version}-darwin-arm64.tar.gz"
      sha256 "sha256sum-here"
    end

    on_intel do
      url "https://github.com/modern-milkman/udder/releases/download/tool-name-v#{version}/tool-name-#{version}-darwin-x86_64.tar.gz"
      sha256 "sha256sum-here"
    end
  end

  def install
    bin.install "tool-name"
  end

  test do
    system "#{bin}/tool-name", "--version"
  end
end
```

## ➕ Adding a New Formula

1. Create a new Ruby file named after your tool
2. Follow the template above, updating all relevant fields
3. Build your tool for both Intel and Apple Silicon architectures
4. Calculate SHA256 sums for each archive
5. Test the formula locally before committing

## 🧪 Testing Your Formula Locally

```bash
# Install from the formula file
brew install --build-from-source ./Formula/your-tool.rb

# Uninstall the tool
brew uninstall your-tool

# Verify formula linting
brew audit --strict --online Formula/your-tool.rb
```
