#!/usr/bin/env python3
"""Pin vpdf to a published binary snapshot."""

import datetime
import hashlib
import os
import re
import sys
import tempfile
import urllib.request


from snapshots import ROOT, github


def checksum(asset, sidecar):
    with urllib.request.urlopen(sidecar["browser_download_url"], timeout=60) as response:
        expected, filename = response.read().decode().strip().split()
    if filename.lstrip("*") != asset["name"] or not re.fullmatch(r"[0-9a-f]{64}", expected):
        raise ValueError("Invalid snapshot checksum")
    digest = hashlib.sha256()
    with urllib.request.urlopen(asset["browser_download_url"], timeout=60) as response:
        while chunk := response.read(1024 * 1024):
            digest.update(chunk)
    if digest.hexdigest() != expected:
        raise ValueError("Snapshot checksum mismatch")
    return expected


def main():
    if len(sys.argv) != 2 or not re.fullmatch(r"snapshot-[0-9a-f]{40}", sys.argv[1]):
        sys.exit("Usage: update-vpdf.py snapshot-<full-commit-sha>")
    tag = sys.argv[1]
    revision = tag.removeprefix("snapshot-")
    if github(f"git/ref/tags/{tag}")["object"]["sha"] != revision:
        raise ValueError("Snapshot tag does not match revision")
    release = github(f"releases/tags/{tag}")
    if release["draft"]:
        raise ValueError("Snapshot release is unpublished")
    assets = {asset["name"]: asset for asset in release["assets"]}
    commit = github(f"commits/{revision}")
    date = datetime.datetime.fromisoformat(commit["commit"]["committer"]["date"].replace("Z", "+00:00"))
    version = "0.0." + date.strftime("%Y%m%d%H%M%S")
    blocks = []
    for operating_system, platform, architecture, cpu in [
        ("macos", "macos-aarch64", "arm64", "arm"),
        ("linux", "linux-x86_64", "x86_64", "intel"),
    ]:
        asset = assets[f"vpdf-{platform}.tar.gz"]
        digest = checksum(asset, assets[asset["name"] + ".sha256"])
        blocks.append(f'''  on_{operating_system} do
    depends_on arch: :{architecture}

    on_{cpu} do
      url "{asset['browser_download_url']}"
      sha256 "{digest}"
    end
  end''')
    formula = '''class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  version "VERSION"
  license "AGPL-3.0-or-later"

BLOCKS

  def install
    bin.install "vpdf"
  end

  test do
    metadata = JSON.parse(shell_output("#{bin}/vpdf info #{test_fixtures("test.pdf")}"))
    assert_equal 1, metadata.fetch("pages").length
  end
end
'''.replace("VERSION", version).replace("BLOCKS", "\n\n".join(blocks))
    target = ROOT / "Formula" / "vpdf.rb"
    if target.exists():
        current = re.search(r'version "([0-9.]+)"', target.read_text())
        if current and tuple(map(int, current[1].split("."))) > tuple(map(int, version.split("."))):
            raise ValueError("Snapshot update would downgrade vpdf")
    with tempfile.NamedTemporaryFile(mode="w", dir=target.parent, delete=False) as staged:
        staged.write(formula)
        staged_path = staged.name
    os.chmod(staged_path, 0o644)
    os.replace(staged_path, target)
    print(f"Pinned vpdf {version} to {revision}")


if __name__ == "__main__":
    main()
