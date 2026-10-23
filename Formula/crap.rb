# frozen_string_literal: true
# Managed by CI.
class Crap < Formula
  desc 'Change Risk Anti-Patterns (CRAP) scoring for TypeScript, Rust, Go and Lua'
  homepage 'https://github.com/matt-riley/crap'
  version '0.1.6'
  license 'MIT'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/crap/releases/download/v0.1.6/crap_darwin_amd64.tar.gz'
      sha256 '240fee98fba239f39a96c0dc0bd4c04b4d07c9738a776a2916b7aac79dcdf1bb'
    end
    on_arm do
      url 'https://github.com/matt-riley/crap/releases/download/v0.1.6/crap_darwin_arm64.tar.gz'
      sha256 'cc0b43fdc891a46304d68a3f30383a2972c33acef61c7cb7b743844e9c2cd1f6'
    end
  end
  on_linux do
    on_intel do
      url 'https://github.com/matt-riley/crap/releases/download/v0.1.6/crap_linux_amd64.tar.gz'
      sha256 'a0691ba36e0edfebb642a2994458f9c04b474f597e5ae8a324b3c6ec33ab4215'
    end
    on_arm do
      url 'https://github.com/matt-riley/crap/releases/download/v0.1.6/crap_linux_arm64.tar.gz'
      sha256 'b46d3f0db0da90daad5c34a8353f2115a0d570532235dad17e6742ab9450c960'
    end
  end
  def install
    bin.install 'crap'
  end
  test do
    system bin/'crap', '--version'
  end
end
