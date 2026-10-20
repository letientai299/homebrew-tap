class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261020024538"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-f9190cff3ecdfbc94e2cc970cc229baa32592e33/vpdf-macos-aarch64.tar.gz"
      sha256 "d65e21be7389d13b4069eadfaedb85c01a581c062949812d0d9395d679807f37"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-f9190cff3ecdfbc94e2cc970cc229baa32592e33/vpdf-linux-x86_64.tar.gz"
      sha256 "c2cd1dc0d4d30480b06470729f12cdb436245a491f5e4fa30b7dc98ceddd6b2d"
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
