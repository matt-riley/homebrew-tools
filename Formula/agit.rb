# typed: false
# frozen_string_literal: true

# Managed by CI — do not edit manually.
class Agit < Formula
  desc "AI-agent version control"
  homepage "https://github.com/matt-riley/agengit"
  version "1.20.0"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/matt-riley/agengit/releases/download/v1.20.0/agit-aarch64-macos.tar.gz"
      sha256 "1698c371c7686e6f468075529d7be1ac33052d1190cba19eb5e65b5b966ce7a6"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.20.0/agit-x86_64-macos.tar.gz"
      sha256 "c6c63c008da0612ca2792cc35b8979c0ef61e08e8252452c4ed41b82ea0d1b9d"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/matt-riley/agengit/releases/download/v1.20.0/agit-aarch64-linux.tar.gz"
      sha256 "c0fbccccfb00c8fb5b34d044d6b0688384e6cb0c2962824d3a23b9820fd51e10"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.20.0/agit-x86_64-linux.tar.gz"
      sha256 "a14cd0f2c5f6bd6fed3b7afa1fe5dba0415d977b0215bcc67e77ae615c56d247"
    end
  end

  def install
    bin.install "agit"
  end

  test do
    system bin/"agit", "version"
  end
end
