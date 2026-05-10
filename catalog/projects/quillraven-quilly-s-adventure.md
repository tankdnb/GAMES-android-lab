# Project Entry

## Basic Info

- Project name: `Quilly's Adventure`
- Source repository: [https://github.com/Quillraven/Quilly-s-Adventure](https://github.com/Quillraven/Quilly-s-Adventure)
- Author / organization: `Quillraven`
- License: `MIT`
- Research note: [research/findings/quillraven-quilly-s-adventure.md](../../research/findings/quillraven-quilly-s-adventure.md)
- Investigated commit: `a477151a7e5e29d680ea00d771d8f175bd2d6b7d`
- Last verified: `2026-05-10`

## Short Description

Kotlin LibGDX adventure/platformer sample that combines Ashley ECS, Box2D physics, Tiled-authored maps, touch-first HUD controls, portal-based map transitions, scripted triggers, and lightweight save progression.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `2d`, `android`, `libgdx`, `physics`, `save-load`, `input`, `ui-hud`, `asset-pipeline`
- Engine / framework: LibGDX + LibKTX + Ashley ECS + Box2D
- Rendering approach: SpriteBatch + Tiled map renderer + Box2D Lights + shader filters + framebuffer-based transitions
- Main language(s): Kotlin
- Android target: direct Android application module with shared assets and touch HUD
- Build system: multi-module Gradle project with `android`, `core`, `lwjgl3`, and `teavm` targets

## Why It Matters

- This repository is a strong reference for Android-friendly action-adventure architecture built with Kotlin and LibGDX rather than with a heavier custom engine.
- The main value is not one isolated trick. It is the way multiple practical subsystems fit together cleanly: map-authored content, ECS entity factories, fixed-step Box2D, touch controls, savepoints, tutorials, triggers, and cross-platform packaging.

## Reusable Ideas

- Gameplay ideas:
  - portal-based room transitions, savepoint healing + persistence, item-driven stat growth, and trigger-scripted tutorial or boss events
- Architecture patterns:
  - Tiled object layers mapped into ECS entity factories, shared event bus, narrow save-state snapshots, and screen/dialog lifecycle control over ECS processing
- Graphics / rendering techniques:
  - layer parallax from Tiled properties, framebuffer crossfades for maps/screens, shader mode swaps, and sorted sprite rendering around Tiled foreground/background passes
- Input / UI approaches:
  - abstract input events shared between keyboard and touch HUD, plus a touchpad/action-button layout that does not leak platform details into gameplay logic
- Performance or optimization ideas:
  - fixed-step physics with interpolation, pooled Ashley components/entities, cached maps, and sound deduplication per frame

## Notable Implementations

- `EcsUtils` centralizes entity creation for characters, scenery, portals, items, missiles, and triggers.
- `MapManager` caches map objects and rebuilds only the relevant entities when changing maps.
- `PhysicSystem` keeps Box2D on a fixed update step and interpolates render positions.
- `PlayerCollisionSystem` connects portals, savepoints, items, and triggers into one progression flow.
- `Trigger` and `TriggerSystem` provide a small pooled scripting layer for map events.

## Android Relevance

- Native Android use:
  - yes; dedicated Android app module with touch controls and shared asset packaging
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - especially useful as a reference for Kotlin + LibGDX Android projects that want a clear gameplay-shell architecture without building a large custom engine first

## Risks / Limitations

- Current build validation needs Java `11+`; the lab machine still exposes Java `8`.
- Automated tests cover only a small part of the runtime.
- The repository is a focused adventure/platformer sample, not a broad engine or sandbox framework.

## Notes

This repository is especially useful when the lab wants practical patterns for combining Ashley ECS, Box2D, Tiled, touch HUDs, savepoints, and trigger-driven map events inside a compact Android-relevant game.
