# frozen_string_literal: true
# Managed by CI.
class Crap < Formula
  desc 'Change Risk Anti-Patterns (CRAP) scoring for TypeScript, Rust, Go and Lua'
  homepage 'https://github.com/matt-riley/crap'
  version '0.1.3'
  license 'MIT'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/crap/releases/download/v0.1.3/crap_darwin_amd64.tar.gz'
      sha256 '867bff8905cba92220cef061004f06e211f1ddd3a7168e11d7b06cbe08f3b707'
    end
    on_arm do
      url 'https://github.com/matt-riley/crap/releases/download/v0.1.3/crap_darwin_arm64.tar.gz'
      sha256 'd86ca6c195ba1033cefdd34403d25d7e7845263f960941efe1fedd6446ffecea'
    end
  end
  on_linux do
    on_intel do
      url 'https://github.com/matt-riley/crap/releases/download/v0.1.3/crap_linux_amd64.tar.gz'
      sha256 '91263ec4ebb3bf4ae43292994f3fcbba7d62cb256c6e59ee4f1e2e4ac76b372b'
    end
    on_arm do
      url 'https://github.com/matt-riley/crap/releases/download/v0.1.3/crap_linux_arm64.tar.gz'
      sha256 'f4fa2fb952c23cb1b36b7e3659e53f58640564a55e46c02273c8a90896687a75'
    end
  end
  def install
    bin.install 'crap'
  end
  test do
    system bin/'crap', '--version'
  end
end
