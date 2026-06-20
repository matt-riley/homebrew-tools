# typed: false
# frozen_string_literal: true

# Managed by CI - do not edit manually.
class Agit < Formula
  desc "AI-agent version control"
  homepage "https://github.com/matt-riley/agengit"
  version "1.22.0"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/matt-riley/agengit/releases/download/v1.22.0/agit-aarch64-macos.tar.gz"
      sha256 "0d56a8ba8e3b814055bd9de60d681eb374db63bd8329b5f3421a8e060e4ef08c"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.22.0/agit-x86_64-macos.tar.gz"
      sha256 "e4cd64f59ee61c713365595da2b0e03c19b1feca4eeec9c93412edc729adf26c"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/matt-riley/agengit/releases/download/v1.22.0/agit-aarch64-linux.tar.gz"
      sha256 "4a5ede2852cb4b21cc0bdc2850123a90041b65f653c25ac663f0af6039145aa9"
    else
      url "https://github.com/matt-riley/agengit/releases/download/v1.22.0/agit-x86_64-linux.tar.gz"
      sha256 "6653019859a598adecba853e5adf44608e5c490b565e4d30f1f014745900417a"
    end
  end

  def install
    bin.install "agit"
  end

  test do
    system bin/"agit", "version"
  end
end
