# frozen_string_literal: true
# Managed by CI.
class Panda < Formula
  desc 'Modular Rust coding harness with a native macOS sandbox'
  homepage 'https://github.com/matt-riley/panda'
  version '0.1.22'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.22/panda_darwin_amd64.tar.gz'
      sha256 '03e050a50bdcb7d932e9ecaaac14f27d6ff816fc69e5beff5668c8e478a73e0b'
    end
    on_arm do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.22/panda_darwin_arm64.tar.gz'
      sha256 'fd428fffd2f8169aa0369aacd967f867e2d3069a468a391dc804a0f01cf2f628'
    end
  end
  def install
    bin.install 'panda'
  end
  test do
    system bin/'panda', '--version'
  end
end
