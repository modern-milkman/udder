class DemoTool < Formula
  desc "Demo tool for Modern Milkman internal use"
  homepage "https://github.com/modern-milkman/udder"
  version "1.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/modern-milkman/udder/releases/download/demo-tool-v#{version}/demo-tool-#{version}-darwin-arm64.tar.gz"
      sha256 "0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef"
    end

    on_intel do
      url "https://github.com/modern-milkman/udder/releases/download/demo-tool-v#{version}/demo-tool-#{version}-darwin-x86_64.tar.gz"
      sha256 "fedcba9876543210fedcba9876543210fedcba9876543210fedcba9876543210"
    end
  end

  def install
    bin.install "demo-tool"
  end

  test do
    system "#{bin}/demo-tool", "--version"
  end
end
