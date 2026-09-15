class Fluxcope < Formula
  desc "A terminal HTTP and HTTPS debugging proxy with recording and request mapping"
  homepage "https://github.com/LorNtz/fluxcope"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/LorNtz/fluxcope/releases/download/v0.1.0/fluxcope-aarch64-apple-darwin.tar.xz"
      sha256 "dfb9158ccc1d87d0ad67880b7ba2532906729fb153c00398907aacba8fccc6f7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/LorNtz/fluxcope/releases/download/v0.1.0/fluxcope-x86_64-apple-darwin.tar.xz"
      sha256 "542ba40b43604c80560b0e18615fb32efe47585dab172d4bf30a775550ac7fac"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/LorNtz/fluxcope/releases/download/v0.1.0/fluxcope-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5385d7c16072c4e1ef768c9d8a61cbfd8ae99c19d199ea55f29f7103250add92"
    end
    if Hardware::CPU.intel?
      url "https://github.com/LorNtz/fluxcope/releases/download/v0.1.0/fluxcope-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e3dee9de4baca07f88d91b567a2310e06477577ad25dc42d2b356aa0fd756b09"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-unknown-linux-gnu": {}
  }

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
      bin.install "fluxcope"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "fluxcope"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "fluxcope"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "fluxcope"
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
