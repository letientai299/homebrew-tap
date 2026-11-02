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
Increase the formula version when publishing a new release so `brew upgrade`
can detect the update.

Run checks before submitting changes:

```sh
brew style Formula/
brew audit --strict --formula letientai299/tap/vpdf
brew test letientai299/tap/vpdf
```

[homebrew]: https://brew.sh/

## vpdf releases

[vpdf][vpdf] installs stable terminal binaries for macOS ARM64 and Linux
x86-64. The native app remains source-only.

The upstream release workflow updates the formula after checking installation
through mise. Stable versions pin immutable release archives and checksums.
Development snapshots and rolling releases are no longer published.

After a stable release is published, update the formula with:

```sh
python3 scripts/update-vpdf.py v0.1.0
```

The updater needs Python 3.9 or later and an authenticated [GitHub CLI][gh].
It verifies downloaded archives against SHA-256 sidecars, refuses downgrades,
and replaces the formula after both platform checks pass. Review and test the
formula before committing.

[vpdf]: https://github.com/letientai299/vpdf
[gh]: https://cli.github.com/
