class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261029031905"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-1a8b8d77a1e804d463eb8a8f3ad6940ec653c5f2/vpdf-macos-aarch64.tar.gz"
      sha256 "a7c5f249daf31a660bb92816151a88963fba417faa2e39b05e12b33be6cb1730"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-1a8b8d77a1e804d463eb8a8f3ad6940ec653c5f2/vpdf-linux-x86_64.tar.gz"
      sha256 "3cc25b463aa1bbde052b8437800a17b48777f290e4c2045bdab99b7614f7bfe6"
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
