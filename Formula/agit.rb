# typed: false
# frozen_string_literal: true

# Managed by CI - do not edit manually.
class Agit < Formula
  desc "AI-agent version control"
  homepage "https://github.com/matt-riley/agengit"
  version "1.26.2"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/matt-riley/agengit/releases/download/v1.26.2/agit-aarch64-macos.tar.gz"
      sha256 "2915fb616d26a3f97326ee75cb20faf1a73202d9d1fbfcc17989a1b5e919dc5a"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.26.2/agit-x86_64-macos.tar.gz"
      sha256 "65f849766200b325b63f9a041f3a203630d631887f93aa0ec9d9688683df6c39"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/matt-riley/agengit/releases/download/v1.26.2/agit-aarch64-linux.tar.gz"
      sha256 "f8ed96b3ca39e6a074e0620c3650af1c6c51cdd5c5e2f200f98ef2ed078b28c5"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.26.2/agit-x86_64-linux.tar.gz"
      sha256 "8660b31661d412ac01398bb6a1f2b5d6de7e9e66b9cd39b656d6af1ed7a00968"
    end
  end

  def install
    bin.install "agit"
  end

  test do
    system bin/"agit", "version"
  end
end
