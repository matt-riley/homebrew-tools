# frozen_string_literal: true
# Managed by CI.
class Crap < Formula
  desc 'Change Risk Anti-Patterns (CRAP) scoring for TypeScript, Rust, Go and Lua'
  homepage 'https://github.com/matt-riley/crap'
  version '0.1.2'
  license 'MIT'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/crap/releases/download/v0.1.2/crap_darwin_amd64.tar.gz'
      sha256 '4057351ab69ff40b63d2eb3cc0fed86a1afaa22b4b68bdc3a3cf7c8ddc8d229c'
    end
    on_arm do
      url 'https://github.com/matt-riley/crap/releases/download/v0.1.2/crap_darwin_arm64.tar.gz'
      sha256 '5e8098282ecade414853857ed59eb419d4393321de258715a06a682b37ff9790'
    end
  end
  on_linux do
    on_intel do
      url 'https://github.com/matt-riley/crap/releases/download/v0.1.2/crap_linux_amd64.tar.gz'
      sha256 '465465e2bc8241c8e7d9e7f8c5518fb7d27d9923c76c6e735fe22593f3bd4a0a'
    end
    on_arm do
      url 'https://github.com/matt-riley/crap/releases/download/v0.1.2/crap_linux_arm64.tar.gz'
      sha256 'c2b8762b246c34d75de8ddb8024ce5f976b796cefc50f1b7506afd913c4cb1ee'
    end
  end
  def install
    bin.install 'crap'
  end
  test do
    system bin/'crap', '--version'
  end
end
