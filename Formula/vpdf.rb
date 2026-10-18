class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261018193807"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-31d528862c8d361752dcb2c80169465ea5b647d2/vpdf-macos-aarch64.tar.gz"
      sha256 "14126793d30db24fe99655d0a530583ab722905c6442fccedc5868060988fcf9"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-31d528862c8d361752dcb2c80169465ea5b647d2/vpdf-linux-x86_64.tar.gz"
      sha256 "40234e7448c88ff3445a337b82034bcd6d04fadb407ea93e00ee654fae08f1d8"
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
