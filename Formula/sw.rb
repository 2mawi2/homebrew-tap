class Sw < Formula
  desc "A fast project switcher for developers"
  homepage "https://github.com/2mawi2/switchr"
  url "https://github.com/2mawi2/switchr/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "ccc508c82ac1b0eecb4cc8484979abce9613b51626e492e55b5803dcec3b2667"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "sw", shell_output("#{bin}/sw --version")
  end
end
