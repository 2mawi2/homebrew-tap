class Nocmt < Formula
  desc "Tool for removing comments from source code while preserving structure"
  homepage "https://github.com/2mawi2/nocmt"
  url "https://github.com/2mawi2/nocmt/archive/refs/tags/v1.1.7.tar.gz"
  sha256 "1ef2987b3899fdbaf3f3413363b7cbe2c74b41f7ca80653746c1767e79e1e36e"
  license "MIT"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "1"
    system "go", "build", *std_go_args(ldflags: "-s -w -X nocmt/internal/cli.Version=1.1.7"), "./cmd/nocmt"
  end

  test do
    assert_match "nocmt version", shell_output("#{bin}/nocmt --version")
  end
end
