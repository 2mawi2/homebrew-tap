class Nocmt < Formula
  desc "Tool for removing comments from source code while preserving structure"
  homepage "https://github.com/2mawi2/nocmt"
  url "https://github.com/2mawi2/nocmt/archive/refs/tags/v1.0.7.tar.gz"
  sha256 "cf8a3ed688d7f64dbab6689822e299354853cc2bf3b6f49c76bfaebca4d5699c"
  license "MIT"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "1"
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.Version=1.0.7")
  end

  test do
    assert_match "nocmt version", shell_output("#{bin}/nocmt --version")
  end
end
