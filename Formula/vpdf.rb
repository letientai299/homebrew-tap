class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261028002944"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-e10484f95bdca1cdbeeccecf7f29c95f6957f15f/vpdf-macos-aarch64.tar.gz"
      sha256 "1684c62a2a5e5e1480dcc87213aa053b95477abd188a5bc7c0d5e804c8531e56"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-e10484f95bdca1cdbeeccecf7f29c95f6957f15f/vpdf-linux-x86_64.tar.gz"
      sha256 "e22287dfeeb18d225f1596fac1f82e415beac2065070108b960fb9b60d34e91d"
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
