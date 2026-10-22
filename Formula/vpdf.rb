class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261022115520"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-05994c0c83f7df0f10f04976a1834cdf4bfab6e3/vpdf-macos-aarch64.tar.gz"
      sha256 "8ad4cd0b487c765ce2f9f5faadc1166a356e0e89b1805e892a6e990f2343ae8d"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-05994c0c83f7df0f10f04976a1834cdf4bfab6e3/vpdf-linux-x86_64.tar.gz"
      sha256 "aa96ef3ed8b40ae7030bcf10724c7ef556c3105b54125eeaade96486d44e03a6"
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
