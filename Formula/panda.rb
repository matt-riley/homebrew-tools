# frozen_string_literal: true
# Managed by CI.
class Panda < Formula
  desc 'Modular Rust coding harness with a native macOS sandbox'
  homepage 'https://github.com/matt-riley/panda'
  version '0.1.10'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.10/panda_darwin_amd64.tar.gz'
      sha256 'f39dc3d7f099f88b770aad900e442bd87b9cdb52e307c4a678023933805f599a'
    end
    on_arm do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.10/panda_darwin_arm64.tar.gz'
      sha256 '3a110f6c286d372d224c05e39a02d461dc06b0cedb223f90477dfe0a71360816'
    end
  end
  def install
    bin.install 'panda'
  end
  test do
    system bin/'panda', '--version'
  end
end
