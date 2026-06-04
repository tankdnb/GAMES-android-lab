# Session Note

## Summary

- Completed `BATCH-2026-06-04-R` for `kool-engine/kool`.
- Added durable findings and a catalog card, updated registries plus public and internal snapshot counts, and kept the repository in the main catalog as an `accepted` multiplatform engine reference with real Android source sets.
- Refreshed short backlog remains available after the batch, now led by `BlueBoxWare/LibGDXPlugin`, `ImXico/cyberpunk`, `Quillraven/Dark-Matter`, and `benpollarduk/ktaf`.

## Verified State

- `kool-engine/kool` is now recorded as an `accepted` repository.
- The inspected commit was `27da5cfeda200128331a052c74ee6de8d938e1d9`.
- The repository is a large Kotlin Multiplatform 3D engine with desktop Vulkan / OpenGL / `wgpu4k`, browser WebGPU / WebGL, checked-in Android GLES support, Compose-style in-engine UI, physics modules, editor modules, and demos.
- Android support is real but intentionally disabled by default in the checked-in Gradle surface; root tasks rewrite convention and module build files to enable it only when the environment is Android-ready.
- The local lab machine still exposes Java `8`, so `gradlew help --no-daemon` and `:kool-core:desktopTest --dry-run --no-daemon` currently fail before meaningful task discovery because Gradle now requires Java `17+`.
- The repository state should now reflect `49` completed research batches, `55` researched repositories, and a `48 accepted / 7 reference-only` split.
- `research/worktrees/` should be cleaned after the batch and return to only `.gitkeep`.

## Follow-Up

- Continue from the refreshed shortlist, starting with `BlueBoxWare/LibGDXPlugin` unless a stronger newly verified candidate appears.
- If `kool` needs a revisit, keep it narrow: rerun selected Gradle tasks in a JDK `25` plus Android SDK-ready environment, or isolate the Android enable/disable workflow, the backend split between Vulkan / OpenGL / `wgpu4k`, the Compose-style UI runtime, or the physics source-transformation path.
- Keep preferring exact repository-level license verification before candidates enter the short backlog.

## References

- `research/batches/BATCH-2026-06-04-R.md`
- `research/findings/kool-engine-kool.md`
- `catalog/projects/kool-engine-kool.md`
- `research/registry/CANDIDATE_QUEUE.md`
- `research/registry/RESEARCHED_REPOS.md`
- `docs/context/HANDOFF.md`
