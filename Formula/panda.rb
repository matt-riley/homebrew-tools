# frozen_string_literal: true
# Managed by CI.
class Panda < Formula
  desc 'Modular Rust coding harness with a native macOS sandbox'
  homepage 'https://github.com/matt-riley/panda'
  version '0.1.15'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.15/panda_darwin_amd64.tar.gz'
      sha256 '0ece48e6060e078d3f7f449632ef49c16d36ba7031f484c524e6ef5f0687de0c'
    end
    on_arm do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.15/panda_darwin_arm64.tar.gz'
      sha256 '041a0cb7999e8240367f18de69150f4225c0c3c336836b9a5a58ea43d5f3d019'
    end
  end
  def install
    bin.install 'panda'
  end
  test do
    system bin/'panda', '--version'
  end
end
