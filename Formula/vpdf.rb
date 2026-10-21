class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261021065002"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-0011323e6141a5e5d43fd5d4bcb7f90603f00baa/vpdf-macos-aarch64.tar.gz"
      sha256 "a3569aa4d5bb538e32b704e6a987f4e447eed985289950a8298f769f1c75a5ee"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-0011323e6141a5e5d43fd5d4bcb7f90603f00baa/vpdf-linux-x86_64.tar.gz"
      sha256 "fc93e4475dd4f80407a8ec664e85de9882b35b096e87e664aa1bbbcd39f0754b"
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
