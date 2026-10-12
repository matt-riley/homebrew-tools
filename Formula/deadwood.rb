# frozen_string_literal: true
# Managed by CI.
class Deadwood < Formula
  desc 'Unused file and dependency analysis for TypeScript, Rust, Go and Lua'
  homepage 'https://github.com/matt-riley/deadwood'
  version '0.1.1'
  license 'MIT'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/deadwood/releases/download/v0.1.1/deadwood_darwin_amd64.tar.gz'
      sha256 'ff9d8c17c6ddec6f5da1c75d1ef1e0e3fab492504c0bc75e709418d334a131a8'
    end
    on_arm do
      url 'https://github.com/matt-riley/deadwood/releases/download/v0.1.1/deadwood_darwin_arm64.tar.gz'
      sha256 'f9f4b5bc9e197f860a51d6701b9b5107a4482d6bacbcd205c9d841aaad2c285c'
    end
  end
  on_linux do
    on_intel do
      url 'https://github.com/matt-riley/deadwood/releases/download/v0.1.1/deadwood_linux_amd64.tar.gz'
      sha256 '99d53013948095cd8aa0f26e01f85dd974071572499e7e46b9e34c314ba71933'
    end
    on_arm do
      url 'https://github.com/matt-riley/deadwood/releases/download/v0.1.1/deadwood_linux_arm64.tar.gz'
      sha256 'cf87923e68d9e5897faa90d644b517fe7fbb70f0340c5fa4453e69383d64eb0e'
    end
  end
  def install
    bin.install 'deadwood'
  end
  test do
    system bin/'deadwood', '--version'
  end
end
