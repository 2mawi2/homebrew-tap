class Sw < Formula
  desc "A fast project switcher for developers"
  homepage "https://github.com/2mawi2/switchr"
  url "https://github.com/2mawi2/switchr/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "d9abfc464edddbd351189a8dbb51d8e479296651bc235dc8ea36005cb3f04955"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "sw", shell_output("#{bin}/sw --version")
  end
end
