# frozen_string_literal: true
# Managed by CI.
class Panda < Formula
  desc 'Modular Rust coding harness with a native macOS sandbox'
  homepage 'https://github.com/matt-riley/panda'
  version '0.1.7'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.7/panda_darwin_amd64.tar.gz'
      sha256 'ce6a0352d623147c765945d93c404e090c3c1085e00795c7df06142692f3e231'
    end
    on_arm do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.7/panda_darwin_arm64.tar.gz'
      sha256 'e0f715112ccf82d452d1f7dc1f0a972a64bd0703c0c1fc61f42eb43eb21bff31'
    end
  end
  def install
    bin.install 'panda'
  end
  test do
    system bin/'panda', '--version'
  end
end
