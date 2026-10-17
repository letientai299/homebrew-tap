#!/usr/bin/env python3
"""Retain the latest configured binary snapshots."""

import argparse
import json
from pathlib import Path
import re
import subprocess

ROOT = Path(__file__).resolve().parents[1]
POLICY = json.loads((ROOT / "snapshots.json").read_text())["vpdf"]
REPOSITORY = POLICY["repository"]
TAG_PATTERN = r"snapshot-[0-9a-f]{40}"


def github(path, paginate=False):
    command = ["gh", "api", f"repos/{REPOSITORY}/{path}"]
    if paginate:
        command.extend(["--paginate", "--slurp"])
    result = subprocess.run(command, check=True, capture_output=True, text=True)
    return json.loads(result.stdout)


def prune_plan(releases, pinned, keep):
    if isinstance(keep, bool) or not isinstance(keep, int) or keep < 1:
        raise ValueError("Snapshot retention must be positive")
    snapshots = sorted(
        (release for release in releases
         if not release["draft"] and re.fullmatch(TAG_PATTERN, release["tag_name"])),
        key=lambda release: (release["published_at"], release["tag_name"]),
        reverse=True,
    )
    retained = {release["tag_name"] for release in snapshots[:keep]}
    if pinned not in retained:
        raise ValueError("Update the pinned snapshot before pruning")
    return [release["tag_name"] for release in snapshots[keep:]]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--apply", action="store_true")
    args = parser.parse_args()
    formula = (ROOT / "Formula" / "vpdf.rb").read_text()
    pins = set(re.findall(TAG_PATTERN, formula))
    if len(pins) != 1:
        raise ValueError("Formula must pin one snapshot")
    releases = [release for page in github("releases?per_page=100", paginate=True)
                for release in page]
    for tag in prune_plan(releases, pins.pop(), POLICY["keep"]):
        if args.apply:
            subprocess.run(
                ["gh", "release", "delete", tag, "--repo", REPOSITORY,
                 "--cleanup-tag", "--yes"], check=True,
            )
        print(("Deleted " if args.apply else "Would delete ") + tag)


if __name__ == "__main__":
    main()
