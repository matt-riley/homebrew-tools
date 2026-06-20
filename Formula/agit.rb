# typed: false
# frozen_string_literal: true

# Managed by CI - do not edit manually.
class Agit < Formula
  desc "AI-agent version control"
  homepage "https://github.com/matt-riley/agengit"
  version "1.22.2"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/matt-riley/agengit/releases/download/v1.22.2/agit-aarch64-macos.tar.gz"
      sha256 "d1a907253b57e64b5a297722cb0e7a60d3a010790925b7bef3dab098a48cb499"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.22.2/agit-x86_64-macos.tar.gz"
      sha256 "15c53d3909525bc830fa13f4bb0f46cc1368c6898a93046cffbeba91cf2b35be"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/matt-riley/agengit/releases/download/v1.22.2/agit-aarch64-linux.tar.gz"
      sha256 "9d505d08807e75e229437fcf54730ceaf497f4cb97db6220a8ea0d8e134e36d4"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.22.2/agit-x86_64-linux.tar.gz"
      sha256 "16fef8177dd4ade8d43d04a851868ae6f74b309f0c6087073f9cd52f4886b977"
    end
  end

  def install
    bin.install "agit"
  end

  test do
    system bin/"agit", "version"
  end
end
