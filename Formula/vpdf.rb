class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261024093710"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-6ca19d27b78677b289aa84053852b390409f4094/vpdf-macos-aarch64.tar.gz"
      sha256 "f5ecac6a131e7b120995f4a3cf03d6ba58927df2d7400784340968f47935f3f2"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-6ca19d27b78677b289aa84053852b390409f4094/vpdf-linux-x86_64.tar.gz"
      sha256 "21d054ad445a007b95bea795b604c1e56e49d2c62c61175e4d97a03de4537f50"
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
