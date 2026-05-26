# typed: false
# frozen_string_literal: true

# Managed by CI — do not edit manually.
class Agit < Formula
  desc "AI-agent version control"
  homepage "https://github.com/matt-riley/agengit"
  version "1.14.0"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/matt-riley/agengit/releases/download/v1.14.0/agit-aarch64-macos.tar.gz"
      sha256 "0d616f307bbecde76a88bff1f53b6bfa8266821ce13d6ff131b67c71a8f74984"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.14.0/agit-x86_64-macos.tar.gz"
      sha256 "12f214dbb4827272e4e026188b3e6a3bb3de79652b0397523f5537e10ba13237"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/matt-riley/agengit/releases/download/v1.14.0/agit-aarch64-linux.tar.gz"
      sha256 "e1609449cd33b373532c3834a663960544596980637a2383475a32aea7001081"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.14.0/agit-x86_64-linux.tar.gz"
      sha256 "344f9221c2f81eca81900e4189b7c3b9c36cd86d810b7f330ae0ad8a84aeb5bb"
    end
  end

  def install
    bin.install "agit"
  end

  test do
    system bin/"agit", "version"
  end
end
