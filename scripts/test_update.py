import ast
import importlib.util
import unittest
from pathlib import Path
from unittest.mock import patch

spec = importlib.util.spec_from_file_location(
    "update", Path(__file__).with_name("update-vpdf.py")
)
update = importlib.util.module_from_spec(spec)
spec.loader.exec_module(update)


class ReleaseTests(unittest.TestCase):
    def test_python_compatibility(self):
        ast.parse(
            Path(__file__).with_name("update-vpdf.py").read_text(),
            feature_version=(3, 9),
        )

    def test_stable_versions(self):
        self.assertEqual(update.release_version("v0.1.0"), "0.1.0")
        for tag in ["dev", "snapshot-abc", "v01.1.0", "v1.0.0-rc.1", "1.0.0"]:
            with self.subTest(tag=tag), self.assertRaises(ValueError):
                update.release_version(tag)

    def test_unpublished_rejected(self):
        for draft, prerelease in [(True, False), (False, True)]:
            with (
                patch.object(update.sys, "argv", ["update-vpdf.py", "v0.1.0"]),
                patch.object(
                    update,
                    "github",
                    return_value={
                        "draft": draft,
                        "prerelease": prerelease,
                        "tag_name": "v0.1.0",
                    },
                ),
                self.assertRaisesRegex(ValueError, "unpublished"),
            ):
                update.main()

    def test_formula_upgrade(self):
        import tempfile

        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "Formula").mkdir()
            formula = root / "Formula/vpdf.rb"
            formula.write_text('version "0.0.20261031035318"\n')
            assets = [
                {
                    "name": f"vpdf-{platform}.tar.gz{suffix}",
                    "browser_download_url": f"https://github.com/letientai299/vpdf/releases/download/v0.1.0/vpdf-{platform}.tar.gz{suffix}",
                }
                for platform in ["macos-aarch64", "linux-x86_64"]
                for suffix in ["", ".sha256"]
            ]
            release = {
                "draft": False,
                "prerelease": False,
                "tag_name": "v0.1.0",
                "assets": assets,
            }
            with (
                patch.object(update, "ROOT", root),
                patch.object(update.sys, "argv", ["update-vpdf.py", "v0.1.0"]),
                patch.object(update, "github", return_value=release),
                patch.object(update, "checksum", return_value="a" * 64),
            ):
                update.main()
                result = formula.read_text()
                self.assertIn('version "0.1.0"', result)
                self.assertNotIn("snapshot-", result)
                self.assertEqual(result.count('sha256 "'), 2)
                self.assertIn('ENV["VPDF_PREVIEW"] = "text"', result)
                self.assertIn('assert_equal "vpdf #{version}"', result)
                update.main()
                formula.write_text(
                    result.replace('sha256 "' + "a" * 64, 'sha256 "' + "b" * 64)
                )
                with self.assertRaisesRegex(ValueError, "asset pins changed"):
                    update.main()
                formula.write_text('version "0.2.0"\n')
                with self.assertRaisesRegex(ValueError, "downgrade"):
                    update.main()
                self.assertEqual(formula.read_text(), 'version "0.2.0"\n')
