# frozen_string_literal: true
# Managed by CI.
class Panda < Formula
  desc 'Modular Rust coding harness with a native macOS sandbox'
  homepage 'https://github.com/matt-riley/panda'
  version '0.1.2'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.2/panda_darwin_amd64.tar.gz'
      sha256 '016996268f731a48bc09ab87ef6f36b5055423840e2ae556b723998d8eaf5f97'
    end
    on_arm do
      url 'https://github.com/matt-riley/panda/releases/download/v0.1.2/panda_darwin_arm64.tar.gz'
      sha256 '8f1d5693a5c0f4fb15ccfd228e51d8a2df6f91becf47ef04ca77d9e4fbee62ef'
    end
  end
  def install
    bin.install 'panda'
  end
  test do
    system bin/'panda', '--version'
  end
end
