class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261020032725"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-6f19ab5372e8beef69c315e018ca981e0eff8505/vpdf-macos-aarch64.tar.gz"
      sha256 "15abd02cea4db8f5b2d11a8c204ea95a8eb170b57cf9f2a2122156a740b5a859"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-6f19ab5372e8beef69c315e018ca981e0eff8505/vpdf-linux-x86_64.tar.gz"
      sha256 "aa9efbff77f648ec71321fd819b29e4571448f66aa8063c68960bc4ebdfdbdfa"
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
