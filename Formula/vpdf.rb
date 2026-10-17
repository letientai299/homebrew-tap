class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261017071441"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-55fcf24fd19a73429ca68e207172ddf105ff5318/vpdf-macos-aarch64.tar.gz"
      sha256 "7a1544b6289c73864b05eed9c31221a98b4f2fc8de28bfa085ec87264ffe00a8"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-55fcf24fd19a73429ca68e207172ddf105ff5318/vpdf-linux-x86_64.tar.gz"
      sha256 "1d570ccb97bc86da9d5b3660b418ba9ab1802c117d05244d2ef758d9283d82a9"
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
