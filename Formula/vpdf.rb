class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261017042331"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-5904d690e5a11b06f75ec5678a878dde38e2c0a1/vpdf-macos-aarch64.tar.gz"
      sha256 "d47368fd0897b55ac688184fa10b7ee02f99a8b1dcac5f975a43561c6b78d9dc"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-5904d690e5a11b06f75ec5678a878dde38e2c0a1/vpdf-linux-x86_64.tar.gz"
      sha256 "bf5916b75a5cfa3da2d5e10d83c905c19675fb3fcac22623dfe42bf731d489df"
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
