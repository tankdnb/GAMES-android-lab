# Zernikalos

- Project: [Zernikalos/Zernikalos](https://github.com/Zernikalos/Zernikalos)
- Category: `engine-framework`
- Status: `accepted`
- License: `MPL-2.0`
- Language: `Kotlin`
- Engine / stack: custom Kotlin Multiplatform 3D engine with Android/OpenGL, Apple/Metal, and Web/WebGPU backends
- Android relevance: direct Android engine path with shared scene/runtime core and native `GLSurfaceView` integration

## Short Description

`Zernikalos` is a Kotlin-first multiplatform 3D engine that shares scene, context, serialization, and lifecycle logic across Android, Apple, and Web targets.

## Why It Matters

- Keeps Android as a first-class platform in a real multiplatform engine instead of only as a future target.
- Separates engine shell, scene state, rendering context, and platform surface ownership unusually clearly.
- Preserves reusable lifecycle and disposal patterns that are especially valuable for mobile rendering work.

## Key Reusable Ideas

- platform-specific surface adapters over a shared engine shell
- callback-driven initialization state machine before render readiness
- unified `ZContext` with scene-context vs rendering-context split
- queued frame-synchronous input processing
- recursive scene graph lifecycle with viewport resize propagation
- protobuf-backed serialized scene hierarchy loading
- tested deterministic component/renderer disposal behavior

## Main Caveats

- still explicitly positioned as experimental/prototyping-oriented
- low public signal at the time of research
- local Gradle discovery in the lab fails because Gradle `9.4.1` now requires Java `17+` while the machine still exposes Java `8`

## Suggested Focus Tags

`3d`, `android`, `multiplatform`, `scene-graph`, `opengl`, `webgpu`, `asset-pipeline`, `testing`
