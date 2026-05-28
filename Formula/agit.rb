# typed: false
# frozen_string_literal: true

# Managed by CI — do not edit manually.
class Agit < Formula
  desc "AI-agent version control"
  homepage "https://github.com/matt-riley/agengit"
  version "1.16.0"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/matt-riley/agengit/releases/download/v1.16.0/agit-aarch64-macos.tar.gz"
      sha256 "ec14343b0b484ca2d6ffe1e1258843856bb0e9e5c8a674d8d9407f533fae3832"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.16.0/agit-x86_64-macos.tar.gz"
      sha256 "e0e4be510930d1cea0b9d75b775a8aa7429ebbff4e071a9aa4ab5c5c5ca9cbd7"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/matt-riley/agengit/releases/download/v1.16.0/agit-aarch64-linux.tar.gz"
      sha256 "46c65966b2f50257e228c1d9b3a5b51a1c0cbe334ea379e78c22297bd62033d8"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.16.0/agit-x86_64-linux.tar.gz"
      sha256 "3c951f71d11faf0cd8ea957979b4195c94ffbc93fec1257b6a74b7f70ee7d666"
    end
  end

  def install
    bin.install "agit"
  end

  test do
    system bin/"agit", "version"
  end
end
