class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261028171627"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-219b569bc9a931d64cf8749906aba0d5ce2e2bce/vpdf-macos-aarch64.tar.gz"
      sha256 "a48817dbeb26a4eaaf03d990229c4330c7cecb2c335f9d8b4d5976c387d29b3b"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-219b569bc9a931d64cf8749906aba0d5ce2e2bce/vpdf-linux-x86_64.tar.gz"
      sha256 "248d6ef73486c1fa5c4a4ed61602711f8850d3f347fac3cb3c569b0796908425"
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
