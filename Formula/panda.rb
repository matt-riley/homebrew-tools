# frozen_string_literal: true
# Managed by CI.
class Panda < Formula
  desc 'Modular Rust coding harness with a native macOS sandbox'
  homepage 'https://github.com/matt-riley/panda'
  version '0.1.9'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.9/panda_darwin_amd64.tar.gz'
      sha256 '4fcedcd107471c5105e908a05ad015b2f25172c3c547319349985b034c28c08c'
    end
    on_arm do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.9/panda_darwin_arm64.tar.gz'
      sha256 '3bfa65f5768f8c280e1373afb8a6da12372a0d1417f29a9f97ff0644a0704459'
    end
  end
  def install
    bin.install 'panda'
  end
  test do
    system bin/'panda', '--version'
  end
end
