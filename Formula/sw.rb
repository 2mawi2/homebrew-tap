class Sw < Formula
  desc "A fast project switcher for developers"
  homepage "https://github.com/2mawi2/switchr"
  url "https://github.com/2mawi2/switchr/archive/refs/tags/v0.1.6.tar.gz"
  sha256 "605e4140f3e1a75415c97b0b25307ce0f5a26b31c13a8bcc184b84bee4418951"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "sw", shell_output("#{bin}/sw --version")
  end
end
