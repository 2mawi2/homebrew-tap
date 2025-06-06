class Para < Formula
  desc "Parallel IDE workflow helper for Git worktrees"
  homepage "https://github.com/2mawi2/para"
  url "https://github.com/2mawi2/para/archive/refs/tags/v1.0.14.tar.gz"
  sha256 "cdd6fd55e23317dde0158b2e1d939bd4f322b8c910c0c8ef9c3135041f653743"
  license "MIT"
  version "1.0.14"

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
