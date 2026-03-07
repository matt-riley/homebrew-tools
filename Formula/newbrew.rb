# typed: false
# frozen_string_literal: true

class Newbrew < Formula
  desc "Browse and inspect new Homebrew formulae from your terminal"
  homepage "https://github.com/matt-riley/newbrew"
  version "0.1.2"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/matt-riley/newbrew/releases/download/v0.1.2/newbrew_0.1.2_darwin_amd64.tar.gz"
      sha256 "4083e544eb897e42066b11867357ad3b26d6799b3ced02317ea96542dec01c65"

      def install
        bin.install "newbrew"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/matt-riley/newbrew/releases/download/v0.1.2/newbrew_0.1.2_darwin_arm64.tar.gz"
      sha256 "7bdd43500e1f0d688090ca17ed4b12e9a35cebcfc01b2301211ba3afb473c93e"

      def install
        bin.install "newbrew"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/matt-riley/newbrew/releases/download/v0.1.2/newbrew_0.1.2_linux_amd64.tar.gz"
      sha256 "85d51f36370d003f48ecc58396abf83add946b52b62244979f4c9b4719695713"

      def install
        bin.install "newbrew"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/matt-riley/newbrew/releases/download/v0.1.2/newbrew_0.1.2_linux_arm64.tar.gz"
      sha256 "36666fbb9940121f1f651504c40cb7e2ab6e5508b91d8d1785ab44eb2140cf3a"

      def install
        bin.install "newbrew"
      end
    end
  end
end
