class Para < Formula
  desc "Parallel IDE workflow helper for Git worktrees"
  homepage "https://github.com/2mawi2/para"
  url "https://github.com/2mawi2/para/archive/refs/tags/v1.1.23.tar.gz"
  sha256 "7b5fddee51378b8b4f9565d6d264c96fed00136469e46a79760b7c9abd4258d1"
  license "MIT"

  depends_on "rust" => :build
  depends_on "node"

  def install
    # Build and install TypeScript MCP server
    cd "mcp-server-ts" do
      system "npm", "ci"
      system "npm", "run", "build"
      # Remove old wrapper script if it exists (for upgrades)
      rm_f bin/"para-mcp-server"
      # Create wrapper script for the MCP server
      (bin/"para-mcp-server").write <<~EOS
        #!/bin/bash
        exec node "#{libexec}/para-mcp-server.js" ""
      EOS
      chmod 0755, bin/"para-mcp-server"
      # Install the actual JavaScript file
      libexec.install "build/para-mcp-server.js"
    end
    
    # Install main para binary
    system "cargo", "install", *std_cargo_args
  end

  def caveats
    <<~EOS
      To enable shell completion, add this to your shell config:
      
      For bash:
        echo 'eval "$(para completion bash)"' >> ~/.bashrc
      
      For zsh:
        echo 'eval "$(para completion zsh)"' >> ~/.zshrc
      
      For fish:
        para completion fish | source
      
      To enable Para tools in Claude Code:
        cd your-project && para mcp init --claude-code
    EOS
  end

  test do
    assert_match "para", shell_output("#{bin}/para --version")
    system "#{bin}/para", "--help"
    # Test MCP server is installed
    assert_predicate bin/"para-mcp-server", :exist?
  end
end
