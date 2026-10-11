# frozen_string_literal: true
# Managed by CI.
class Crap < Formula
  desc 'Change Risk Anti-Patterns (CRAP) scoring for TypeScript, Rust, Go and Lua'
  homepage 'https://github.com/matt-riley/crap'
  version '0.1.5'
  license 'MIT'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/crap/releases/download/v0.1.5/crap_darwin_amd64.tar.gz'
      sha256 'ab0ee6bd28c42483a902919544012ac3403e781719518af0e83860edb2072f0d'
    end
    on_arm do
      url 'https://github.com/matt-riley/crap/releases/download/v0.1.5/crap_darwin_arm64.tar.gz'
      sha256 '3a5b50eb3d7903ce8a44dc8c607969f8f5dd83ee9b7e6714ea421b2b7a7e2cdf'
    end
  end
  on_linux do
    on_intel do
      url 'https://github.com/matt-riley/crap/releases/download/v0.1.5/crap_linux_amd64.tar.gz'
      sha256 '89fad800c4e2682eed38591f2b897dda92d5c7279aaf79deda787c824bcd61da'
    end
    on_arm do
      url 'https://github.com/matt-riley/crap/releases/download/v0.1.5/crap_linux_arm64.tar.gz'
      sha256 'f78745718511f1a0b07e3ebda84d825a2af7a21b0a3e9e75ba903e533ff03e34'
    end
  end
  def install
    bin.install 'crap'
  end
  test do
    system bin/'crap', '--version'
  end
end
