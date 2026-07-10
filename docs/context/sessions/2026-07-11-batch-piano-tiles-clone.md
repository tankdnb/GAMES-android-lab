# Session Note: Batch Piano Tiles Clone

## Date

- `2026-07-11`

## Summary

- Completed `BATCH-2026-07-11-A` for `amirisback/piano-tiles-clone`.
- Classified it as `reference-only`.
- The lab now has `93` completed batches and `99` researched repositories: `80 accepted`, `19 reference-only`.

## Durable Context

- The repository is an Apache-2.0 Android Piano Tiles clone aggregator with six modules: `atillaturkmen`, `frostygum`, `gianmartind`, `jghjianghan`, `mihaimaximfii`, and `obedkristiaji`.
- The strongest reusable section is `jghjianghan`, where `GameEngine`, `TileOrchestrator`, `TileDrawer`, and mode-specific engines split classic, arcade, raining, and tilt gameplay variants.
- The batch is useful for comparing rendering strategies: `SurfaceView`, bitmap-backed `ImageView`, and direct `ImageView` tile spawning.
- The repository is not a main baseline because it is an aggregator of cloned student-style projects, overlaps with previously researched `atillaturkmen/piano-tiles`, has no tests, and uses raw thread/timer loops heavily.
- Local Gradle wrapper version check succeeded, but `gradlew.bat help --no-daemon` failed because the lab Java environment lacks JDK compiler tools.

## Next Step

- The compact backlog is now exhausted. The next research run should refresh `research/registry/CANDIDATE_QUEUE.md` with no more than four new explicit-license Kotlin game/game-engine candidates before starting another batch.
