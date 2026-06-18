# typed: false
# frozen_string_literal: true

# Managed by CI - do not edit manually.
class Agit < Formula
  desc "AI-agent version control"
  homepage "https://github.com/matt-riley/agengit"
  version "1.21.5"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/matt-riley/agengit/releases/download/v1.21.5/agit-aarch64-macos.tar.gz"
      sha256 "3cdbb87690a541e32bf9561722abee9b71abf38998ab1872186b0b5af3f2f2ec"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.21.5/agit-x86_64-macos.tar.gz"
      sha256 "90e5c8c64ec901212b3be8f36a027a19f2c8f54fbaaa4a2439a99029963c02a6"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/matt-riley/agengit/releases/download/v1.21.5/agit-aarch64-linux.tar.gz"
      sha256 "588e60b551b3aa15d3892063daf427b5265556318fd38065254a71581a4c703b"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.21.5/agit-x86_64-linux.tar.gz"
      sha256 "1f401f8122f89db2e4e2c4513cfed18c4d718029be1c11bac2b8b3e8ac72c473"
    end
  end

  def install
    bin.install "agit"
  end

  test do
    system bin/"agit", "version"
  end
end
