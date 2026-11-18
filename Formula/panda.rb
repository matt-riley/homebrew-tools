# frozen_string_literal: true
# Managed by CI.
class Panda < Formula
  desc 'Modular Rust coding harness with a native macOS sandbox'
  homepage 'https://github.com/matt-riley/panda'
  version '0.1.3'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.3/panda_darwin_amd64.tar.gz'
      sha256 'd23ff8e3944845b48fdbef9e6408e708751224a3b13a73f98bd978d8365376ce'
    end
    on_arm do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.3/panda_darwin_arm64.tar.gz'
      sha256 '2715726e5d3b4e0df5f3e898f06ff62e5b39ba441f5b7b9bde7dbd4447d3bca7'
    end
  end
  def install
    bin.install 'panda'
  end
  test do
    system bin/'panda', '--version'
  end
end
