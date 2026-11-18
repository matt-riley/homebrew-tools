# frozen_string_literal: true
# Managed by CI.
class Panda < Formula
  desc 'Modular Rust coding harness with a native macOS sandbox'
  homepage 'https://github.com/matt-riley/panda'
  version '0.1.12'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.12/panda_darwin_amd64.tar.gz'
      sha256 'b74d2e5d460334e2739a09cca0f710de8926b5f430b528fb4aa791683044d70c'
    end
    on_arm do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.12/panda_darwin_arm64.tar.gz'
      sha256 '62b14265491e623069d4b0e57dad8baf778a789ea8a33ce7b1957879bd2a9291'
    end
  end
  def install
    bin.install 'panda'
  end
  test do
    system bin/'panda', '--version'
  end
end
