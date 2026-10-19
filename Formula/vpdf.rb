class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261019024748"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-2ddd3796fb804aefe270c726602a36174f454b22/vpdf-macos-aarch64.tar.gz"
      sha256 "8b309dd0f94d88e0186036f1d5cd88efbb97b2238a4c0375d478648d106f4e07"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-2ddd3796fb804aefe270c726602a36174f454b22/vpdf-linux-x86_64.tar.gz"
      sha256 "71219918b56dbbf613a6d476f1860bd9963d3f163a3c91221259005230010a80"
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
