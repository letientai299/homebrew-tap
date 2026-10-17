class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261017160542"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-8f114c97b7a33c8404d32f99ae5d17252dd2dda2/vpdf-macos-aarch64.tar.gz"
      sha256 "53e11fd429c1c20b494a2d9d9c145a75f2f7e88d31c6459fe2b3ddf7dd7697c0"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-8f114c97b7a33c8404d32f99ae5d17252dd2dda2/vpdf-linux-x86_64.tar.gz"
      sha256 "dd03f48b4a4855c336127211837fcab0af3008b687366f9f6b21b0bcc81d20fd"
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
