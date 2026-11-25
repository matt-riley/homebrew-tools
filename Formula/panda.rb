# frozen_string_literal: true
# Managed by CI.
class Panda < Formula
  desc 'Modular Rust coding harness with a native macOS sandbox'
  homepage 'https://github.com/matt-riley/panda'
  version '0.1.26'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.26/panda_darwin_amd64.tar.gz'
      sha256 '473e412c6cc2a15a6d5ec351630379474668fda7170724105d2455f73a3295a7'
    end
    on_arm do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.26/panda_darwin_arm64.tar.gz'
      sha256 'd49772d1638742d5cd7193975c0ef156a3d3b73ebf520811b59e550b3e487eb7'
    end
  end
  def install
    bin.install 'panda'
  end
  test do
    system bin/'panda', '--version'
  end
end
