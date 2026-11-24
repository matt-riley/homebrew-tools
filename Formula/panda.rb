# frozen_string_literal: true
# Managed by CI.
class Panda < Formula
  desc 'Modular Rust coding harness with a native macOS sandbox'
  homepage 'https://github.com/matt-riley/panda'
  version '0.1.25'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.25/panda_darwin_amd64.tar.gz'
      sha256 'dab3a4bdba7b7264a64db42f8835596804e7915e817b79f0171cdff49d256e48'
    end
    on_arm do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.25/panda_darwin_arm64.tar.gz'
      sha256 '58463ad4ae95e74e504b60e7d949a06b9443313832ae9dc2daea6dda9de4aa89'
    end
  end
  def install
    bin.install 'panda'
  end
  test do
    system bin/'panda', '--version'
  end
end
