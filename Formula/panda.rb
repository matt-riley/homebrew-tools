# frozen_string_literal: true
# Managed by CI.
class Panda < Formula
  desc 'Modular Rust coding harness with a native macOS sandbox'
  homepage 'https://github.com/matt-riley/panda'
  version '0.1.19'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.19/panda_darwin_amd64.tar.gz'
      sha256 '98d9ccfb02db2af75eb9c93472de31fad94a6891e1c80f72bf87cd3cd5f07e83'
    end
    on_arm do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.19/panda_darwin_arm64.tar.gz'
      sha256 'a97b5e0d41836b509e59c44cecdfb0c979923e57517ad72e21b77c443889aa74'
    end
  end
  def install
    bin.install 'panda'
  end
  test do
    system bin/'panda', '--version'
  end
end
