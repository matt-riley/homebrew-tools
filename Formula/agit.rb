# typed: false
# frozen_string_literal: true

# Managed by CI — do not edit manually.
class Agit < Formula
  desc "AI-agent version control"
  homepage "https://github.com/matt-riley/agengit"
  version "1.10.0"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/matt-riley/agengit/releases/download/v1.10.0/agit-aarch64-macos.tar.gz"
      sha256 "c020aa7a12a26a9f6a0d3f2361709fb51c2807fccb5c07ebe7b135dd06f858a5"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.10.0/agit-x86_64-macos.tar.gz"
      sha256 "f4462bc5c121329bd90d26dff052c1357c7249b1e214d50cc9079ed63b7f24c3"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/matt-riley/agengit/releases/download/v1.10.0/agit-aarch64-linux.tar.gz"
      sha256 "b419fa6ceaf27a57ef0540aca3c0797d96fcfafa3d4ae250c016d30f6c7d68db"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.10.0/agit-x86_64-linux.tar.gz"
      sha256 "313d8a0ab0664b48a83a67ae3b0666fc7be5bb8524e2e7fa5cbc027dd0bb984b"
    end
  end

  def install
    bin.install "agit"
  end

  test do
    system bin/"agit", "version"
  end
end
