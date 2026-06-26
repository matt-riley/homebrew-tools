# typed: false
# frozen_string_literal: true

# Managed by CI - do not edit manually.
class Agit < Formula
  desc "AI-agent version control"
  homepage "https://github.com/matt-riley/agengit"
  version "1.25.0"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/matt-riley/agengit/releases/download/v1.25.0/agit-aarch64-macos.tar.gz"
      sha256 "6155685479e9388e4a86e508975ffa4c0e16c1e267f2abaf0acb5d478cf9d4be"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.25.0/agit-x86_64-macos.tar.gz"
      sha256 "6f0d77f92a4d3dedde180731bb0c63e628c1b4c84957973fe7662ca44d4038c3"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/matt-riley/agengit/releases/download/v1.25.0/agit-aarch64-linux.tar.gz"
      sha256 "f75ada2fb183b8d165c98d215b7fcadb94f1b33d426fba81489393399f7d0d09"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.25.0/agit-x86_64-linux.tar.gz"
      sha256 "72868fd421bf0efda4381e845a2164d9a9451a8222975416a2d306311bd68e9a"
    end
  end

  def install
    bin.install "agit"
  end

  test do
    system bin/"agit", "version"
  end
end
