# Session Note

## Summary

- Completed `BATCH-2026-06-12-C` for `DominicDolan/Mechanica`.
- Classified the repository as `accepted`.
- Added durable findings and a catalog card for a compact desktop-first Kotlin 2D engine with real scene management, fixed-step update policy, shader-backed path rendering, and a small but real lifecycle test surface.

## Useful Local Context

- Lightweight Gradle discovery worked partially after redirecting `GRADLE_USER_HOME` into `research/cache/gradle-DominicDolan-Mechanica`.
- `gradlew.bat --version` succeeded.
- `gradlew.bat help --no-daemon` failed during configuration because `desktop-application/build.gradle.kts` requires the external Gradle property `lwjgl_natives`.
- The build also enforces `jvmToolchain(22)`, while `README.md` still says Java `12+`, so the repository has real documentation drift.

## Why It Matters Later

- If `Mechanica` is revisited, keep the follow-up narrow:
  - `SceneManager`
  - `MultiUpdateCalculator`
  - `PathRenderer`
  - GLFW host/runtime seam
- Treat it as an architecture reference, not a direct Android baseline.
