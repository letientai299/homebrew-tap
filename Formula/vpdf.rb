class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261022074220"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-6e1b804c6ec8b08052f09534c443aa919f14b74c/vpdf-macos-aarch64.tar.gz"
      sha256 "80a599331d5c5aff8f4e934208b60750be4239316d6dae8eb0b5894563ede855"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-6e1b804c6ec8b08052f09534c443aa919f14b74c/vpdf-linux-x86_64.tar.gz"
      sha256 "0b8b3ab160ac10a1444d37d0edb37190145dbbfe6e005285baeb7c94c423ce53"
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
