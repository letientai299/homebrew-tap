class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261024114941"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-81da427d5b600af55cae3dbd90e02febf2824116/vpdf-macos-aarch64.tar.gz"
      sha256 "ec3f6263bd1e7b7be4cb88ec84208082081ec83b8e56af695c91d8424d0f0af3"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-81da427d5b600af55cae3dbd90e02febf2824116/vpdf-linux-x86_64.tar.gz"
      sha256 "c7f4bce488fd04ac1821702afaf2d8593ef61e6f5c7d008fca54e99cf565e833"
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
