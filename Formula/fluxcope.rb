class Fluxcope < Formula
  desc "A terminal HTTP and HTTPS debugging proxy with recording and request mapping"
  homepage "https://github.com/LorNtz/fluxcope"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/LorNtz/fluxcope/releases/download/v0.2.0/fluxcope-aarch64-apple-darwin.tar.xz"
      sha256 "561ac5ecfe2348a49010b67170fb0b7c636c612e2c733839ade0e41fbd105148"
    end
    if Hardware::CPU.intel?
      url "https://github.com/LorNtz/fluxcope/releases/download/v0.2.0/fluxcope-x86_64-apple-darwin.tar.xz"
      sha256 "b784a5b450306901ad5a2f285af12609fc53e37b252c4f591bba0416f93408ed"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/LorNtz/fluxcope/releases/download/v0.2.0/fluxcope-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "93b866eb09e32cc5a68a834ff6de03aaa5e59a84763424fc00733552dbdbe9a6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/LorNtz/fluxcope/releases/download/v0.2.0/fluxcope-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "07e2b7b140e36b40619499ff91330fc01a19597a4fe80c89a9203d423b9994cf"
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
