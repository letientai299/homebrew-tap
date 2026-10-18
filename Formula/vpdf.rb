class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261018033638"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-32c8618f50114268a96f2264e3216043787ac340/vpdf-macos-aarch64.tar.gz"
      sha256 "a73dcb70531a82a3892f9ec6f8e906359c4289536c4a5c3c951106bddc45be07"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-32c8618f50114268a96f2264e3216043787ac340/vpdf-linux-x86_64.tar.gz"
      sha256 "451df469d6ae900e1b173ae9d009f6037a56cf68aa0cb192c2213c468c851186"
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
