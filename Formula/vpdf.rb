class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261021114156"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-fbf92f7300a3d66cdca3e26beacde7e74d6844ca/vpdf-macos-aarch64.tar.gz"
      sha256 "dd137f86d94d7f53ee12c55242d43b9c75170e4e3a07d9c00a32b391ad417cf2"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-fbf92f7300a3d66cdca3e26beacde7e74d6844ca/vpdf-linux-x86_64.tar.gz"
      sha256 "6c515858b11f7fc86a22901787a97aba115a5ac778b60934e49a4da35aeb0744"
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
