# Project Entry

## Basic Info

- Project name: `Canopy`
- Source repository: [https://github.com/canopyengine/canopy](https://github.com/canopyengine/canopy)
- Author / organization: `canopyengine`
- License: `Apache-2.0` via GitHub metadata; the repository root also contains `LICENSE-APACHE` and `LICENSE-MIT`
- Research note: [research/findings/canopyengine-canopy.md](../../research/findings/canopyengine-canopy.md)
- Investigated commit: `44fca3ef4d869e5e35b121992ee45ca7e07bf088`
- Last verified: `2026-06-04`
- Activity / maintenance status: active at selection; GitHub showed a push on `2026-06-01`, and the latest inspected commit on `2026-05-19` was still a real dependency maintenance change rather than a dead archive marker.

## Short Description

Node-driven Kotlin engine workspace with a reusable app shell, tree-based scene runtime, small reactive state layer, libGDX adapter seams, headless and terminal hosts, and a stronger-than-usual devtools test harness, even though the checked-in desktop graphics path is currently excluded from the active build.

## Technical Profile

- Primary category: `engine-framework`
- Focus tags: `2d`, `scene-graph`, `libgdx`, `input`, `testing`
- Engine / framework: custom Kotlin engine with node-tree runtime, behavior attachment, scene ownership, phased tree systems, save modules, and backend adapters
- Rendering approach: active build is mostly host/runtime oriented; a larger libGDX-backed desktop rendering/physics path exists in the repository but is excluded from the active Gradle graph and should be treated as a stale reference
- Main language(s): Kotlin
- Android target: indirect; no active Android module is included, but the runtime, input, save, and testing architecture still transfers well to Kotlin Android game work
- Build system: Gradle multi-module workspace with `engine`, `platforms:headless`, `platforms:terminal`, `adapters:libgdx`, `tooling:devtools`, and `tooling:utils`, using Kotlin `2.3.21` and an explicit Java `17` / `21` toolchain story

## Why It Matters

- `canopy` is a useful reference for teams that want a small engine with clear runtime ownership instead of jumping directly to a large ECS or heavy multiplatform stack.
- Its main value is not a finished rendering layer; it is the combination of node-tree composition, behavior attachment, phased scene processing, modular saves, backend-bound input, and deterministic headless testing.

## Reusable Ideas

- Gameplay ideas:
  - mostly engine/runtime oriented rather than genre-specific gameplay
- Architecture patterns:
  - app shell plus scene manager, DSL-built node tree, attached behaviors, and phase-based tree systems
- Graphics / rendering techniques:
  - host/runtime separation and backend adapters, with the caution that the current desktop rendering path is excluded from the active build
- Input / UI approaches:
  - abstract input actions and transitions, backend-specific key binding, and subsystem-level save registration
- Performance or optimization ideas:
  - fixed-step accumulator, centralized scene indexes/groups, and a small reactive dependency graph rather than ad hoc polling everywhere

## Notable Implementations

- `App` centralizes lifecycle, launch, manager setup, and backend exit handling.
- `Node` and `Behavior` provide a readable node-tree composition model that avoids forcing all logic into deep subclass hierarchies.
- `SceneManager` plus `TreeSystem` turn the repository into a coherent runtime rather than a loose utility set.
- `Signal`, `Computed`, and `Effect` show a compact reactive state layer built into the engine.
- `SaveManager` stores per-module JSON save slices instead of one monolithic global blob.
- `InputManager` and `GdxInputManager` keep control schemes engine-owned while still binding to a concrete backend.
- `AppTestDriver` and the app/screen tests make the runtime demonstrably more reliable than a comparable zero-test hobby engine.

## Android Relevance

- Native Android use:
  - no direct Android module is active in the inspected build
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - most useful as an architecture reference for small Kotlin Android games or internal runtimes, especially around scene ownership, save/input seams, and headless verification

## Risks / Limitations

- The repository's strongest rendering-looking code lives in `platforms/desktop`, but that module is excluded from `settings.gradle.kts` and appears partially stale.
- README, version, and license messaging are not fully aligned with the active code/build surface.
- `InputSystem` still looks somewhat incomplete in the inspected revision.
- `Signal` uses `runBlocking` for emission, which is a weak fit for UI-sensitive Android usage if copied blindly.

## Notes

This is worth keeping as a compact engine-architecture reference, but it should be cited primarily for runtime structure, saves, input, and testing patterns rather than as a fully trusted graphics or Android runtime baseline.
