#!/usr/bin/env ruby

class Churn < Formula
	desc "ModernMilkman Churn development tools"
	homepage "https://github.com/modern-milkman/churn"
	version "nightly-17"

	on_macos do
		on_intel do
			url "https://github.com/modern-milkman/udder/raw/refs/heads/main/brew/churn/churn_x86_64_nightly-17.tar.gz"
			sha256 "3f525d04b1da0ae13a5aeb92779ae73242d112904761576aa2c4bf456ced4961"
		end
		on_arm do
			url "https://github.com/modern-milkman/udder/raw/refs/heads/main/brew/churn/churn_arm64_nightly-17.tar.gz"
			sha256 "82f65a75ba6c32c6e8f64ed0eaf14b23387c1737fd80673a6d99e7d7f72b6b86"
		end
	end

	def install
		bin.install "churn"
	end
end
