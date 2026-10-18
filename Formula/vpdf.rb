class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261018164639"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-f28b004084ddcff27457c4799b9056533624ebda/vpdf-macos-aarch64.tar.gz"
      sha256 "baa697e36e93a83ca64817163f021ad0153a4ea886a7638799768610f8dba81b"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-f28b004084ddcff27457c4799b9056533624ebda/vpdf-linux-x86_64.tar.gz"
      sha256 "bdd0f909773d89fa77d3d5c0ee550112170dee4757208f0d10ed0d3181c04e06"
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
