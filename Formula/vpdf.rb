class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261028011713"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-87516d4ed293b472681e4b777c02832893a5e9a8/vpdf-macos-aarch64.tar.gz"
      sha256 "49952266f36aa2b66069551307587dbec438a2ff79a5b1b011f01c27015e8547"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-87516d4ed293b472681e4b777c02832893a5e9a8/vpdf-linux-x86_64.tar.gz"
      sha256 "fe0d4d63e5246f805bb8548135f9c0ce27ce41d32b3c3ef18738fa4860de70ff"
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
