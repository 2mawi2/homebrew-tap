class Para < Formula
  desc "Parallel IDE workflow helper for Git worktrees"
  homepage "https://github.com/2mawi2/para"
  url "https://github.com/2mawi2/para/archive/refs/tags/v1.0.8.tar.gz"
  sha256 "ae31dd5b2767e433ec5e8dde243d8537968426579a563a1b1db3f212b6b61e3c"
  license "MIT"
  version "1.0.8"

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
