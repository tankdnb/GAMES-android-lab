# Session Note

## Summary

- Completed `BATCH-2026-06-04-K` for `canopyengine/canopy`.
- Added durable findings and a catalog card, updated the research registries and public/internal snapshot counts, and kept the repository in the main catalog as an `accepted` `engine-framework` reference.
- Cleaned `research/worktrees/` back to `.gitkeep` so the next heartbeat run can start from a clean research workspace.

## Verified State

- `canopyengine/canopy` is now recorded as an `accepted` `engine-framework` repository.
- The inspected commit was `44fca3ef4d869e5e35b121992ee45ca7e07bf088` on branch `main`.
- The repository is a compact Kotlin node-driven engine with a reusable app shell, DSL-built node tree, attached behaviors, phased scene processing, modular save slices, backend-owned input mapping, and a notably strong headless `tooling/devtools` test harness.
- Local Gradle verification was stronger than many recent small-engine batches:
  - `cmd /c gradlew.bat --version` succeeds
  - `cmd /c gradlew.bat help --no-daemon` succeeds
  - `cmd /c gradlew.bat build --dry-run --no-daemon` succeeds
  - `cmd /c gradlew.bat :engine:test --no-daemon` succeeds
  - `cmd /c gradlew.bat :tooling:devtools:test --no-daemon` succeeds
- Important caveats were preserved in the findings:
  - Android relevance is still indirect because no active Android module is included
  - `platforms/desktop` is excluded from `settings.gradle.kts` and looks partially stale
  - top-level version/license/scope documentation drifts from the active module graph
- The repository state should now reflect `42` completed research batches, `48` researched repositories, and a `42 accepted / 6 reference-only` split.
- `research/worktrees/` is cleaned and should contain only `.gitkeep`.

## Follow-Up

- Start the next batch from the verified short backlog in `research/registry/CANDIDATE_QUEUE.md`, now led by `vitaviva/ugame`.
- If `canopyengine/canopy` needs a revisit, do it in a JDK `17+` or `21` environment and isolate one seam such as the node/behavior runtime, the scene/tree-system ownership model, the save/input integration layer, or the excluded desktop rendering path.
- If `vitaviva/ugame` is completed and no stronger explicit-license reserve is left, refresh the shortlist again instead of letting the queue go stale.

## References

- `research/batches/BATCH-2026-06-04-K.md`
- `research/findings/canopyengine-canopy.md`
- `catalog/projects/canopyengine-canopy.md`
- `research/registry/CANDIDATE_QUEUE.md`
- `research/registry/RESEARCHED_REPOS.md`
- `docs/context/HANDOFF.md`
