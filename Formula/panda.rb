# frozen_string_literal: true
# Managed by CI.
class Panda < Formula
  desc 'Modular Rust coding harness with a native macOS sandbox'
  homepage 'https://github.com/matt-riley/panda'
  version '0.1.24'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.24/panda_darwin_amd64.tar.gz'
      sha256 'd435b88e3a95052eb5e1562de8e6e25de8f27a8787f8450937102079717e5b23'
    end
    on_arm do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.24/panda_darwin_arm64.tar.gz'
      sha256 '3b22ebf5a0e20b741ee20a8c36ecf66dcbc4e0a955ea1b96fe9e66f6677cd8a0'
    end
  end
  def install
    bin.install 'panda'
  end
  test do
    system bin/'panda', '--version'
  end
end
