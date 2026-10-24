class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261024040804"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-acb2f0aaf30cf582cab6c2e55bd7c98b5b6c15fc/vpdf-macos-aarch64.tar.gz"
      sha256 "0485c70ea6fc992d33508ac2d38b04e392ad79460df994b6e5cc12fa934fb0e9"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-acb2f0aaf30cf582cab6c2e55bd7c98b5b6c15fc/vpdf-linux-x86_64.tar.gz"
      sha256 "ece8e54afaab42b85ebc9988677f1fa7dd19dd913a7c8006cafef1833f1cd64a"
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
