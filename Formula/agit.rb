# typed: false
# frozen_string_literal: true

# Managed by CI - do not edit manually.
class Agit < Formula
  desc "AI-agent version control"
  homepage "https://github.com/matt-riley/agengit"
  version "1.26.1"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/matt-riley/agengit/releases/download/v1.26.1/agit-aarch64-macos.tar.gz"
      sha256 "f1ca3a5685a8e3e4bff8df347be37cc40371ee939441af0dfcba3ffd5849445d"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.26.1/agit-x86_64-macos.tar.gz"
      sha256 "d9eb68204d5c43ff79d319c719a76c8a30f734e3aa94b988ad489068d3a827fe"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/matt-riley/agengit/releases/download/v1.26.1/agit-aarch64-linux.tar.gz"
      sha256 "f1102479466d07315c404aedf70d89ac5bba5ce0191aaad7f61e77cdea8b16bf"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.26.1/agit-x86_64-linux.tar.gz"
      sha256 "354240aee1e90f39dcc1ce6334c7f6d55c2c6d7d3b0c0664fe65c945b59ed5d1"
    end
  end

  def install
    bin.install "agit"
  end

  test do
    system bin/"agit", "version"
  end
end
