class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261022100920"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-f4a239ecef1195909aedd7e67fbdc3c092f5a9c2/vpdf-macos-aarch64.tar.gz"
      sha256 "6acd7f088f4925035d2c971932433d8fcfc65aee30857f5ba19e02aed05f7fd9"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-f4a239ecef1195909aedd7e67fbdc3c092f5a9c2/vpdf-linux-x86_64.tar.gz"
      sha256 "2eca30edf639609760b0c7e7f5021aab3dcf36643f728697a71e34deedb66d01"
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
