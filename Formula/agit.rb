# typed: false
# frozen_string_literal: true

# Managed by CI - do not edit manually.
class Agit < Formula
  desc "AI-agent version control"
  homepage "https://github.com/matt-riley/agengit"
  version "1.22.1"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/matt-riley/agengit/releases/download/v1.22.1/agit-aarch64-macos.tar.gz"
      sha256 "171e19394861598903cf7d5d16bfa0dd0932da137ad9833639ab0b7d467dfa44"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.22.1/agit-x86_64-macos.tar.gz"
      sha256 "d2b1c9079b0fd0a12d3ce891b7c96dded9dcc43fe9f5fc2f5383bd949cd2ce8e"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/matt-riley/agengit/releases/download/v1.22.1/agit-aarch64-linux.tar.gz"
      sha256 "73cfd7ca0b1a472421d39c92bebb45af9eaf0590a78a1f604aef2a7bb086db51"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.22.1/agit-x86_64-linux.tar.gz"
      sha256 "82815d75d02abec91a0b6f0212f36fdc557e016ad0351de3ee551d4f9587b5e6"
    end
  end

  def install
    bin.install "agit"
  end

  test do
    system bin/"agit", "version"
  end
end
