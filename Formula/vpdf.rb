class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.1"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/v0.0.1/vpdf-macos-aarch64.tar.gz"
      sha256 "50daba2bfdbfb73c7aa258fbff0c2b36f9bc3f9de15e5c7b5abb246278395c0a"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/v0.0.1/vpdf-linux-x86_64.tar.gz"
      sha256 "c9aaeacbc22728ff6d21203e00ea7ee2bd70a11830c3e5235f94e8ab84d517a0"
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
