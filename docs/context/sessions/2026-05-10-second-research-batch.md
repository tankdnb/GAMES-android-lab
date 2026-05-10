# Session Note

## Summary

- Completed `BATCH-2026-05-10-B` under the established research workflow.
- Researched 4 repositories:
  - `littlektframework/littlekt` - `accepted`
  - `pandulapeter/kubriko` - `accepted`
  - `retrowars/retrowars` - `accepted`
  - `AlmasB/FXGL` - `reference-only`
- Added durable findings notes, catalog cards, registry updates, and category-index links for all 4 repositories.
- Updated `research/scripts/cleanup-research.ps1` so it now stops worktree-owned Gradle/Java processes before cleanup, then reran cleanup successfully.

## Important Outcomes

- `pandulapeter/kubriko` is now one of the strongest direct Android-oriented engine references because it is Compose-native and manager/plugin based.
- `retrowars/retrowars` added a solid Android multiplayer product-shell reference with shared minigame architecture and explicit network-thread-to-main-thread handoff.
- `littlektframework/littlekt` was accepted for architecture value, but Android support on the inspected branch is still incomplete.
- `AlmasB/FXGL` was deliberately kept as `reference-only` because its runtime assumptions are useful but too JavaFX-first for the repository's Android focus.

## Process Notes

- `gradlew help` attempts on `pandulapeter/kubriko` and `retrowars/retrowars` both timed out and were documented as such.
- The cleanup script now handles the Gradle lock-file case automatically by stopping worktree-owned `java` processes before removal.

## Suggested Next Move

- Either run a dedicated heavy-repo batch for `yairm210/Unciv` or do one more lightweight mixed batch before taking on that larger codebase.
