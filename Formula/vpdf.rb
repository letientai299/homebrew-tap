class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/v0.0.2/vpdf-macos-aarch64.tar.gz"
      sha256 "ecd89f9c0a974d2cb05df9808e0d4523d8abf901184d1a6bad3cc7a72d1229ab"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/v0.0.2/vpdf-linux-x86_64.tar.gz"
      sha256 "707f6d1130fb69bda480192e5fe6f70da3f48c8e41de718703285a422342791a"
    end
  end

  def install
    bin.install "vpdf"
  end

  test do
    ENV["VPDF_PREVIEW"] = "text"
    assert_match "Homebrew test.", shell_output("#{bin}/vpdf #{test_fixtures("test.pdf")}")
    output = shell_output("#{bin}/vpdf --version")
    assert_equal "vpdf #{version}", output.lines.first.strip
    assert_match "# Vpdf v#{version}", output
  end
end
