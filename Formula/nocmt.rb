class Nocmt < Formula
  desc "Tool for removing comments from source code while preserving structure"
  homepage "https://github.com/2mawi2/nocmt"
  version "0.1.0" # This will be updated by the GitHub workflow
  license "MIT"

  # These will be updated by the release workflow
  url "https://github.com/2mawi2/nocmt.git", tag: "v0.1.0"
  
  depends_on "go" => :build

  def install
    # Build from source
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.Version=#{version}")
  end

  test do
    assert_match "nocmt version", shell_output("#{bin}/nocmt --version")
  end
end
