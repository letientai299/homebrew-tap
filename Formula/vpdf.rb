class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261017190746"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-38802223b54c8ac60ebba5b0a59d64a84deb37cc/vpdf-macos-aarch64.tar.gz"
      sha256 "68409ae51cbe6d3c03128127dd91cc587053299dca57c9ba86a6e5e73d6d2af5"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-38802223b54c8ac60ebba5b0a59d64a84deb37cc/vpdf-linux-x86_64.tar.gz"
      sha256 "215b865c8e4ce7f3df0dcc3545da35b252b794130c3b98775b80f703774b3d26"
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
