# typed: false
# frozen_string_literal: true

# Managed by CI — do not edit manually.
class Agit < Formula
  desc "AI-agent version control"
  homepage "https://github.com/matt-riley/agengit"
  version "1.18.1"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/matt-riley/agengit/releases/download/v1.18.1/agit-aarch64-macos.tar.gz"
      sha256 "ec14343b0b484ca2d6ffe1e1258843856bb0e9e5c8a674d8d9407f533fae3832"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.18.1/agit-x86_64-macos.tar.gz"
      sha256 "8b5332f42b4e3635b3ded7b471d27e88e81bec99c067008fab02745be0b6793c"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/matt-riley/agengit/releases/download/v1.18.1/agit-aarch64-linux.tar.gz"
      sha256 "222f7792beb8dfaba0bcd5a2eab4acc8a8b5058b973df5620312b4c692c3f639"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.18.1/agit-x86_64-linux.tar.gz"
      sha256 "24c79164fe69832772c4f1c160c0622be3071aceb7b1d3220fef9315a35b3053"
    end
  end

  def install
    bin.install "agit"
  end

  test do
    system bin/"agit", "version"
  end
end
