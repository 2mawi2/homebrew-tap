class Nocmt < Formula
  desc "Tool for removing comments from source code while preserving structure"
  homepage "https://github.com/2mawi2/nocmt"
  url "https://github.com/2mawi2/nocmt/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "64f94e802f3beab9b8d76c70d8601e85163bc2de5048bf393a03d2085de1c646"
  license "MIT"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "1"
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.Version=0.1.0")
  end

  test do
    assert_match "nocmt version", shell_output("#{bin}/nocmt --version")
  end
end
