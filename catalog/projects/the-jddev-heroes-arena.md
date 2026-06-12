# Project Entry

## Basic Info

- Project name: `Heroes Arena`
- Source repository: [https://github.com/The-JDdev/Heroes-Arena](https://github.com/The-JDdev/Heroes-Arena)
- Author / organization: `The-JDdev`
- License: `MIT`
- Research note: [research/findings/the-jddev-heroes-arena.md](../../research/findings/the-jddev-heroes-arena.md)
- Investigated commit: `61a4ae8769cc46e4ae1af09d2f0f11c3fde61bf0`
- Last verified: `2026-06-12`
- Activity / maintenance status: very fresh but still clearly early; the last pushed code revision at selection was `2026-06-11`, and the latest commit message was `fix: compilation errors and build fixes for APK generation`.

## Short Description

Android-native MOBA-style prototype with a custom `SurfaceView` runtime, menu/product shell activities, hero/item data, and several still-stubbed online-service seams.

## Technical Profile

- Primary category: `reference-only`
- Focus tags: `2d`, `android`, `input`, `ui-hud`, `ai`, `audio`
- Engine / framework: custom Android `SurfaceView` game shell
- Rendering approach: manual `Canvas` rendering for battlefield, entities, HUD, minimap, and touch overlays, with standard Android XML activity screens for menus and meta features
- Main language(s): Kotlin
- Android target: direct Android app only
- Build system: single-module Android Gradle project with AGP `8.2.2`, Kotlin `1.9.22`, and wrapper metadata for Gradle `8.5`

## Why It Matters

- `Heroes Arena` is useful because it is a direct Android-native custom-loop game shell rather than another Compose or LibGDX sample.
- It is especially relevant as a comparison point for:
  - `SurfaceView`-driven loop ownership
  - touch-region joystick plus skill-button controls
  - menu/product-shell framing around a local-only gameplay core
- It should stay `reference-only` because the codebase is still much thinner than the README implies, online features are explicit stubs, and no real automated verification surface is present.

## Reusable Ideas

- Gameplay ideas:
  - local AI-vs-AI or player-vs-AI lane-combat shell inside a simple Android-native runtime
- Architecture patterns:
  - one direct runtime owner for map, combat, HUD, and touch handling
  - separate menu/product activities around a custom in-match view
- Graphics / rendering techniques:
  - single-pass `Canvas` world rendering with HUD plus minimap overlays
- Input / UI approaches:
  - left-side joystick region and right-side skill-button region
  - standard activity-based shell for hero select, settings, profile, shop, and ranking
- Performance or optimization ideas:
  - minimal thread-based frame pacing and delta clamping for a small custom Android game

## Notable Implementations

- `GameLoop.kt` shows a small thread-driven Android loop with explicit FPS targeting.
- `GameView.kt` shows `SurfaceView` ownership, touch-region controls, and render overlays.
- `GameEngine.kt` provides a readable but monolithic direct-Android shell for:
  - hero spawning
  - simple AI
  - tower/minion/base state
  - minimap/HUD rendering
  - player movement and skill input
- `Hero.kt`, `Skill.kt`, and `Item.kt` show that the repository contains meaningful authored gameplay data even though the runtime remains simple.
- `NetworkManager.kt` is valuable mainly as a cautionary seam because it documents intended services while proving they are still unavailable in the checked-in build.

## Android Relevance

- Native Android use:
  - strong; the repo is a direct Android-only app shell built around activities and `SurfaceView`
- Kotlin relevance:
  - high for small or mid-sized custom-loop Android games
- Porting or adaptation notes:
  - best used as a reference for touch controls, menu flow, and compact Android-native runtime structure, not as a full MOBA gameplay baseline

## Risks / Limitations

- README text quality is degraded by encoding corruption.
- Online/product features are overstated relative to the checked-in code.
- No automated tests were found.
- The runtime is monolithic and early-stage.
- The repository checks in `gradlew` but not `gradlew.bat`, which weakens Windows reproducibility.

## Notes

Keep `Heroes Arena` as `reference-only`: it is a useful Android-native `SurfaceView` comparison sample with more real code than a pure UI mockup, but it does not currently justify promotion into the main accepted Android-game baseline set.
