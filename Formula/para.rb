class Para < Formula
  desc "Parallel IDE workflow helper for Git worktrees"
  homepage "https://github.com/2mawi2/para"
  url "https://github.com/2mawi2/para/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "235dc5ef17563f99497a1c42a813ab8b38666b529114f865b0eac4e419c19e65"
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
