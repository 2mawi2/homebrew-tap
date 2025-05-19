class Nocmt < Formula
  desc "Tool for removing comments from source code while preserving structure"
  homepage "https://github.com/2mawi2/nocmt"
  url "https://github.com/2mawi2/nocmt/archive/refs/tags/v1.0.10.tar.gz"
  sha256 "4e6db8b8b4bf663d26ab6158bbb1292714fb2a43ff6ae9213904f46b1883c0a8"
  license "MIT"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "1"
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.Version=1.0.10")
  end

  test do
    assert_match "nocmt version", shell_output("#{bin}/nocmt --version")
  end
end
