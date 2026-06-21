# typed: false
# frozen_string_literal: true

# Managed by CI - do not edit manually.
class Agit < Formula
  desc "AI-agent version control"
  homepage "https://github.com/matt-riley/agengit"
  version "1.22.3"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/matt-riley/agengit/releases/download/v1.22.3/agit-aarch64-macos.tar.gz"
      sha256 "188a278bd6286eb0c76901d23067eb3b652c43fe0ed20ebdb74aacf05259b396"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.22.3/agit-x86_64-macos.tar.gz"
      sha256 "57bd70e7f935824e826014f1a60e6db7303a26a8a8bce02d47f0010560869bbd"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/matt-riley/agengit/releases/download/v1.22.3/agit-aarch64-linux.tar.gz"
      sha256 "7a93702383a1b5bfa5df8d0825a5dd7fbc565953297f0a9cf65634d6328e2d4d"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.22.3/agit-x86_64-linux.tar.gz"
      sha256 "63c1f4a3b3fab0fa501069b5c38bedb7eb79c8a316abbb99ed0ea968f11c653e"
    end
  end

  def install
    bin.install "agit"
  end

  test do
    system bin/"agit", "version"
  end
end
