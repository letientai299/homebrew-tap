class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261020023827"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-504c96676a7ce6eea6e8e7c0f271ea90f1039d0c/vpdf-macos-aarch64.tar.gz"
      sha256 "c9492104a787fec4f1668456ea6a08cafb4817534a469ec2b5c9522ecf54cd77"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-504c96676a7ce6eea6e8e7c0f271ea90f1039d0c/vpdf-linux-x86_64.tar.gz"
      sha256 "2658a8941117bbecb8f5db587cf473b80b0aa4e17b7d60f7a75442b763f0eb8c"
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
