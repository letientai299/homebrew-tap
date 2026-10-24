class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261024055900"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-afb702835930485acfbb83c2165cbd1503fd353f/vpdf-macos-aarch64.tar.gz"
      sha256 "dc657267a874bcbfa4bc3b4c0d0fe11f3fd001326115bc2ea29744e7a133c9b8"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-afb702835930485acfbb83c2165cbd1503fd353f/vpdf-linux-x86_64.tar.gz"
      sha256 "64ae812340a9f3ce6108405daf9ef3187f55b8bb39b7c3bba6ce6d7354e12068"
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
