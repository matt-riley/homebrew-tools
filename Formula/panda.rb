# frozen_string_literal: true
# Managed by CI.
class Panda < Formula
  desc 'Modular Rust coding harness with a native macOS sandbox'
  homepage 'https://github.com/matt-riley/panda'
  version '0.1.18'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.18/panda_darwin_amd64.tar.gz'
      sha256 '124e86f8d92ab4917408549c48c9502a0412a57534591c0e66b08d2a7afcd5e9'
    end
    on_arm do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.18/panda_darwin_arm64.tar.gz'
      sha256 'a78430000586b9b9068af541fa3f114285663191d3d15ac543c998dd71e9d215'
    end
  end
  def install
    bin.install 'panda'
  end
  test do
    system bin/'panda', '--version'
  end
end
