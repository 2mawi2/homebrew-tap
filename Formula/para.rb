class Para < Formula
  desc "Parallel IDE workflow helper for Git worktrees"
  homepage "https://github.com/2mawi2/para"
  url "https://github.com/2mawi2/para/archive/refs/tags/v1.1.29.tar.gz"
  sha256 "1fa3cb01ab8a21a72ef83e0425827b475523e51f85955daa1b3f6e06183b8cc1"
  license "MIT"

  depends_on "rust" => :build
  depends_on "node"

  def install
    # Install main para binary first
    system "cargo", "install", *std_cargo_args
    
    # Build and install TypeScript MCP server with dependencies
    cd "mcp-server-ts" do
      system "npm", "ci"
      system "npm", "run", "build"
      
      # Install the MCP server and its node_modules to libexec
      libexec.install "build/para-mcp-server.js"
      libexec.install "node_modules"
      libexec.install "package.json"
      
      # Create wrapper script that sets up the environment
      (bin/"para-mcp-server").write <<~EOS
        #!/bin/bash
        export NODE_PATH="#{libexec}/node_modules"
        exec node "#{libexec}/para-mcp-server.js" ""
      EOS
      chmod 0755, bin/"para-mcp-server"
    end
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
    # Test MCP server is installed and executable
    assert_predicate bin/"para-mcp-server", :exist?
    assert_predicate bin/"para-mcp-server", :executable?
    # Test that MCP server can at least show its help/version
    system "#{bin}/para-mcp-server", "--help"
  end
end
