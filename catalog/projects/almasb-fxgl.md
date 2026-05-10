# Project Entry

## Basic Info

- Project name: `FXGL`
- Source repository: [https://github.com/AlmasB/FXGL](https://github.com/AlmasB/FXGL)
- Author / organization: `AlmasB`
- License: `MIT`
- Research note: [research/findings/almasb-fxgl.md](../../research/findings/almasb-fxgl.md)
- Investigated commit: `f418525e0079c4dd2ae0baaed63a03beadc9e2e8`
- Last verified: `2026-05-10`

## Short Description

Mature modular game framework with strong service-oriented engine patterns, reusable input/physics/persistence/networking subsystems, and a JavaFX-first runtime.

## Technical Profile

- Primary category: `reference-only`
- Focus tags: `2d`, `input`, `physics`, `ui-hud`, `networking`
- Engine / framework: FXGL
- Rendering approach: JavaFX-centered runtime with separate core and IO modules
- Main language(s): Kotlin, Java
- Android target: claimed by the project, but not directly verified in this pass
- Build system: Maven multi-module project

## Why It Matters

- It is a useful comparison point for mature engine-service architecture even though it is not the most direct Android template.
- Several subsystems are broadly reusable as design references: lifecycle services, input capture, virtual controls, save/load handlers, networking, and physics wrapping.

## Reusable Ideas

- Gameplay ideas:
  - not the main value of this repository
- Architecture patterns:
  - service lifecycle with explicit init, ready, tick, pause/resume, reset, and exit phases
- Graphics / rendering techniques:
  - the main value is subsystem organization around the rendering shell
- Input / UI approaches:
  - centralized input service, virtual controls, and input capture/replay
- Performance or optimization ideas:
  - reusable entities and optional update disabling

## Notable Implementations

- `EngineService` defines the runtime service lifecycle.
- `Entity` guarantees core components and supports reusable pooled entities.
- `Input` centralizes action bindings, triggers, and event handling.
- `VirtualInput` and `InputCapture` are strong references for touch overlays and replayable input sequences.
- `PhysicsWorld` owns collision and step orchestration.
- `SaveLoadService` and `NetService` package persistence and networking as reusable services.

## Android Relevance

- Native Android use:
  - not directly verified in this pass
- Kotlin relevance:
  - moderate to high, but mixed with significant Java implementation
- Porting or adaptation notes:
  - best used as a service-architecture and subsystem reference, not as a primary Android implementation model

## Risks / Limitations

- JavaFX-first runtime assumptions reduce direct Android transfer.
- Mixed Java/Kotlin code increases adaptation cost.
- No build validation was attempted in this batch.

## Notes

Keep this as a comparison/reference project rather than as a main Android-targeted anchor.
