# Project Entry

## Basic Info

- Project name: `arrows_game`
- Source repository: [https://github.com/robmat/arrows_game](https://github.com/robmat/arrows_game)
- Author / organization: `robmat`
- License: `GPL-3.0`
- Research note: [research/findings/robmat-arrows-game.md](../../research/findings/robmat-arrows-game.md)
- Investigated commit: `3cfd2718f9d03723d56bd09d85c30e275038922e`
- Last verified: `2026-06-05`
- Activity / maintenance status: active small project; the inspected default branch still had code pushes in `2026`, and the repository already shows modularization and architecture work beyond a throwaway hobby sample.

## Short Description

Android puzzle game built with Jetpack Compose and a modular Clean-Architecture-style layout, with a standout solvability-aware procedural board generator and a practical save/resume product shell.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `2d`, `android`, `procedural-generation`, `ui-hud`, `input`, `save-load`, `testing`
- Engine / framework: Android SDK + Jetpack Compose + Appyx + Koin + Room
- Rendering approach: Compose-rendered custom board with path-based snake rendering and animated entry/removal states
- Main language(s): Kotlin
- Android target: direct Android app
- Build system: Gradle `9.4.0` wrapper + AGP `9.1.0` + Kotlin `2.3.10`

## Why It Matters

- `arrows_game` is worth keeping because it preserves two kinds of value at once:
  - a direct Android casual-game product shell
  - a reusable puzzle-generation and validation core
- Its strongest single idea is that generated boards are not accepted blindly; they are checked by a deterministic solvability pass.
- It is also one of the cleaner examples in the lab of a small Android game that already uses modular features, persistence, navigation, and meaningful tests.

## Reusable Ideas

- Gameplay ideas:
  - solvability-aware puzzle-board generation and staged snake-removal interaction
- Architecture patterns:
  - modular Android game split across `domain`, `data`, `feature:*`, and `navigation`
  - feature-level engine/controller separated from pure generation logic
- Graphics / rendering techniques:
  - Compose `Canvas` path rendering for curved board entities and animated removal tails
- Input / UI approaches:
  - transformed tap-to-grid mapping with head-biased hit zones and explicit guidance overlays
- Performance or optimization ideas:
  - keep domain board state clean while renderer-facing animation progress lives in separate maps

## Notable Implementations

- `GameGenerator.kt` builds candidate boards and can optionally fill the board more densely.
- `SolvabilityChecker.kt` validates that a generated puzzle can actually be solved through deterministic removal-order simulation.
- `LevelManager.kt` keeps both initial and current board snapshots, which gives restart/resume behavior a clean persistence seam.
- `ArrowsBoardRenderer.kt` shows expressive Compose board rendering with curved paths, interpolated tail shrinkage, and guidance-line overlays.
- `RootNode.kt` and `AppViewModel.kt` show a compact but credible Android navigation/state shell around the gameplay core.

## Android Relevance

- Native Android use:
  - yes, direct Android game
- Kotlin relevance:
  - very high
- Porting or adaptation notes:
  - strongest as a reference for Android puzzle products, especially when generation, solvability validation, persistence, and Compose board rendering all matter at once

## Risks / Limitations

- GPL-3.0 licensing makes it stronger as a study/reference source than as a direct implementation source for many teams.
- The repository is intentionally tied to one puzzle format, so its domain logic is not as broadly reusable as a generic engine.
- Full local Gradle verification in this lab is still blocked by the Java `17+` floor.

## Notes

`arrows_game` is a good example of a small Android game that is more serious than its footprint suggests. The biggest reason to keep it is not popularity, but the combination of testable solvability logic, readable modular structure, and a Compose rendering shell that still feels product-oriented rather than demo-only.
