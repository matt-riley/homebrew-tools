# frozen_string_literal: true
# Managed by CI.
class Deadwood < Formula
  desc 'Unused file and dependency analysis for TypeScript, Rust, Go and Lua'
  homepage 'https://github.com/matt-riley/deadwood'
  version '0.1.2'
  license 'MIT'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/deadwood/releases/download/v0.1.2/deadwood_darwin_amd64.tar.gz'
      sha256 'abb1d2a72a1ac79ea07448bb4119cac8d1413c6e064ca86fb98522e5d637acc6'
    end
    on_arm do
      url 'https://github.com/matt-riley/deadwood/releases/download/v0.1.2/deadwood_darwin_arm64.tar.gz'
      sha256 '2edabbc2a0596ff64d2ea8aa8a68a978589ff151f7c4c5260e20e14493febe93'
    end
  end
  on_linux do
    on_intel do
      url 'https://github.com/matt-riley/deadwood/releases/download/v0.1.2/deadwood_linux_amd64.tar.gz'
      sha256 '97812e15a5b967925b958960711331d96b19a911cdaf56540e9f72d448b5b313'
    end
    on_arm do
      url 'https://github.com/matt-riley/deadwood/releases/download/v0.1.2/deadwood_linux_arm64.tar.gz'
      sha256 'ebab52cc3b899e9c9626a75223564841e59ee13a6456ffdf72c5ce0d04c1303c'
    end
  end
  def install
    bin.install 'deadwood'
  end
  test do
    system bin/'deadwood', '--version'
  end
end
