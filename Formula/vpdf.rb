class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261023160555"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-be4873cb4d6b99077c6e7479337d5cb49d05c588/vpdf-macos-aarch64.tar.gz"
      sha256 "206c5d4923299be9deffa77744aecbd48a5a015963b94109a8b68dc9d81d9a63"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-be4873cb4d6b99077c6e7479337d5cb49d05c588/vpdf-linux-x86_64.tar.gz"
      sha256 "1ce039f1ecef5c3de07138d9a75cbe44733f82efcbfb7e7d614fcd3e6f9960ec"
    end
  end

  def install
    bin.install "vpdf"
  end

  test do
    metadata = JSON.parse(shell_output("#{bin}/vpdf info #{test_fixtures("test.pdf")}"))
    assert_equal 1, metadata.fetch("pages").length
  end
end
