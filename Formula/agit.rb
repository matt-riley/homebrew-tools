# typed: false
# frozen_string_literal: true

# Managed by CI - do not edit manually.
class Agit < Formula
  desc "AI-agent version control"
  homepage "https://github.com/matt-riley/agengit"
  version "1.21.4"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/matt-riley/agengit/releases/download/v1.21.4/agit-aarch64-macos.tar.gz"
      sha256 "a82cff507bf4444debdcf2034e3dbe04cfc34ff54e6c376906d7aedcd01cea73"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.21.4/agit-x86_64-macos.tar.gz"
      sha256 "8d0d17d736280804ae5267c558d706b59c3be8f2d898a4d3a41187030e1c3d97"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/matt-riley/agengit/releases/download/v1.21.4/agit-aarch64-linux.tar.gz"
      sha256 "1c903f372891c8f6823d9fe9b6e636f63cfe74401a5d71b18aa7d8c04602aae6"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.21.4/agit-x86_64-linux.tar.gz"
      sha256 "0b90df13434f375f611cd76133943177b1b630417ac60200dc63688210e90806"
    end
  end

  def install
    bin.install "agit"
  end

  test do
    system bin/"agit", "version"
  end
end
