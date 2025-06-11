class Para < Formula
  desc "Parallel IDE workflow helper for Git worktrees"
  homepage "https://github.com/2mawi2/para"
  url "https://github.com/2mawi2/para/archive/refs/tags/v1.1.2.tar.gz"
  sha256 "6c5ee171966ee45b9e9ac0261817d105f255b0ccfd75e0cd45217077913fbe7a"
  license "MIT"

  depends_on "rust" => :build

  def install
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
    EOS
  end

  test do
    assert_match "para", shell_output("#{bin}/para --version")
    system "#{bin}/para", "--help"
  end
end
