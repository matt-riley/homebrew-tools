# typed: false
# frozen_string_literal: true

# Managed by CI — do not edit manually.
class Agit < Formula
  desc "AI-agent version control"
  homepage "https://github.com/matt-riley/agengit"
  version "1.18.2"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/matt-riley/agengit/releases/download/v1.18.2/agit-aarch64-macos.tar.gz"
      sha256 "e16f0479d57cfce898c4a6874deb5e2b49422de3e4c97967726d629a5c95e678"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.18.2/agit-x86_64-macos.tar.gz"
      sha256 "99f756d904fb10b1b0f8e72b86114e3597410ec4c2852023e06270950199cfcd"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/matt-riley/agengit/releases/download/v1.18.2/agit-aarch64-linux.tar.gz"
      sha256 "fabe9e724027c647f5c14ab69f5de16a517c7095d754054bb32fa8b8ad2e5c13"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.18.2/agit-x86_64-linux.tar.gz"
      sha256 "eb555cef462d4643130b39b802af12579fb6ecb976d66496d56526f6be31f56d"
    end
  end

  def install
    bin.install "agit"
  end

  test do
    system bin/"agit", "version"
  end
end
