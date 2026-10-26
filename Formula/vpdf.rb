class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261026172429"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-5966a0180d2946b8dc5f5ec79d2b9d756d5048fc/vpdf-macos-aarch64.tar.gz"
      sha256 "a507ad90def0c6c1194f6256331bb91ec55ccd96a82a9370a88e8ec70db0f5bb"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-5966a0180d2946b8dc5f5ec79d2b9d756d5048fc/vpdf-linux-x86_64.tar.gz"
      sha256 "603362f8b6ffb52ecdb5dcd2006d7d7b203bdb90f18babe2d8be003481c1da0d"
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
