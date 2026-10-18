class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261018205231"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-66e2a610429e3e2cc5f06afec766b030805da8b9/vpdf-macos-aarch64.tar.gz"
      sha256 "cc2c907852de9f10aeca747bc8f6d1d6eeac019bed9fafd230a27cacfd11035c"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-66e2a610429e3e2cc5f06afec766b030805da8b9/vpdf-linux-x86_64.tar.gz"
      sha256 "3395928b330fc3321f844b94c70f7dab5f3cd98a404b4aaa82bff07adea28cee"
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
