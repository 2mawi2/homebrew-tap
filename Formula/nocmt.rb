class Nocmt < Formula
  desc "Tool for removing comments from source code while preserving structure"
  homepage "https://github.com/2mawi2/nocmt"
  url "https://github.com/2mawi2/nocmt/archive/refs/tags/v1.1.2.tar.gz"
  sha256 "f321f958ba61bc1b754f2b4f35554a5b3e5e255424989a72b74c7c6898dc86e6"
  license "MIT"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "1"
    system "go", "build", *std_go_args(ldflags: "-s -w -X nocmt/internal/cli.Version=1.1.2"), "./cmd/nocmt"
  end

  test do
    assert_match "nocmt version", shell_output("#{bin}/nocmt --version")
  end
end
