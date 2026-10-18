class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261018141158"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-69b218a7bbeeb4e3de90739fa0c96f7d30df46f5/vpdf-macos-aarch64.tar.gz"
      sha256 "41038404150a183fee14e60f2f30ede8b474a37f6b76a3ce892a057f9423632d"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-69b218a7bbeeb4e3de90739fa0c96f7d30df46f5/vpdf-linux-x86_64.tar.gz"
      sha256 "f00f537318138bf9d9abe042372c2633eccbc4f92be96fa595c64c5246fdc621"
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
