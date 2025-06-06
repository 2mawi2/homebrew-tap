class Para < Formula
  desc "Parallel IDE workflow helper for Git worktrees"
  homepage "https://github.com/2mawi2/para"
  url "https://github.com/2mawi2/para/archive/refs/tags/v1.0.13.tar.gz"
  sha256 "be4e84069a83a259fc4c5f5682f6bcde46c69ede9b2f89863498bfe4d7bcd294"
  license "MIT"
  version "1.0.13"

  def install
    # Install the para script and libraries
    libexec.install "para.sh"
    libexec.install "lib"
    
    # Create wrapper script
    (bin/"para").write <<~EOS
      #!/usr/bin/env sh
      exec "#{libexec}/para.sh" "$@"
    EOS
    
    # Make wrapper executable
    chmod 0755, bin/"para"
  end

  test do
    system "#{bin}/para", "--help"
  end
end
