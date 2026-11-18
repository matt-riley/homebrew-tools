# frozen_string_literal: true
# Managed by CI.
class Panda < Formula
  desc 'Modular Rust coding harness with a native macOS sandbox'
  homepage 'https://github.com/matt-riley/panda'
  version '0.1.1'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.1/panda_darwin_amd64.tar.gz'
      sha256 'b1f3145af407784c203fa1e67f88bc031faf972c5c4589441e65c3ab25c5ed23'
    end
    on_arm do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.1/panda_darwin_arm64.tar.gz'
      sha256 'b8ddcb167b51458ae21b851aa8718bd4d34c682e1d5bff2ed90b41f5944fbd73'
    end
  end
  def install
    bin.install 'panda'
  end
  test do
    system bin/'panda', '--version'
  end
end
