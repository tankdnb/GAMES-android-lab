# Project Entry

## Basic Info

- Project name: `CaveDroid`
- Source repository: [https://github.com/fredboy/cavedroid](https://github.com/fredboy/cavedroid)
- Author / organization: `fredboy`
- License: `MIT`
- Research note: [research/findings/fredboy-cavedroid.md](../../research/findings/fredboy-cavedroid.md)
- Investigated commit: `68d22d2b66341f0ea354f03b5381b3ee3ed26665`
- Last verified: `2026-05-11`
- Activity / maintenance status: active at selection; the repository was last pushed on `2026-05-08`, and the inspected workspace targets a current Gradle `9.0.0` / Java `17` toolchain.

## Short Description

2D Minecraft-inspired sandbox game for Android and desktop built with Kotlin, LibGDX, and Box2D, with a horizontally looped world, procedural terrain/caves/ores, touch-first controls, inventory windows, and a compact but product-like build/release surface.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `2d`, `android`, `libgdx`, `physics`, `input`, `save-load`, `procedural-generation`, `ui-hud`
- Engine / framework: LibGDX + Box2D + Box2DLights + Dagger
- Rendering approach: layered LibGDX rendering with chunk frame buffers, world/HUD cameras, seam-aware lighting, and tile/background shading passes
- Main language(s): Kotlin, Java
- Android target: direct Android launcher activity with shared game core
- Build system: multi-module Gradle Kotlin DSL monorepo

## Why It Matters

- This repository is one of the stronger direct Android LibGDX references in the lab because it combines real gameplay/runtime depth with Android-facing touch controls and packaging rather than stopping at a tiny prototype.
- Its best value is not just “another sandbox clone,” but the way it handles horizontally wrapped worlds across camera, lighting, and physics, while also keeping procedural worldgen, inventory UX, and persistence in reusable shapes.

## Reusable Ideas

- Gameplay ideas:
  - chunk-based sandbox world updates, day/night-dependent mob spawning, biome-driven terrain dressing, and localized fluid simulation
- Architecture patterns:
  - per-session Dagger component assembly, timer-driven world-logic tasks alongside a slimmer frame loop, and explicit cursor-vs-walk control modes
- Graphics / rendering techniques:
  - chunk frame-buffer caching, layered background shading, seam-aware light updates, and wrapped-world edge mirroring
- Input / UI approaches:
  - left-half joystick with short-tap jump/fly, touch HUD suppression while windows are open, inventory pointer ownership, and branch-specific onboarding flow
- Performance or optimization ideas:
  - incremental dirty-chunk updates, clustered static-body rebuilding, nearby-only fluid updates, and compact save formats for large tile maps

## Notable Implementations

- `GameWorld` wraps horizontal world access and keeps Box2D stepping fixed-step.
- `ChunkedGameWorldSolidBlockBodiesManagerImpl` builds mirrored chunk colliders for seam-safe physics and lighting.
- `GameWorldGenerator` layers biomes, terrain noise, caves, ores, water, and lava into one compact worldgen pipeline.
- `SaveDataRepositoryImpl` mixes dictionary + RLE + GZIP tile storage with ProtoBuf controller snapshots and save-slot screenshots.
- `JoystickInputHandler` and `TouchControlsRenderer` form a practical touch control model for sandbox games.
- `GameWindowsManager`, inventory window classes, and onboarding controller keep gameplay UI state explicit instead of burying it inside rendering code.
- `android/build.gradle.kts` adds real release hygiene through product flavors, native extraction, notices, and generated attribution indexes.

## Android Relevance

- Native Android use:
  - yes; this is a direct Android LibGDX game with a dedicated launcher and touch-specific runtime behavior
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - the repository is worth mining for wrapped-world infrastructure, sandbox update patterns, touch input flow, and save architecture even if a future project does not copy its LibGDX stack directly

## Risks / Limitations

- Build verification in the lab is currently blocked by the repository's Java `17+` requirement.
- Desktop Windows builds additionally need asset-symlink handling according to the upstream README.
- The repository still has relatively low ecosystem signal by stars, so its value should be judged by code and fit rather than popularity.
- The codebase is modular and substantial, so it is better used as a reference library than as a drop-in starter.

## Notes

Treat `CaveDroid` as a strong Android sandbox/runtime reference. It is especially valuable when future work needs seam-safe looped worlds, chunked tile physics/rendering, or a compact save format for large mutable maps.
