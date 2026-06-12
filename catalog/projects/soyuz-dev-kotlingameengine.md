# KotlinGameEngine

## Basic Info

- Project name: `KotlinGameEngine`
- Source repository: `https://github.com/soyuz-dev/KotlinGameEngine`
- Author / organization: `soyuz-dev`
- License: `LGPL-3.0`
- Research note: [research/findings/soyuz-dev-kotlingameengine.md](../../research/findings/soyuz-dev-kotlingameengine.md)
- Investigated commit: `d3b54990abf7a5fceb64b96ccee770ef579163a0`
- Last verified: `2026-06-12`
- Activity / maintenance status: very fresh at selection; last push visible on `2026-06-12`

## Short Description

Compact Kotlin/LWJGL 2D engine prototype with a fixed-step loop, callback-driven entities, SAT and closest-point collision code, impulse-based physics resolution, joints, dynamic force fields, and a small but real unit-test surface.

## Technical Profile

- Primary category: `engine-framework`
- Focus tags: `2d`, `opengl`, `physics`, `collision`, `input`, `testing`
- Engine / framework: custom Kotlin JVM engine + LWJGL + GLFW + OpenGL
- Rendering approach: shader-based OpenGL 3.3 pipeline with explicit mesh, camera, and painter abstractions
- Main language(s): `Kotlin`
- Android target: no direct Android module checked in
- Build system: `Gradle` (Kotlin DSL)

## Why It Matters

This project is a good compact engine reference when we want low-ceremony runtime architecture instead of a large framework:

- fixed-step runtime ownership is explicit and reusable
- entity behavior stays lightweight without adopting a full ECS
- collision and physics math are readable and easy to adapt
- tests exist around the most failure-prone low-level pieces

## Reusable Ideas

- Gameplay ideas: physics-first toy-simulation assembly through joints, force fields, and collision callbacks
- Architecture patterns: accumulator-based loop, callback-owned entities, scene lifecycle ownership, and a tiny event bus
- Graphics / rendering techniques: explicit shader/mesh/camera split and entity-owned painter binding
- Input / UI approaches: singleton keyboard/mouse facade for a small engine host
- Performance or optimization ideas: staged physics pipeline, circle CCD against AABBs, and gravity-force culling via exponent precheck

## Notable Implementations

- `RuntimeEngine` keeps init/cleanup, fixed updates, and render interpolation explicit
- `RuntimeScene` and `DefaultGameEntity` show a direct-reference alternative to ECS
- `RuntimeCollisionSystem` combines SAT, rect-circle closest-point checks, and contact generation
- `RuntimePhysicsSystem` uses a multi-phase force/CCD/contact/joint/velocity pipeline
- `PointMass`, `RigidBody`, `GravityField`, and joint implementations give the repo more real engine substance than a normal graphics prototype

## Android Relevance

- Native Android use: none in the inspected revision
- Kotlin relevance: high; the full engine code is Kotlin-first
- Porting or adaptation notes: strongest reuse is in fixed-step runtime, collision, and physics structure, not in the current desktop host shell

## Risks / Limitations

- desktop-only LWJGL/GLFW host
- broadphase and rectangle CCD are still explicitly unfinished
- documentation text encoding is rough in places
- LGPL-3.0 introduces stricter downstream reuse considerations than more permissive references

## Notes

This is a stronger engine reference than its tiny public signal suggests. The main value is not Android readiness, but the readability of its fixed-step loop, callback-entity model, staged collision/physics pipeline, and targeted low-level tests.
