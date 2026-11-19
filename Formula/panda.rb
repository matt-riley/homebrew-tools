# frozen_string_literal: true
# Managed by CI.
class Panda < Formula
  desc 'Modular Rust coding harness with a native macOS sandbox'
  homepage 'https://github.com/matt-riley/panda'
  version '0.1.14'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.14/panda_darwin_amd64.tar.gz'
      sha256 '8ede9a1d4300f4f09cad3edd5539913eaf6e07a9d63b0168735872998adc01e9'
    end
    on_arm do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.14/panda_darwin_arm64.tar.gz'
      sha256 '5e3e2804efee63ac8a294e552d5a2be04a16fd5b97ae4724ea766121a34249e6'
    end
  end
  def install
    bin.install 'panda'
  end
  test do
    system bin/'panda', '--version'
  end
end
