# typed: false
# frozen_string_literal: true

# Managed by CI — do not edit manually.
class Agit < Formula
  desc "AI-agent version control"
  homepage "https://github.com/matt-riley/agengit"
  version "1.19.0"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/matt-riley/agengit/releases/download/v1.19.0/agit-aarch64-macos.tar.gz"
      sha256 "cfb8ca07c52f49a1320170a49779836d5dafcd8904aaa611f44e934f0ecfee63"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.19.0/agit-x86_64-macos.tar.gz"
      sha256 "25807fe1e892f12b8f971c66cb914b27715c227a7d34402cc2dfcea4513bc05e"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/matt-riley/agengit/releases/download/v1.19.0/agit-aarch64-linux.tar.gz"
      sha256 "4dfd0e1f397f0ee57890c84f80a0780ee11a401233482cdf557f98efaf1cd449"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.19.0/agit-x86_64-linux.tar.gz"
      sha256 "cf142c53bfadc6d1adad1e6e0eac4c3098fbbd141f8dcad616338a0e8d03da3a"
    end
  end

  def install
    bin.install "agit"
  end

  test do
    system bin/"agit", "version"
  end
end
