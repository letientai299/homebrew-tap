# Personal Homebrew tap

[Homebrew][homebrew] formulae for tools maintained by letientai299.

## Install

```sh
brew install letientai299/tap/vpdf
```

To use short names, add the tap first:

```sh
brew tap letientai299/tap
brew install vpdf
```

## Maintain

Keep each tool's formula under `Formula/`. Pin downloadable archives to an
immutable release or source revision and record their SHA-256 checksums.
Increase the formula version when publishing a new snapshot so `brew upgrade`
can detect the update.

Run checks before submitting changes:

```sh
brew style Formula/
brew audit --strict letientai299/tap/vpdf
brew test letientai299/tap/vpdf
```

[homebrew]: https://brew.sh/

## vpdf snapshots

[vpdf][vpdf] installs prebuilt binaries for macOS ARM64 and Linux x86-64.
No Rust toolchain or native build dependencies are required.

The formula uses a commit-pinned snapshot, with a timestamp version for
`brew upgrade`. It does not download the replaceable `main` release.

After upstream publishes a new `snapshot-<full-commit-sha>` release, set
`snapshot_tag` to that tag and run:

```sh
python3 scripts/update-vpdf.py "$snapshot_tag"
```

The updater requires Python 3.9 or later and an authenticated [GitHub CLI][gh].
It checks that the tag points to the named commit, verifies both downloaded
archives against their SHA-256 sidecars, and replaces the formula only after
both checks pass. Review and test the formula before committing the update.

[vpdf]: https://github.com/letientai299/vpdf
[gh]: https://cli.github.com/
