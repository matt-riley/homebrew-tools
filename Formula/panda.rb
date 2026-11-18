# frozen_string_literal: true
# Managed by CI.
class Panda < Formula
  desc 'Modular Rust coding harness with a native macOS sandbox'
  homepage 'https://github.com/matt-riley/panda'
  version '0.1.8'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.8/panda_darwin_amd64.tar.gz'
      sha256 'dc157ed553d05d24b561913e66999658a1a447507eba073632267ab3a44653f4'
    end
    on_arm do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.8/panda_darwin_arm64.tar.gz'
      sha256 '11b7c057a1660c501142df097ddf8699836dc9d31db9f0ae2124ea837a23767f'
    end
  end
  def install
    bin.install 'panda'
  end
  test do
    system bin/'panda', '--version'
  end
end
