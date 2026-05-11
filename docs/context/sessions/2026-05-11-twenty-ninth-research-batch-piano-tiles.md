# Session Note

## Summary

- Completed `BATCH-2026-05-11-Q` for `atillaturkmen/piano-tiles`.
- Added durable findings, a catalog card, registry/category updates, refreshed public/internal snapshot counts, and a new short carry-over backlog for the next batch.
- Classified `piano-tiles` as `reference-only` rather than `accepted`.

## Verified State

- `atillaturkmen/piano-tiles` was kept as a direct Android `SurfaceView` rhythm-game comparison reference with value in device-height speed normalization, moving-tile touch hit-testing, optional tactile feedback, and speed-keyed local high scores.
- The inspected commit was `d9257698ffddd3a5be60f96e558aa4be75d6ad17`.
- `cmd /c gradlew.bat --version` succeeds for the inspected clone and reports Gradle `8.11.1` on Java `1.8.0_321`.
- `cmd /c gradlew.bat help --no-daemon` fails during configuration because Android Gradle Plugin `8.9.1` requires Java `11+`, while the lab machine still exposes Java `8`; the app module itself targets Java/Kotlin `17`.
- The repository state now reflects `29` completed research batches, `35` researched repositories, and a `31 accepted / 4 reference-only` split.
- `research/worktrees/` was cleaned after documentation and again contains only `.gitkeep`.

## Follow-Up

- Start the next batch from the current verified short backlog in `research/registry/CANDIDATE_QUEUE.md`: `CescFe/numpairs`, `sgalluz/k2d`, and `Efimj/GameOfLife`.
- If `piano-tiles` needs a revisit, isolate the `SurfaceView` thread lifecycle, the device-height speed-normalization rule, or the moving-tile touch-hit-testing flow instead of reopening the whole repository broadly.
- The root repository license is still unresolved and remains an active project-level task.

## References

- `research/batches/BATCH-2026-05-11-Q.md`
- `research/findings/atillaturkmen-piano-tiles.md`
- `catalog/projects/atillaturkmen-piano-tiles.md`
- `research/registry/CANDIDATE_QUEUE.md`
- `research/registry/RESEARCHED_REPOS.md`
- `docs/context/HANDOFF.md`
