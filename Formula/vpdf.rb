class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261017043344"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-2a359cf2c1827bb55ab76d4a8ed51a50eb00d22c/vpdf-macos-aarch64.tar.gz"
      sha256 "bdf21cb298e432894165d4246e4e08130648f2b78b1ab84768227dff540a06f8"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-2a359cf2c1827bb55ab76d4a8ed51a50eb00d22c/vpdf-linux-x86_64.tar.gz"
      sha256 "7e79017e12748298b9769b0771895f2c4c72143edb80a61344f75da70cf522d8"
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
