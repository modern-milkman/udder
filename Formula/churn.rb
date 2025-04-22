#!/usr/bin/env ruby

class Churn < Formula
	desc "ModernMilkman Churn development tools"
	homepage "https://github.com/modern-milkman/churn"
	version "nightly-16"

	on_macos do
		on_intel do
			url "https://github.com/modern-milkman/udder/brew/churn/churn_amd64_#{version}.tar.gz"
			sha256 "67a851b206aed639becd5a9f8c377f3fc117fe7ae3c1ef6e7df57432f6f837d5"
		end
		on_arm do
			url "https://github.com/modern-milkman/udder/brew/churn/churn_arm64_#{version}.tar.gz"
			sha256 "3240d41f0a9d5f6829e512da6d78ee6a238a0b7f87e964d1b05e26a15db02ce9"
		end
	end

	def install
		bin.install "churn"
	end
end
