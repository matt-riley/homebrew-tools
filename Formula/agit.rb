# typed: false
# frozen_string_literal: true

# Managed by CI — do not edit manually.
class Agit < Formula
  desc "AI-agent version control"
  homepage "https://github.com/matt-riley/agengit"
  version "1.20.1"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/matt-riley/agengit/releases/download/v1.20.1/agit-aarch64-macos.tar.gz"
      sha256 "9257261d8a2e13a04d6f72567757799a8919d88556ced6489d8f743daf624337"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.20.1/agit-x86_64-macos.tar.gz"
      sha256 "d52a5623942db1b056c8116ffa611af0892090832d901d878b76444605e13543"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/matt-riley/agengit/releases/download/v1.20.1/agit-aarch64-linux.tar.gz"
      sha256 "5a72f24cc7424f25e0bdf22b444ff23265d47708bd93d90f212d648e00c82b7c"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.20.1/agit-x86_64-linux.tar.gz"
      sha256 "eacd3bb10224d2ad1c6200a3092088e30f1ef0d87404b4c42e24ac7c63ebfc12"
    end
  end

  def install
    bin.install "agit"
  end

  test do
    system bin/"agit", "version"
  end
end
