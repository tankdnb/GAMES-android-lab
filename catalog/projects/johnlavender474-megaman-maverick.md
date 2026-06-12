# Megaman Maverick

## Basic Info

- Project name: `Megaman Maverick`
- Source repository: `https://github.com/JohnLavender474/Megaman-Maverick`
- Author / organization: `JohnLavender474`
- License: `MIT` for code; asset reuse is much more restricted because the project is a fan game built from Capcom and community assets
- Research note: [research/findings/johnlavender474-megaman-maverick.md](../../research/findings/johnlavender474-megaman-maverick.md)
- Investigated commit: `bb6fc749358fa3043e0193e87e9502b40b5619a9`
- Last verified: `2026-06-12`
- Activity / maintenance status: fresh at selection; last push visible on `2026-06-11`

## Short Description

Large Kotlin LibGDX fan game with a checked-in custom engine module, a gameplay-heavy `core`, Tiled-authored levels, controller remapping, boss or room event flow, and a real engine-level test surface.

## Technical Profile

- Primary category: `gameplay-systems`
- Focus tags: `2d`, `libgdx`, `input`, `collision`, `ui-hud`, `asset-pipeline`, `testing`, `audio`
- Engine / framework: custom Kotlin engine + LibGDX + LWJGL3
- Rendering approach: LibGDX sprite or shape rendering plus Tiled map rendering
- Main language(s): `Kotlin`
- Android target: no direct Android module checked in
- Build system: `Gradle` (Groovy DSL)

## Why It Matters

This project is a good reference when we want practical action-platformer architecture rather than only a small sample:

- reusable engine-side entity lifecycle and world systems
- game-specific collision logic layered cleanly on top
- room or checkpoint or boss flow treated as explicit runtime systems
- controller remapping and menu flow implemented as real product features

## Reusable Ideas

- Gameplay ideas: boss-room transitions, room-based platformer flow, checkpoint-driven respawn, and map-authored event triggers
- Architecture patterns: queue-based spawn or destroy lifecycle, engine/core module split, state-machine utilities, and event-driven screen or level flow
- Graphics / rendering techniques: sectioned draw queues, Tiled-layer builders, background ordering, and camera-managed room transitions
- Input / UI approaches: abstract controller buttons, keyboard plus controller remapping, and screen-specific menu controllers
- Performance or optimization ideas: fixed-step world accumulator, pluggable spatial containers, object pools, and optional runtime diagnostics

## Notable Implementations

- `GameEngine` queues spawns and destroys instead of mutating entity collections during iteration
- `WorldSystem` combines fixed-step simulation, contacts, collision resolution, diagnostics, and interchangeable spatial containers
- `MegaCollisionHandler` keeps one-way or climb-aware platform rules in the gameplay layer instead of hardcoding them into engine math
- `MegaLevelScreen` coordinates room transitions, checkpoint flow, boss intro handling, and system pause or resume gates
- `StateMachine` utilities and world-container tests provide stronger verification than is typical for a hobby action game

## Android Relevance

- Native Android use: no checked-in Android target in the inspected revision
- Kotlin relevance: high; the runtime and gameplay code are Kotlin-first
- Porting or adaptation notes: strongest reuse is in LibGDX gameplay/runtime patterns, not in platform-host code; the code architecture transfers better than the fan-game assets

## Risks / Limitations

- fan-game asset and music reuse is heavily constrained even though the code is under `MIT`
- desktop-only launcher in the inspected tree
- some core gameplay classes are large and need distillation before reuse
- local Gradle help currently needs Java `17+`

## Notes

This is a stronger gameplay-systems reference than its star count suggests. The main value is in the engine/gameplay split, world-query infrastructure, room or boss orchestration, and controller/runtime discipline, not in the legally constrained assets.
