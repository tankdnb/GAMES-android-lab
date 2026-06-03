# Project Entry

## Basic Info

- Project name: `Game 2048`
- Source repository: [https://github.com/andstatus/game2048](https://github.com/andstatus/game2048)
- Author / organization: `andstatus`
- License: `Apache-2.0`
- Research note: [research/findings/andstatus-game2048.md](../../research/findings/andstatus-game2048.md)
- Investigated commit: `59f363677fe4559f725b3db5d88fa626e8998070`
- Last verified: `2026-06-04`
- Activity / maintenance status: active at selection; the repository was pushed on `2025-11-29`, updated on GitHub on `2026-06-02`, and the latest inspected commit specifically targeted Android API 36 compatibility.

## Short Description

KorGE-based Kotlin Multiplatform 2048 product with a shared puzzle core, reversible move history, AI hint/autoplay modes, share/load support, and a separate Android app shell.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `2d`, `android`, `multiplatform`, `korge`, `input`, `save-load`, `ai`, `testing`
- Engine / framework: KorGE / Korlibs plus a separate Android application module
- Rendering approach: KorGE-based shared board/UI rendering with responsive virtual sizing and product-layer HUD composition
- Main language(s): Kotlin
- Android target: direct; the repository includes Android-specific source sets plus a dedicated `game2048-android` project reusing the same shared code and resources
- Build system: Gradle Kotlin DSL root project plus standalone Android Gradle application module

## Why It Matters

- `Game 2048` is one of the stronger small-product references in the lab because it treats persistence, replay, AI, and Android shell work as first-class design concerns instead of sample afterthoughts.
- It is especially useful as an example of how a narrow puzzle concept can still justify clean architecture, deep history handling, and a real platform-specific app surface.

## Reusable Ideas

- Gameplay ideas:
  - reversible ply-based move history, bookmarks, AI hints, AI autoplay, watch mode, and variable board sizes
- Architecture patterns:
  - clear split between `Presenter`, `Model`, `History`, and Android platform utilities instead of one monolithic scene/controller
- Graphics / rendering techniques:
  - responsive virtual board sizing and a board-local control overlay that stays separate from puzzle state
- Input / UI approaches:
  - swipe-first board control, replay/state-management UI, share/load affordances, and productized recent-game handling
- Performance or optimization ideas:
  - paged move-history storage, bounded in-memory cache for plies, async persistence, and precomputed board traversal links

## Notable Implementations

- `Board` precomputes directional traversal links for the whole puzzle grid.
- `GamePosition` records reversible `PieceMove` details that make undo/redo and deterministic replay practical.
- `History`, `GamePlies`, `PliesPageData`, and `ShortRecord` form a layered persistence model around current game, recent games, shareable JSON, and bounded page caching.
- `AiPlayer` supports several different move-selection strategies instead of one hardcoded hint heuristic.
- `MyMainActivity`, `PlatformUtilAndroid`, and `FileProvider` show concrete Android glue for fullscreen behavior, sharing, document loading, and screen/device integration.
- `game2048-android` keeps a normal Android Studio app path alive while still reusing the shared KMP game sources.

## Android Relevance

- Native Android use:
  - yes; Android is a first-class target, not only an eventual possibility
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - especially useful for Android puzzle or turn-step games that need durable history, hint systems, share/load, and a clean boundary between shared gameplay code and Android-specific hosting

## Risks / Limitations

- The game genre is narrow, so some ideas transfer more directly to puzzle products than to action-heavy games.
- The root `README.md` is stale about the current JVM floor; the actual build surface now expects much newer Java than the prose suggests.
- Local lab validation of root and Android Gradle tasks is still limited by the current Java `8` machine and missing Android SDK task execution path.
- The inspected tree did not show much CI/release automation, so the repository is a stronger gameplay/product reference than a workflow reference.

## Notes

This is a strong reference for turning a small Kotlin puzzle game into a real Android-facing product with persistence, replay, AI, and platform-specific shell work that all stay readable.
