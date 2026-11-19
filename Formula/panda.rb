# frozen_string_literal: true
# Managed by CI.
class Panda < Formula
  desc 'Modular Rust coding harness with a native macOS sandbox'
  homepage 'https://github.com/matt-riley/panda'
  version '0.1.17'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.17/panda_darwin_amd64.tar.gz'
      sha256 '37ec7b2b924b81c9a804b11603ce364d1297f1ef547682bbea1f4da1b1d4f423'
    end
    on_arm do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.17/panda_darwin_arm64.tar.gz'
      sha256 '572ab21de127cf564a094ce8348fa3e3ca0b9951dcddde34ea1cb91f61aa8e7f'
    end
  end
  def install
    bin.install 'panda'
  end
  test do
    system bin/'panda', '--version'
  end
end
