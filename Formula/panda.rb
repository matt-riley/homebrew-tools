# frozen_string_literal: true
# Managed by CI.
class Panda < Formula
  desc 'Modular Rust coding harness with a native macOS sandbox'
  homepage 'https://github.com/matt-riley/panda'
  version '0.1.0'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.0/panda_darwin_amd64.tar.gz'
      sha256 '01762ac7575cbf014fa5e61b16d711f8ce8f279706fd70acf3dd5c9d5753d8d4'
    end
    on_arm do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.0/panda_darwin_arm64.tar.gz'
      sha256 'f32f323c3818f19104f1124df8a9fdb902d37c76c20f0f5010a1b572abd5e41c'
    end
  end
  def install
    bin.install 'panda'
  end
  test do
    system bin/'panda', '--version'
  end
end
