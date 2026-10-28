class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261028104752"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-34c37607cd6e0748e014501791dd84685890aa2d/vpdf-macos-aarch64.tar.gz"
      sha256 "9c688001c86a7bdc8c47a6df3d8374be580d42650f7b89db75c3411c2c5a9005"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-34c37607cd6e0748e014501791dd84685890aa2d/vpdf-linux-x86_64.tar.gz"
      sha256 "597722f4391c85b54fe90070fd6af1f831e1c0c3f63b02d361dea8a8b3861759"
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
