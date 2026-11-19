# frozen_string_literal: true
# Managed by CI.
class Panda < Formula
  desc 'Modular Rust coding harness with a native macOS sandbox'
  homepage 'https://github.com/matt-riley/panda'
  version '0.1.16'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.16/panda_darwin_amd64.tar.gz'
      sha256 'c3e3469b1324cd2a8cdd84a3b56f2e5358d23cbded97098bbd728f90324c48a0'
    end
    on_arm do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.16/panda_darwin_arm64.tar.gz'
      sha256 '31091643d18d901fd124ad47bd23ebfbb82dcdacd9b286350eaf03b8e22699ca'
    end
  end
  def install
    bin.install 'panda'
  end
  test do
    system bin/'panda', '--version'
  end
end
