class Para < Formula
  desc "Parallel IDE workflow helper for Git worktrees"
  homepage "https://github.com/2mawi2/para"
  url "https://github.com/2mawi2/para/archive/refs/tags/v1.0.17.tar.gz"
  sha256 "b20df505673e4c306de027eece56553ca87304e0cd04efb5c5dddb034ce66856"
  license "MIT"
  version "1.0.17"

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
