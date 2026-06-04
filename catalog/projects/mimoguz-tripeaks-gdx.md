# Project Entry

## Basic Info

- Project name: `TriPeaks`
- Source repository: [https://github.com/mimoguz/tripeaks-gdx](https://github.com/mimoguz/tripeaks-gdx)
- Author / organization: `mimoguz`
- License: `GPL-3.0`
- Research note: [research/findings/mimoguz-tripeaks-gdx.md](../../research/findings/mimoguz-tripeaks-gdx.md)
- Investigated commit: `71d61a14441bd58a1160fd0bea7b1c7cb1e20047`
- Last verified: `2026-06-04`
- Activity / maintenance status: still publicly maintained enough to matter, with the latest inspected commit on `2025-03-15`, but the README now actively points readers toward the newer `tripeaks_neue` reimplementation as the future-facing line.

## Short Description

Small TriPeaks solitaire game built with libGDX and Kotlin, shipped as a shared core with Android and LWJGL3 desktop launchers, explicit theme and layout variants, and a more structured runtime than most compact card-game samples.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `2d`, `android`, `libgdx`, `input`, `ui-hud`, `save-load`
- Engine / framework: libGDX + LibKTX + Stripe UI + Android SDK + LWJGL3
- Rendering approach: SpriteBatch-based 2D card rendering with a custom constant-height viewport, pooled card and animation views, and a framebuffer-backed blur or pixelate pass for paused or transitional states
- Main language(s): Kotlin
- Android target: direct Android app with shared assets, `minSdk 19`, `targetSdk 35`, immersive landscape mode, and shared core logic
- Build system: Gradle `8.8` wrapper + AGP `8.5.2` + Kotlin `2.0.0` + Java target `17`

## Why It Matters

- This repository is worth keeping because it shows how much useful structure can fit into a small Android card game: pure rules, layout graphs, pooled rendering, settings factories, migration-aware persistence, and real mobile plus desktop packaging.
- For the lab, the reusable value is less about solitaire itself and more about the way the project keeps gameplay, layout geometry, screen orchestration, rendering modes, and save-state handling separate without becoming heavy.

## Reusable Ideas

- Gameplay ideas:
  - model stacked-card puzzles through socket graphs with `blocks` and `blockedBy` relationships instead of handwritten visibility rules
- Architecture patterns:
  - assemble one shared runtime through a tiny injected context, then keep normal, paused, and transition rendering behaviors in separate screen-state objects
- Graphics / rendering techniques:
  - pair a simple renderer with an offscreen blur or pixelate renderer so paused states and transitions do not complicate the main drawing path
- Input / UI approaches:
  - anchor HUD buttons to viewport edges and resolve card-board touches through layout-cell lookup plus top-most candidate search
- Performance or optimization ideas:
  - pool card and animation view objects, resync only changed sockets and their dependents, and keep a constant-height viewport while widening horizontally on larger devices

## Notable Implementations

- `GameState.kt` owns stack, discard, tableau, undo, restart, and stalled detection in pure Kotlin.
- `Layout.kt`, `Socket.kt`, and the concrete layout variants encode board geometry and blocker relationships declaratively.
- `PersistenceService.kt` stores JSON saves and settings in LibGDX preferences and migrates several older formats.
- `GameView.kt` uses pooled card and animation views with selective neighbor resync after moves.
- `Renderer.kt` and `CustomViewport.kt` implement the normal versus blurred render split and a constant-height scaling policy.
- `AndroidLauncher.kt` forwards Android dark-mode state into shared settings instead of duplicating theme logic in platform code.
- `lwjgl3/build.gradle` and `fastlane/metadata/android/` preserve both desktop packaging and Android release metadata.

## Android Relevance

- Native Android use:
  - yes, direct Android application module with shared assets, immersive mode, game manifest metadata, and a shared Kotlin core
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - the best pieces to reuse are the layout-graph rules model, the renderer or viewport split, and the persistence plus migration layer; they transfer well to casual card, puzzle, or board games beyond solitaire

## Risks / Limitations

- The upstream author is already steering users toward `tripeaks_neue`, so this repository may not remain the main future code line.
- No automated tests were found.
- No checked-in CI workflows were found.
- Local Gradle validation in this lab stops at the missing newer JDK, while the checked-in build also targets Java `17`.
- One clear code-quality caveat exists in `GameScreenSwitch.dispose()`, which iterates map entries instead of state values and likely skips disposal of state-owned render resources.

## Notes

`TriPeaks` is a good reminder that even a small solitaire project can be a worthwhile Android research reference if it treats rules, rendering, settings, and persistence as first-class seams instead of packing everything into one screen class.
