# frozen_string_literal: true
# Managed by CI.
class Panda < Formula
  desc 'Modular Rust coding harness with a native macOS sandbox'
  homepage 'https://github.com/matt-riley/panda'
  version '0.1.11'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.11/panda_darwin_amd64.tar.gz'
      sha256 '315c78ecb37e7316d447651e7c2c422f7c8f09b41257297686df0f29f809c764'
    end
    on_arm do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.11/panda_darwin_arm64.tar.gz'
      sha256 '4ad2b644b19b2eb2ba5d4913b07f80b68e85a6093ac29fdff9e171fefc6d3cde'
    end
  end
  def install
    bin.install 'panda'
  end
  test do
    system bin/'panda', '--version'
  end
end
