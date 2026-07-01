# typed: false
# frozen_string_literal: true

# Managed by CI - do not edit manually.
class Agit < Formula
  desc "AI-agent version control"
  homepage "https://github.com/matt-riley/agengit"
  version "1.26.0"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/matt-riley/agengit/releases/download/v1.26.0/agit-aarch64-macos.tar.gz"
      sha256 "3ab7d4c39bc9e67fdbccd58d6171a1aedbf5d4e7efc7da05a53feba21eaeff83"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.26.0/agit-x86_64-macos.tar.gz"
      sha256 "78c6d793c75ef1d4c0b2541588479dcf948ba00218138196c937b245539cbaad"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/matt-riley/agengit/releases/download/v1.26.0/agit-aarch64-linux.tar.gz"
      sha256 "fbad0cc68bd1d7f2611f974314ab571ec5899a43aca71ba8062a5caf95f247f3"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.26.0/agit-x86_64-linux.tar.gz"
      sha256 "5b427c40e0e79d70e476c971a78a14654b7e50aaccfa1da56631b548d6a77e1a"
    end
  end

  def install
    bin.install "agit"
  end

  test do
    system bin/"agit", "version"
  end
end
