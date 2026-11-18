# frozen_string_literal: true
# Managed by CI.
class Panda < Formula
  desc 'Modular Rust coding harness with a native macOS sandbox'
  homepage 'https://github.com/matt-riley/panda'
  version '0.1.5'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.5/panda_darwin_amd64.tar.gz'
      sha256 'e4d85c6316893d9dfccba00ac3370bdf81685c70006cf9acf756c8023846c0e2'
    end
    on_arm do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.5/panda_darwin_arm64.tar.gz'
      sha256 '56c42be2fe5d3718fb77d24e8f66aa6c283186434fdd333d422c558cf1883ba2'
    end
  end
  def install
    bin.install 'panda'
  end
  test do
    system bin/'panda', '--version'
  end
end
