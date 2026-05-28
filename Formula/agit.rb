# typed: false
# frozen_string_literal: true

# Managed by CI — do not edit manually.
class Agit < Formula
  desc "AI-agent version control"
  homepage "https://github.com/matt-riley/agengit"
  version "1.17.0"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/matt-riley/agengit/releases/download/v1.17.0/agit-aarch64-macos.tar.gz"
      sha256 "ec14343b0b484ca2d6ffe1e1258843856bb0e9e5c8a674d8d9407f533fae3832"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.17.0/agit-x86_64-macos.tar.gz"
      sha256 "930d6eddf3169a5366dba6b1eccb457ea418cc5b9073016a2903938d506e8bc7"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/matt-riley/agengit/releases/download/v1.17.0/agit-aarch64-linux.tar.gz"
      sha256 "5d2baebf416bc20c237750f2595387205b9596456a06b6a544f11269c029d44f"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.17.0/agit-x86_64-linux.tar.gz"
      sha256 "e91775c5db5ac3ce4a025351b02d9a6291652091f572bcccb386aa3b1838a43c"
    end
  end

  def install
    bin.install "agit"
  end

  test do
    system bin/"agit", "version"
  end
end
