# frozen_string_literal: true
# Managed by CI.
class Panda < Formula
  desc 'Modular Rust coding harness with a native macOS sandbox'
  homepage 'https://github.com/matt-riley/panda'
  version '0.1.4'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.4/panda_darwin_amd64.tar.gz'
      sha256 '116ca42da59a626d3a538b90c04dd0182305295c566c9a332bbf61300effc448'
    end
    on_arm do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.4/panda_darwin_arm64.tar.gz'
      sha256 'b9d578724768dd14abf8953d9db9688683820b49aa1c0ae1cd3df4a91c1a05bb'
    end
  end
  def install
    bin.install 'panda'
  end
  test do
    system bin/'panda', '--version'
  end
end
