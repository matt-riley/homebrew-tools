# typed: false
# frozen_string_literal: true

# Managed by CI — do not edit manually.
class Agit < Formula
  desc "AI-agent version control"
  homepage "https://github.com/matt-riley/agengit"
  version "1.11.1"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/matt-riley/agengit/releases/download/v1.11.1/agit-aarch64-macos.tar.gz"
      sha256 "af3bd7e010a286df165647ffe0722535aa3df9cb44adfbb44a8cc74fe5624ae1"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.11.1/agit-x86_64-macos.tar.gz"
      sha256 "76bca3fe93f6851d3d84f23f7014ac77022f9a8300144bc36d1f0c935af44260"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/matt-riley/agengit/releases/download/v1.11.1/agit-aarch64-linux.tar.gz"
      sha256 "5b767498f5cc17b5176f46004c488e2b0b1b3f10435a632f769dc1e2223ae3e4"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.11.1/agit-x86_64-linux.tar.gz"
      sha256 "86e2747f3515309a28cc9535ac54e173d4a71c4b7e6eb9525ad3437ee69d4829"
    end
  end

  def install
    bin.install "agit"
  end

  test do
    system bin/"agit", "version"
  end
end
