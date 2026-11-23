# frozen_string_literal: true
# Managed by CI.
class Panda < Formula
  desc 'Modular Rust coding harness with a native macOS sandbox'
  homepage 'https://github.com/matt-riley/panda'
  version '0.1.23'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.23/panda_darwin_amd64.tar.gz'
      sha256 '38e63df2079c17845cce8d4771ff4b8c2c1b0b3e7929a32eb19bf07cdab083fd'
    end
    on_arm do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.23/panda_darwin_arm64.tar.gz'
      sha256 '89f6381b23911148e2c05d0cd74a5865ea10b8349a9c5e1c6f6ff0ce5b153c93'
    end
  end
  def install
    bin.install 'panda'
  end
  test do
    system bin/'panda', '--version'
  end
end
