# typed: false
# frozen_string_literal: true

# Managed by CI - do not edit manually.
class Agit < Formula
  desc "AI-agent version control"
  homepage "https://github.com/matt-riley/agengit"
  version "1.25.1"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/matt-riley/agengit/releases/download/v1.25.1/agit-aarch64-macos.tar.gz"
      sha256 "b442a002780b7123fa0467e8835ff693b070fe03fc9b7ecb8aa57408a5e35748"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.25.1/agit-x86_64-macos.tar.gz"
      sha256 "ffc317defdc88aeed8db6cbbbb7fb2c2d750f485c54caaafb629d58e61930864"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/matt-riley/agengit/releases/download/v1.25.1/agit-aarch64-linux.tar.gz"
      sha256 "eaa681bf7e34024892389fc8ba717846743040a485d23abe6ddbac2079b383b4"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.25.1/agit-x86_64-linux.tar.gz"
      sha256 "5e844c48133bbff4638d4c16b7a98a102e2b9f72a37e9478e0b6988716f25ff4"
    end
  end

  def install
    bin.install "agit"
  end

  test do
    system bin/"agit", "version"
  end
end
