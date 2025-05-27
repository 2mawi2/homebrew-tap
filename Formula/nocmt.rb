class Nocmt < Formula
  desc "Tool for removing comments from source code while preserving structure"
  homepage "https://github.com/2mawi2/nocmt"
  url "https://github.com/2mawi2/nocmt/archive/refs/tags/v1.1.4.tar.gz"
  sha256 "c9c94f00d7f631d682f242727ab092501ad3b7c4f83b159d3c5267a39b3e4ab4"
  license "MIT"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "1"
    system "go", "build", *std_go_args(ldflags: "-s -w -X nocmt/internal/cli.Version=1.1.4"), "./cmd/nocmt"
  end

  test do
    assert_match "nocmt version", shell_output("#{bin}/nocmt --version")
  end
end
