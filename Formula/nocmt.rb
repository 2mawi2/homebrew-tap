class Nocmt < Formula
  desc "Tool for removing comments from source code while preserving structure"
  homepage "https://github.com/2mawi2/nocmt"
  url "https://github.com/2mawi2/nocmt/archive/refs/tags/v1.1.5.tar.gz"
  sha256 "00202f86dbc1a8d383a96d004962accbb08f9d7dacec626888d407f09cafe7d3"
  license "MIT"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "1"
    system "go", "build", *std_go_args(ldflags: "-s -w -X nocmt/internal/cli.Version=1.1.5"), "./cmd/nocmt"
  end

  test do
    assert_match "nocmt version", shell_output("#{bin}/nocmt --version")
  end
end
