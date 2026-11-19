# frozen_string_literal: true
# Managed by CI.
class Panda < Formula
  desc 'Modular Rust coding harness with a native macOS sandbox'
  homepage 'https://github.com/matt-riley/panda'
  version '0.1.13'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.13/panda_darwin_amd64.tar.gz'
      sha256 'cdb2223f3a324cbfa261054f80a63979a4c55a91042729609d825095049e623e'
    end
    on_arm do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.13/panda_darwin_arm64.tar.gz'
      sha256 '3b104dbba80478f0545fc9a1481bb2739e4aa129f4e65ccc673f2e5e039c9473'
    end
  end
  def install
    bin.install 'panda'
  end
  test do
    system bin/'panda', '--version'
  end
end
