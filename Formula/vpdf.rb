class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261017061600"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-301aed74f78453fb228e08fa79dfe63efb24335f/vpdf-macos-aarch64.tar.gz"
      sha256 "52e441b897d79a653d8154ef8a64427d329ee50b7b7cb358906d82957bd2efee"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-301aed74f78453fb228e08fa79dfe63efb24335f/vpdf-linux-x86_64.tar.gz"
      sha256 "be4e531b6e99b59564653c5d49749d3a2c5915ae18395e81c3cd997d2158a04a"
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
