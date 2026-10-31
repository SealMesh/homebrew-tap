class SealmeshMcp < Formula
  desc "The MCP server a coding agent mounts over stdio to reach sealmesh — Claude Code and Codex both"
  homepage "https://github.com/SealMesh/sealmesh"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/SealMesh/sealmesh/releases/download/v0.1.0/sealmesh-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "9954b406320933081cd18da52ad4135fef2c2a0820bb64a54f8adbf4bdcf9b50"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SealMesh/sealmesh/releases/download/v0.1.0/sealmesh-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "88fce9d4b44807936a9616d7b1489b2d4b3968a444d8a6508b9f03e99e1de972"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/SealMesh/sealmesh/releases/download/v0.1.0/sealmesh-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f143b29f391649d21d42deb34e0c18fafe4b90cee5627a5e366c2f263aa42d90"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SealMesh/sealmesh/releases/download/v0.1.0/sealmesh-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8a2fefbf574da6a891e896120907af30b45304bd53911016a447de72e98bf120"
    end
  end
  license "AGPL-3.0-only"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "sealmesh-mcp"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "sealmesh-mcp"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "sealmesh-mcp"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "sealmesh-mcp"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
