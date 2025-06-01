class Sw < Formula
  desc "A fast project switcher for developers"
  homepage "https://github.com/2mawi2/switchr"
  url "https://github.com/2mawi2/switchr/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "d7537b3bc8c7bf3074fb3a45f09a9cb55bbe7eef3ddf664a3e2ad927e90f2c79"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "sw", shell_output("#{bin}/sw --version")
  end
end
