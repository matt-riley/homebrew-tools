# frozen_string_literal: true
# Managed by CI.
class Panda < Formula
  desc 'Modular Rust coding harness with a native macOS sandbox'
  homepage 'https://github.com/matt-riley/panda'
  version '0.1.6'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.6/panda_darwin_amd64.tar.gz'
      sha256 'a6b477258371fe0a7581d804e4fb99902d63fbc37635219d3d770eb90bbe2eac'
    end
    on_arm do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.6/panda_darwin_arm64.tar.gz'
      sha256 'a66a9604ad1d0c5f2e7b6ec74bd9d1e71e2adc4d1e49ccb7c7b22c9551e6e298'
    end
  end
  def install
    bin.install 'panda'
  end
  test do
    system bin/'panda', '--version'
  end
end
