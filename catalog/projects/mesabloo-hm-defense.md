# Project Entry

## Basic Info

- Project name: `Heavy MACH: Defense`
- Source repository: [https://github.com/Mesabloo/hm-defense](https://github.com/Mesabloo/hm-defense)
- Author / organization: `Mesabloo`
- License: `BSD-3-Clause`
- Research note: [research/findings/mesabloo-hm-defense.md](../../research/findings/mesabloo-hm-defense.md)
- Investigated commit: `a4446660141e78829aa573af2e66de3329a19d00`
- Last verified: `2026-06-04`
- Activity / maintenance status: ambiguous and likely stale in code terms; GitHub metadata showed a later push at selection time, but the latest inspected commit in the cloned default-branch snapshot was `2022-06-23`, and the advertised Android target is still TODO-only in the checked-in tree.

## Short Description

Unfinished libGDX rewrite of the old mobile game *Heavy MACH: Defense*, built around a Scene2D HUD shell, a Box2D-backed battlefield, and data-driven build and upgrade tables.

## Technical Profile

- Primary category: `reference-only`
- Focus tags: `2d`, `libgdx`, `physics`, `ui-hud`, `save-load`, `asset-pipeline`
- Engine / framework: custom libGDX game shell with Scene2D UI, Box2D world glue, and a desktop LWJGL host
- Rendering approach: Scene2D actors plus a small deferred z-sorted batcher, texture atlases, and Box2D debug rendering
- Main language(s): Kotlin
- Android target: none checked in; the README mentions a future Android port, but the repository currently contains only `core` and `desktop`
- Build system: multi-module Gradle Groovy DSL build with Java `11` targets and libGDX `1.11.0`

## Why It Matters

- `hm-defense` is worth keeping as a compact comparison sample for libGDX/Scene2D game-shell structure, especially if we need ideas for portrait HUD composition, scrollable battlefields, production queues, or simple minimap/radar overlays.
- It is not strong enough to use as a primary Android baseline because the Android target is missing, the runtime is unfinished, and the visible test surface is effectively absent.

## Reusable Ideas

- Gameplay ideas:
  - build-slot plus build-queue economy flow driven by save state and JSON balance data
- Architecture patterns:
  - `core` gameplay module plus thin `desktop` launcher, screen-owned UI worlds, and actor-synced Box2D stepping
- Graphics / rendering techniques:
  - tiny deferred z-sorted batcher and a radar that mirrors a scrollable battlefield viewport
- Input / UI approaches:
  - dense Scene2D HUD composition with tweened side menus and slot state derived from progression data
- Performance or optimization ideas:
  - centralized atlas/data lookup and a small world-to-actor sync layer instead of per-feature render ownership

## Notable Implementations

- `AbstractScreen.kt` gives each screen one `UIWorld`, grouped background/foreground actors, and tween-driven transition flow.
- `StageScreen.kt` composes the battlefield, HUD, queue, slot panels, radar, and menus into one readable Scene2D shell.
- `Batcher.kt` defers draw calls and sorts by z-index only at flush time.
- `Radar.kt` turns the active `ScrollPane` viewport into a minimap-style overlay.
- `GameSave.kt` plus `build-info.json` and `upgrades.json` keep progression and balance data typed and externalized.

## Android Relevance

- Native Android use:
  - none in the checked-in repository
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - useful for libGDX UI/runtime patterns, but not for Android shell code or current mobile packaging because the Android host module is absent

## Risks / Limitations

- The README promises Desktop and Android, but Android remains TODO-only in the checked-in tree.
- `BuildQueue.kt` still stops at `"TODO: create machine in world"`, which leaves a major gameplay loop incomplete.
- `TurretBuildSlot` is still unfinished.
- No meaningful automated tests were found.
- The visible code activity looks stale in practice even though repository metadata at selection time appeared less stale.

## Notes

Keep this as a `reference-only` libGDX rewrite sample. It is useful when we want small, readable HUD/runtime ideas, but it should not be treated as a current Android game foundation.
