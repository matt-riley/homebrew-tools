# frozen_string_literal: true
# Managed by CI.
class Panda < Formula
  desc 'Modular Rust coding harness with a native macOS sandbox'
  homepage 'https://github.com/matt-riley/panda'
  version '0.1.20'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.20/panda_darwin_amd64.tar.gz'
      sha256 '779e84744a5ddd69d08b8f6d89ea0ac8a3a0930ec743b2aff1b39f2a15f86d84'
    end
    on_arm do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.20/panda_darwin_arm64.tar.gz'
      sha256 'bc1116ba0e9f3d7597686d4acc0b025cd4bd8ec700ba174e8c18ad7d331a8cee'
    end
  end
  def install
    bin.install 'panda'
  end
  test do
    system bin/'panda', '--version'
  end
end
