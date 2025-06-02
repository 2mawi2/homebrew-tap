class Nocmt < Formula
  desc "Tool for removing comments from source code while preserving structure"
  homepage "https://github.com/2mawi2/nocmt"
  url "https://github.com/2mawi2/nocmt/archive/refs/tags/v1.1.6.tar.gz"
  sha256 "5748802d98e16974caae72b6c4e342a9b152cdb1415e85987e174888afc94506"
  license "MIT"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "1"
    system "go", "build", *std_go_args(ldflags: "-s -w -X nocmt/internal/cli.Version=1.1.6"), "./cmd/nocmt"
  end

  test do
    assert_match "nocmt version", shell_output("#{bin}/nocmt --version")
  end
end
