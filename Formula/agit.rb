# typed: false
# frozen_string_literal: true

# Managed by CI — do not edit manually.
class Agit < Formula
  desc "AI-agent version control"
  homepage "https://github.com/matt-riley/agengit"
  version "1.12.0"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/matt-riley/agengit/releases/download/v1.12.0/agit-aarch64-macos.tar.gz"
      sha256 "d5ca5ea74dba9fdad78c0437e664c0f71f22cc4a0eb08a9c37d372c290b5ac44"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.12.0/agit-x86_64-macos.tar.gz"
      sha256 "aada7775585daa0b392aba398cd721ae0c9bfb1b7fe1b7d81d62189228da4705"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/matt-riley/agengit/releases/download/v1.12.0/agit-aarch64-linux.tar.gz"
      sha256 "12edd545d4b41c49eb61097dc2d49a9d6a32fcfa4ddbbd420f5ae09dfbcb10d6"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.12.0/agit-x86_64-linux.tar.gz"
      sha256 "bc1ca5a3791dddf9e3c8c4c46a1f36fafae7e8e176bb180ec9fb1da578f724aa"
    end
  end

  def install
    bin.install "agit"
  end

  test do
    system bin/"agit", "version"
  end
end
