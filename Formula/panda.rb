# frozen_string_literal: true
# Managed by CI.
class Panda < Formula
  desc 'Modular Rust coding harness with a native macOS sandbox'
  homepage 'https://github.com/matt-riley/panda'
  version '0.1.21'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.21/panda_darwin_amd64.tar.gz'
      sha256 'c2a151610d46143254a81a299009378be776e596a46d58ba736a63a6636b947e'
    end
    on_arm do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.21/panda_darwin_arm64.tar.gz'
      sha256 '5304421f78f64edf5cc245a266d875459f7c99ff9bfe9a7b918a0c4577355a6c'
    end
  end
  def install
    bin.install 'panda'
  end
  test do
    system bin/'panda', '--version'
  end
end
