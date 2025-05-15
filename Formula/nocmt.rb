class Nocmt < Formula
  desc "Tool for removing comments from source code while preserving structure"
  homepage "https://github.com/2mawi2/nocmt"
  url "https://github.com/2mawi2/nocmt/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "dfd76da713b167a468da1df0f9d9b400d81953c651bbaaef8785ea7fb335d846"
  license "MIT"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "1"
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.Version=1.0.3")
  end

  test do
    assert_match "nocmt version", shell_output("#{bin}/nocmt --version")
  end
end
