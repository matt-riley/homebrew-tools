# typed: false
# frozen_string_literal: true

# Managed by CI - do not edit manually.
class Agit < Formula
  desc "AI-agent version control"
  homepage "https://github.com/matt-riley/agengit"
  version "1.24.0"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/matt-riley/agengit/releases/download/v1.24.0/agit-aarch64-macos.tar.gz"
      sha256 "24b54ed08d1784e3719ebcf74a8bff235093a4fd089f8a9719657604f7608047"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.24.0/agit-x86_64-macos.tar.gz"
      sha256 "4b2dd4255ca0242c383c913ecef12dacf7e79d444120f3e771f98a44ac60eb7a"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/matt-riley/agengit/releases/download/v1.24.0/agit-aarch64-linux.tar.gz"
      sha256 "e924a2c59490c40f6fb6022f4239d50529fe908f388dcccfdc973bd74e9043b6"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.24.0/agit-x86_64-linux.tar.gz"
      sha256 "4dc224fca3e59406cf44386d16ee76e1a420bb5ef9071bb55b89e0e2ac7186b9"
    end
  end

  def install
    bin.install "agit"
  end

  test do
    system bin/"agit", "version"
  end
end
