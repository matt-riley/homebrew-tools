# typed: false
# frozen_string_literal: true

# Managed by CI — do not edit manually.
class Agit < Formula
  desc "AI-agent version control"
  homepage "https://github.com/matt-riley/agengit"
  version "1.13.0"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/matt-riley/agengit/releases/download/v1.13.0/agit-aarch64-macos.tar.gz"
      sha256 "47359a8f3d6db2ff15afb16082ca9d1cc84268bd25e9ea26ac6a721c6ecff19b"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.13.0/agit-x86_64-macos.tar.gz"
      sha256 "22c62a848ef84a5b5333d508b262551f2edce92007c7bf20a06c6b455730c6e7"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/matt-riley/agengit/releases/download/v1.13.0/agit-aarch64-linux.tar.gz"
      sha256 "6d3697008425b6cbddec6a7857a4683d9853fed5fc2b45770f8a807e7c3a32b3"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.13.0/agit-x86_64-linux.tar.gz"
      sha256 "7edc8d35ba140213fd8dd34b04394059ea8e561a856adf7a85d3cacb2a044a2b"
    end
  end

  def install
    bin.install "agit"
  end

  test do
    system bin/"agit", "version"
  end
end
