class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261029003724"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-f4a9a1950c8734fc9740ce280549c4248f48ea35/vpdf-macos-aarch64.tar.gz"
      sha256 "5f0eef2e48840c82d28db5640799de0dab787ef600a8b703fea61eefb0fe964e"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-f4a9a1950c8734fc9740ce280549c4248f48ea35/vpdf-linux-x86_64.tar.gz"
      sha256 "227670140c623c83dd23e0920e6461f2316b6f5fa571032adac3a7fec5f69a44"
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
