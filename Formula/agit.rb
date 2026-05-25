# typed: false
# frozen_string_literal: true

# Managed by CI — do not edit manually.
class Agit < Formula
  desc "AI-agent version control"
  homepage "https://github.com/matt-riley/agengit"
  version "1.9.0"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/matt-riley/agengit/releases/download/v1.9.0/agit-aarch64-macos.tar.gz"
      sha256 "ff99fd31f47752118a4a6d68d63e099662358628ea2bfce727514b77a0fc4514"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.9.0/agit-x86_64-macos.tar.gz"
      sha256 "74363e7e43f7e80e4e8659e91ee2727667528ba3786c52e65e16289073db14c4"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/matt-riley/agengit/releases/download/v1.9.0/agit-aarch64-linux.tar.gz"
      sha256 "6316382e327e56e08b0d817d0f162629324e46f7c912e1ad0408c1c1315a6717"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.9.0/agit-x86_64-linux.tar.gz"
      sha256 "271596aa4901f715352d2011b2f62d48adfc9ab515806d9988a698943f720236"
    end
  end

  def install
    bin.install "agit"
  end

  test do
    system bin/"agit", "version"
  end
end
