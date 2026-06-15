# titanium

## Basic Info

- Project name: `titanium`
- Source repository: `https://github.com/digorydoo/titanium`
- Author / organization: `digorydoo`
- License: `GPL-3.0`
- Research note: [research/findings/digorydoo-titanium.md](../../research/findings/digorydoo-titanium.md)
- Investigated commit: `ef2202d17a61a261ab68c7dce4b00e9fd5448783`
- Last verified: `2026-06-15`
- Activity / maintenance status: fresh at selection; last push visible on `2026-06-14`

## Short Description

Large Kotlin/JVM 3D engine-and-game workspace with a strict engine/game/host/tool split, custom collision and rigid-body logic, staged scene loading, explicit LWJGL runtime ownership, and first-class asset-import tooling.

## Technical Profile

- Primary category: `engine-framework`
- Focus tags: `3d`, `opengl`, `physics`, `asset-pipeline`, `input`, `testing`
- Engine / framework: custom Kotlin JVM engine + LWJGL + GLFW + OpenGL + OpenAL
- Rendering approach: desktop OpenGL host in `titanium-main` over engine-side render abstractions
- Main language(s): `Kotlin`
- Android target: no direct Android module checked in
- Build system: `Gradle` (Kotlin DSL)

## Why It Matters

This project is a strong architecture reference when we want a Kotlin game stack with sharper boundaries than a monolithic engine app:

- engine and game layers avoid direct OpenGL coupling
- the desktop runtime host keeps window or GL glue separate from gameplay systems
- collision, rigid-body, and scene-loading logic are implemented in readable Kotlin
- asset preprocessing is treated as a normal checked-in toolchain

## Reusable Ideas

- Gameplay ideas: staged scene transitions with progress, layered active-scene content, and in-game editor-mode flow
- Architecture patterns: abstract global app container, host-owned frame loop, strict engine/game/tool module boundaries, and staged loader orchestration
- Graphics / rendering techniques: separate shadow and regular passes, explicit GL-host ownership, and brick-volume plus gel-layer render splits
- Input / UI approaches: unified keyboard/gamepad accessor model with synthesized joystick vectors
- Performance or optimization ideas: vicinity-cached collision candidates, multi-pass separation retries, and asset preprocessing into custom binary formats

## Notable Implementations

- `App.kt` plus `AppImpl.kt` keep subsystem ownership abstract in the engine and concrete in the desktop host
- `Main.kt` owns GLFW lifecycle, frame pacing, rendering passes, and shutdown/lock-file recovery
- `SceneLoader.kt` stages content loading through explicit phases and HUD-visible progress
- `CollisionManager.kt` and `CollisionHandler.kt` implement primary/secondary separation plus guarded recovery logic
- `tool-import-asset` preserves a real Collada and brick-texture preprocessing pipeline in Kotlin

## Android Relevance

- Native Android use: none in the inspected revision
- Kotlin relevance: high; the whole runtime and tooling stack is Kotlin-first
- Porting or adaptation notes: strongest reuse is in architecture, staging, input abstraction, and collision/tooling patterns rather than in the current desktop host shell

## Risks / Limitations

- desktop-only checked-in runtime
- external assets and sibling `kutils` setup are required for fuller local reproduction
- Windows workflow still depends on shell/Cygwin steps
- GPL-3.0 is better suited to research/reference use than to direct reuse

## Notes

This is one of the clearer engine-architecture references in the lab for teams that may eventually want their own Kotlin runtime and tooling stack instead of building only inside Compose or LibGDX conventions.
