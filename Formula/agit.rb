# typed: false
# frozen_string_literal: true

# Managed by CI — do not edit manually.
class Agit < Formula
  desc "AI-agent version control"
  homepage "https://github.com/matt-riley/agengit"
  version "1.11.0"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/matt-riley/agengit/releases/download/v1.11.0/agit-aarch64-macos.tar.gz"
      sha256 "d294dcef1261058406bd89953ba0ce431187d80d60fd94004530192f007dc309"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.11.0/agit-x86_64-macos.tar.gz"
      sha256 "552b0cf17ecf98147be144086bd9bacddf336e0b548d4b3b29524856d027ee3f"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/matt-riley/agengit/releases/download/v1.11.0/agit-aarch64-linux.tar.gz"
      sha256 "970734215d03029db1c7ab2bf0b9197e0160ce71bbcaa2c40ca077ad9a975e03"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.11.0/agit-x86_64-linux.tar.gz"
      sha256 "ba85a0691122dc4ee87c3001124abf9952b71839529ca5ef42054563620af118"
    end
  end

  def install
    bin.install "agit"
  end

  test do
    system bin/"agit", "version"
  end
end
