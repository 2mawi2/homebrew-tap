class Sw < Formula
  desc "A fast project switcher for developers"
  homepage "https://github.com/2mawi2/switchr"
  url "https://github.com/2mawi2/switchr/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "49400aa179854baeec46ba2cdeb616205809fba123e4e48d8a4b23dd829fe77d"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "sw", shell_output("#{bin}/sw --version")
  end
end
