# frozen_string_literal: true
# Managed by CI.
class Crap < Formula
  desc 'Change Risk Anti-Patterns (CRAP) scoring for TypeScript, Rust, Go and Lua'
  homepage 'https://github.com/matt-riley/crap'
  version '0.1.4'
  license 'MIT'
  on_macos do
    on_intel do
      url 'https://github.com/matt-riley/crap/releases/download/v0.1.4/crap_darwin_amd64.tar.gz'
      sha256 'b3492e75d29343ed4b51ce9f6381765b3d6efe5b7d51e47defd5179e7ace524d'
    end
    on_arm do
      url 'https://github.com/matt-riley/crap/releases/download/v0.1.4/crap_darwin_arm64.tar.gz'
      sha256 '618c622486e6425af458940761cd56275136711ff37126bc6af53c571c7d9c5c'
    end
  end
  on_linux do
    on_intel do
      url 'https://github.com/matt-riley/crap/releases/download/v0.1.4/crap_linux_amd64.tar.gz'
      sha256 '3a6eb89b38306279c2b4cfe1aae189f3c5d63cacd407c11c25741f2f60018f11'
    end
    on_arm do
      url 'https://github.com/matt-riley/crap/releases/download/v0.1.4/crap_linux_arm64.tar.gz'
      sha256 'e7439b5067c75560db515e762ed9a73798cce2f79bd21e9b9550d8703f6bbbfe'
    end
  end
  def install
    bin.install 'crap'
  end
  test do
    system bin/'crap', '--version'
  end
end
