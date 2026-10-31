class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261031035318"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-4e38e26b51aad5ffc9546bb63cdd6dad9e8556ff/vpdf-macos-aarch64.tar.gz"
      sha256 "5c0702a93079b05ed1e2f5ce0003ad31c68e95516cf2cca4bf5835d2d2e7f0e6"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-4e38e26b51aad5ffc9546bb63cdd6dad9e8556ff/vpdf-linux-x86_64.tar.gz"
      sha256 "f8bb43ec6d34b42a51e00eea87b733ba706d862ddf47deeb2d2a34866ac0bf64"
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
