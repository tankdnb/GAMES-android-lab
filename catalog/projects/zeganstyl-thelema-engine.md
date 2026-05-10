# Project Entry

## Basic Info

- Project name: `Thelema Engine`
- Source repository: [https://github.com/zeganstyl/thelema-engine](https://github.com/zeganstyl/thelema-engine)
- Author / organization: `Anton Trushkov` / `zeganstyl`
- License: `Apache-2.0`
- Research note: [research/findings/zeganstyl-thelema-engine.md](../../research/findings/zeganstyl-thelema-engine.md)
- Investigated commit: `8e2943b6d2de3376ce338025b58ff31c14097caf`
- Last verified: `2026-05-11`
- Activity / maintenance status: last push recorded at selection was `2022-12-21`; the repository is feature-rich but currently stale.

## Short Description

Kotlin Multiplatform 3D engine derived from libGDX concepts and extended with a hybrid entity/component scene model, node-based shaders, glTF loading, image-based lighting tools, ODE physics integration, direct Android platform support, and a separate studio/editor module.

## Technical Profile

- Primary category: `engine-framework`
- Focus tags: `3d`, `android`, `multiplatform`, `scene-graph`, `opengl`, `shader`, `physics`, `asset-pipeline`
- Engine / framework: custom Thelema engine
- Rendering approach: custom scene renderer with frustum culling, PBR shader nodes, optional G-buffer output, framebuffer-based post effects, and in-engine IBL cubemap/LUT baking
- Main language(s): Kotlin
- Android target: direct Android platform layer in `androidMain` plus a custom `GLSurfaceView`-based `AndroidApp`
- Build system: Gradle Kotlin DSL with Kotlin Multiplatform, Android, `buildSrc`, `tests`, and `thelema-studio`

## Why It Matters

- This repository gives the lab a real Kotlin-first 3D engine reference rather than another 2D sample or gameplay-only project.
- For Android game development, its value is twofold: direct platform adapters for Android and a reusable set of renderer/asset-pipeline patterns that can transfer into future Kotlin engines or Android-facing 3D runtimes.

## Reusable Ideas

- Gameplay ideas:
  - scene/prefab instancing via copy-and-mirror entity trees rather than only static authored scenes
- Architecture patterns:
  - descriptor-driven entity/component metadata that serves runtime composition, serialization, and editor tooling at the same time
  - async parsing plus queued GL-thread uploads for heavy asset types like glTF
- Graphics / rendering techniques:
  - node-based PBR shader assembly with deferred/G-buffer hooks
  - built-in irradiance, prefilter cubemap, and BRDF LUT baking for IBL workflows
- Input / UI approaches:
  - thin Android input bridge that maps `MotionEvent`/`KeyEvent` into shared engine touch, mouse, and keyboard services
  - shared platform-service registration for files, audio, images, websockets, and GL
- Performance or optimization ideas:
  - branch-level renderable/light collection with optional frustum culling
  - framebuffer-swapper post-processing chain that reuses velocity and brightness maps across effects

## Notable Implementations

- `Entity` and `ECS` form a hybrid scene graph / component registry with path-based addressing and editor-friendly property descriptors.
- `Project`, `Loader`, and `EntityLoader` stage resources centrally and start simulation only after the main scene is ready.
- `SceneInstance` mirrors branch changes from a source scene into local instances, acting like a prefab/reference scene system.
- `GLTF` combines off-thread parsing with queued GL calls and configurable import behavior through `GLTFSettings`.
- `PBRShader`, `PBRNode`, and `GBufferOutputNode` show a non-trivial shader-node stack grounded in real PBR/deferred rendering needs.
- `IBLMapBaker` keeps irradiance/prefilter/BRDF LUT generation inside the engine rather than pushing it entirely into offline tooling.
- `RigidBodyPhysicsWorld` integrates ODE with explicit contact begin/update/end dispatch and descriptor-registered shapes/bodies.

## Android Relevance

- Native Android use:
  - direct Android platform support is implemented, not merely implied, through `androidMain` and `AndroidApp`
- Kotlin relevance:
  - very high, because the engine core, loaders, shader composition, scene system, and platform glue are Kotlin-first throughout
- Porting or adaptation notes:
  - the Android layer is useful as a reference for thin platform adaptation around a shared engine core
  - the strongest transfer value is in renderer architecture, asset loading, scene instancing, and service abstraction, not in copying the stale build stack as-is

## Risks / Limitations

- Stale maintenance status.
- Gradle discovery in the lab fails without a full JDK.
- Old dependency/tooling stack.
- Tiny automated test surface relative to the engine's size.
- Likely single-pointer bias in the Android input bridge.
- Forward rendering pipeline still carries a resize-related `FIXME`.

## Notes

This project is accepted as an `engine-framework` reference because it compresses a rare combination of Kotlin Multiplatform runtime design, Android platform glue, 3D rendering, glTF import, shader tooling, physics, and editor-oriented metadata into one repository. It is not a modern turnkey baseline, but it is a strong library of ideas for future Android-oriented Kotlin engine work.
