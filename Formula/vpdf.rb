class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261020073738"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-7595c0f8821b70f7d6799a2df0ae585a9e0f49f7/vpdf-macos-aarch64.tar.gz"
      sha256 "1c7e5e4c8d786a46632eddd3da329a01f949ac85b831dc5e8a3f7d31a5c9cca7"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-7595c0f8821b70f7d6799a2df0ae585a9e0f49f7/vpdf-linux-x86_64.tar.gz"
      sha256 "62a7b268130f483c9ef806574a16cecb52bfb0aef92337cdc4973bb3c69898e0"
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
