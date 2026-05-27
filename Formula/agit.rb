# typed: false
# frozen_string_literal: true

# Managed by CI — do not edit manually.
class Agit < Formula
  desc "AI-agent version control"
  homepage "https://github.com/matt-riley/agengit"
  version "1.15.0"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/matt-riley/agengit/releases/download/v1.15.0/agit-aarch64-macos.tar.gz"
      sha256 "276c4cf4c1668e4fe37ca9b5519f44c9bd8dbb118628a4a70ca21b55e18f28e1"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.15.0/agit-x86_64-macos.tar.gz"
      sha256 "7c98e4fbaf530f8e004c238cdd09fefd1f9ffe3d05ced5bf8c6c425eaea69489"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/matt-riley/agengit/releases/download/v1.15.0/agit-aarch64-linux.tar.gz"
      sha256 "b00ee027605f928efd0a940a66de808f81f7057fa71143482e5d5a222a5e694e"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.15.0/agit-x86_64-linux.tar.gz"
      sha256 "e0e9a8ec8e8616df9b5534b91e8cceaf4a55b27fdc4407225b1c921165864c3e"
    end
  end

  def install
    bin.install "agit"
  end

  test do
    system bin/"agit", "version"
  end
end
