#!/usr/bin/env python3
"""Pin vpdf to a published stable release."""

import hashlib
import json
import os
import re
import subprocess
import sys
import tempfile
import urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
REPOSITORY = "letientai299/vpdf"


def github(path):
    return json.loads(
        subprocess.check_output(
            ["gh", "api", f"repos/{REPOSITORY}/{path}"], text=True
        )
    )


def release_version(tag):
    if not re.fullmatch(
        r"v(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)", tag
    ):
        raise ValueError("Stable release tag required")
    return tag[1:]


def checksum(asset, sidecar):
    with urllib.request.urlopen(
        sidecar["browser_download_url"], timeout=60
    ) as response:
        expected, filename = response.read().decode().strip().split()
    if filename.lstrip("*") != asset["name"] or not re.fullmatch(
        r"[0-9a-f]{64}", expected
    ):
        raise ValueError("Invalid release checksum")
    digest = hashlib.sha256()
    with urllib.request.urlopen(
        asset["browser_download_url"], timeout=60
    ) as response:
        while chunk := response.read(1024 * 1024):
            digest.update(chunk)
    if digest.hexdigest() != expected:
        raise ValueError("Release checksum mismatch")
    return expected


def main():
    if len(sys.argv) != 2:
        sys.exit("Usage: update-vpdf.py v<major>.<minor>.<patch>")
    tag = sys.argv[1]
    version = release_version(tag)
    release = github(f"releases/tags/{tag}")
    if release["draft"] or release["prerelease"] or release["tag_name"] != tag:
        raise ValueError("Stable release is unpublished")
    assets = {asset["name"]: asset for asset in release["assets"]}
    blocks = []
    for operating_system, platform, architecture, cpu in [
        ("macos", "macos-aarch64", "arm64", "arm"),
        ("linux", "linux-x86_64", "x86_64", "intel"),
    ]:
        asset = assets[f"vpdf-{platform}.tar.gz"]
        digest = checksum(asset, assets[asset["name"] + ".sha256"])
        asset_url = asset["browser_download_url"]
        blocks.append(f'''  on_{operating_system} do
    depends_on arch: :{architecture}

    on_{cpu} do
      url "{asset_url}"
      sha256 "{digest}"
    end
  end''')
    formula = """class Vpdf < Formula
  desc "Keyboard-driven terminal PDF reader"
  homepage "https://github.com/letientai299/vpdf"
  license "AGPL-3.0-or-later"

BLOCKS

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
""".replace("BLOCKS", "\n\n".join(blocks))
    target = ROOT / "Formula" / "vpdf.rb"
    if target.exists():
        # Homebrew reads the version from the release URL.
        current = re.search(
            r"/releases/download/v([0-9]+\.[0-9]+\.[0-9]+)/", target.read_text()
        )
        if current:
            previous = tuple(map(int, current[1].split(".")))
            incoming = tuple(map(int, version.split(".")))
            if previous > incoming:
                raise ValueError("Release update would downgrade vpdf")

            def pins(text):
                return re.findall(r'(?m)^      (url|sha256) "([^"]+)"$', text)

            if previous == incoming and pins(target.read_text()) != pins(
                formula
            ):
                raise ValueError("Release asset pins changed")
    with tempfile.NamedTemporaryFile(
        mode="w", dir=target.parent, delete=False
    ) as staged:
        staged.write(formula)
        staged_path = staged.name
    os.chmod(staged_path, 0o644)
    os.replace(staged_path, target)
    print(f"Pinned vpdf {version} to {tag}")


if __name__ == "__main__":
    main()
