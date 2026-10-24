class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "0.0.20261024075613"
  license "AGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-cb529e2a3e39c46cbb49eef54ea2df7d0adf18ed/vpdf-macos-aarch64.tar.gz"
      sha256 "f3f33bd811353e086ff589157057718727d833106def2d431a6a1b3a951f10f8"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/letientai299/vpdf/releases/download/snapshot-cb529e2a3e39c46cbb49eef54ea2df7d0adf18ed/vpdf-linux-x86_64.tar.gz"
      sha256 "1fc5c042e384b83deee1db19ccf10372fb8f4c374b91c8b5a8713481c775aa83"
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
