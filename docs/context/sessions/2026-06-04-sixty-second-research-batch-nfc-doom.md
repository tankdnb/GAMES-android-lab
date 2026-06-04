# Session Note

## Summary

- Completed `BATCH-2026-06-04-AE` for `tottelofstrom/NFC-DOOM`.
- Added durable findings and a catalog card, updated registries plus public and internal snapshot counts, and kept the repository as a main `accepted` Android reference rather than only as a novelty comparison sample.
- Cleared the active batch cleanly so the next run can start from a refreshed exact-license shortlist without reopening `NFC-DOOM`.

## Verified State

- `tottelofstrom/NFC-DOOM` is now recorded as an `accepted` repository.
- The inspected commit was `22ae1d60186712e8a11fb90ec5386a3fed69e492`.
- The repository is a direct Android Jetpack Compose game with a low-resolution software raycaster, a strict tiny binary cartridge format, and a robust NFC stack that falls back to raw ISO 15693 `NfcV` block I/O when normal NDEF paths are unreliable.
- Its strongest reusable value is the combination of:
  - pure Kotlin raycasting and simulation
  - immutable cartridge content decoded into phone-owned mutable runtime state
  - a documented `1000`-byte cartridge budget with CRC validation
  - optional non-NFC demo-cartridge mode so the same app still works on emulators and normal phones
- Its most important caveats are:
  - zero public signal and very fresh maintenance history
  - test coverage concentrated mostly on the cartridge layer
  - local Gradle discovery in the lab still failing because the machine exposes only a Java `8` JRE without compiler tools while upstream expects a full JDK `17`
- The repository state should now reflect `62` completed research batches, `68` researched repositories, and a `59 accepted / 9 reference-only` split.
- `research/worktrees/` should be cleaned after the batch and return to only `.gitkeep`.

## Follow-Up

- Refresh `research/registry/CANDIDATE_QUEUE.md` with a new exact-license shortlist before the next batch.
- If `NFC-DOOM` needs a revisit, keep it narrow: rerun Android tasks in a JDK `17+` plus Android SDK-ready environment, or isolate the raycaster, the cartridge codec/builder seam, or the raw `NfcV` fallback layer instead of reopening the whole repository broadly.
- Keep preferring exact repository-level license verification so refreshed shortlists do not drift back toward ambiguous metadata-only candidates.

## References

- `research/batches/BATCH-2026-06-04-AE.md`
- `research/findings/tottelofstrom-nfc-doom.md`
- `catalog/projects/tottelofstrom-nfc-doom.md`
- `research/registry/CANDIDATE_QUEUE.md`
- `research/registry/RESEARCHED_REPOS.md`
- `docs/context/HANDOFF.md`
