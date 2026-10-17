import unittest

from snapshots import prune_plan


def release(number, **changes):
    result = {
        "tag_name": "snapshot-" + f"{number:040x}",
        "published_at": f"2026-10-{number:02d}T00:00:00Z",
        "draft": False,
    }
    return result | changes


class RetentionTests(unittest.TestCase):
    def test_keeps_latest_five(self):
        releases = [release(number) for number in range(1, 9)]
        self.assertEqual(
            prune_plan(releases, release(8)["tag_name"], 5),
            [release(number)["tag_name"] for number in [3, 2, 1]],
        )

    def test_rejects_pinned_deletion(self):
        with self.assertRaisesRegex(ValueError, "Update the pinned"):
            prune_plan([release(number) for number in range(1, 9)], release(1)["tag_name"], 5)

    def test_ignores_other_releases(self):
        releases = [release(1), release(2, tag_name="main"), release(3, tag_name="dev"), release(4, draft=True)]
        self.assertEqual(prune_plan(releases, release(1)["tag_name"], 1), [])

    def test_under_limit(self):
        self.assertEqual(prune_plan([release(1)], release(1)["tag_name"], 5), [])

    def test_rejects_missing_pin(self):
        with self.assertRaises(ValueError):
            prune_plan([], release(1)["tag_name"], 5)

    def test_rejects_invalid_limit(self):
        for keep in [0, -1, True, "5"]:
            with self.subTest(keep=keep), self.assertRaises(ValueError):
                prune_plan([release(1)], release(1)["tag_name"], keep)


if __name__ == "__main__":
    unittest.main()
