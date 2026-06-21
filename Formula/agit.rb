# typed: false
# frozen_string_literal: true

# Managed by CI - do not edit manually.
class Agit < Formula
  desc "AI-agent version control"
  homepage "https://github.com/matt-riley/agengit"
  version "1.23.0"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/matt-riley/agengit/releases/download/v1.23.0/agit-aarch64-macos.tar.gz"
      sha256 "d55b44d3ca36da2366ddf5c6ae9c34ee6b14163f725e778f8f5678fc80645fdd"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.23.0/agit-x86_64-macos.tar.gz"
      sha256 "a0aa86e626767d02951718a10ab79f41a4f3c3c6ed918c14ecc4fc452204d82d"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/matt-riley/agengit/releases/download/v1.23.0/agit-aarch64-linux.tar.gz"
      sha256 "0ffdf01109d8f54125832e93143e825ab5ab9bc3bbdd36c41904d341c60ffca0"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.23.0/agit-x86_64-linux.tar.gz"
      sha256 "4d61ba3670ec7dac095bfcdca4b12f49e1b400dc47fd0b2782ba743bc7b7a8f2"
    end
  end

  def install
    bin.install "agit"
  end

  test do
    system bin/"agit", "version"
  end
end
