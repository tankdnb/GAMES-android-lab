# Research Note

## Repository Snapshot

- Repository: `AlmasB/FXGL`
- Source URL: [https://github.com/AlmasB/FXGL](https://github.com/AlmasB/FXGL)
- Owner: `AlmasB`
- Batch ID: [`BATCH-2026-05-10-B`](../batches/BATCH-2026-05-10-B.md)
- Type: `engine-framework`
- License: `MIT`
- Selection date: `2026-05-10`
- Last pushed at selection: `2026-04-10`
- Stars at selection: `4802`
- Investigated commit: `f418525e0079c4dd2ae0baaed63a03beadc9e2e8`
- Research status: `reference-only`
- Build mode: `static-review-only`
- Catalog card: [catalog/projects/almasb-fxgl.md](../../catalog/projects/almasb-fxgl.md)

## Why This Repository Was Selected

- It is one of the strongest ecosystem signals in Kotlin-adjacent game development and is useful as a mature comparison point.
- Even though it is not Android-first, the repository contains reusable engine-service, input, persistence, and physics ideas.
- The repo is broad enough to benchmark what a more mature game framework chooses to centralize as reusable services.

## Technical Profile

- Main language(s): Kotlin, Java
- Engine / framework: FXGL
- Rendering stack: JavaFX runtime with engine modules for entities, input, physics, IO, networking, and samples
- Android target: claimed in the README, but no Android-specific runtime layer was closely verified in this pass
- Build system: Maven multi-module project
- Repository layout summary: modular framework split into `fxgl-core`, `fxgl-io`, `fxgl-intelligence`, `fxgl-controllerinput`, and sample applications
- Key modules reviewed:
  - `fxgl-core`
  - `fxgl-io`
  - `fxgl-controllerinput`
  - `fxgl-samples`

## Build And Runtime Notes

- The repository was investigated through static code review only.
- Module `pom.xml` files were inspected to confirm the Maven multi-module layout, but no build was attempted in this batch.
- Known setup limitations:
  - the repo mixes Kotlin and Java heavily
  - the directly reviewed runtime path is JavaFX-first rather than Android-first

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `1`
- Implementation depth: `3`
- Code clarity: `2`
- Novelty: `2`
- Overall verdict: `reference-only`
- Why:
  - there are many useful engine patterns here, but the runtime assumptions are much less aligned with Android than the other selected repositories
  - the repo remains valuable as a comparison and idea source rather than as a primary Android-targeted model

## Interesting Findings

### Engine Architecture And Core Loop

- `fxgl-core/src/main/kotlin/com/almasb/fxgl/core/EngineService.kt` defines a service lifecycle that splits initialization, vars setup, game-ready callbacks, main-loop start, per-frame update, pause/resume, reset, and exit. This is a strong example of a service-oriented engine core.

### Rendering And Graphics

- The most directly reusable rendering-adjacent pattern from this pass is not the JavaFX rendering itself, but the way the framework treats entities, services, and input as first-class subsystems around the rendering shell.

### Gameplay Systems

- `fxgl-core/src/main/java/com/almasb/fxgl/entity/Entity.java` guarantees a base set of transform, bbox, type, and view components while still allowing arbitrary component composition. It also supports reusable pooled entities and explicit update disabling for performance.

### Input And Controls

- `fxgl-core/src/main/kotlin/com/almasb/fxgl/input/Input.kt` centralizes action bindings, trigger listeners, key-sequence capture, event filters/handlers, and device-state tracking in one input service instead of scattering input logic through scenes.
- `fxgl-core/src/main/kotlin/com/almasb/fxgl/input/virtual/VirtualInput.kt` provides virtual d-pads, controllers, joysticks, and menu keys that translate pointer interaction into gameplay input. The shape is desktop/JavaFX-oriented, but the idea maps well to Android touch overlays.
- `fxgl-core/src/main/kotlin/com/almasb/fxgl/input/InputCapture.kt` records and replays trigger timelines, which is an unusually useful pattern for deterministic input testing, tutorials, or ghost playback systems.

### UI, HUD, And Menus

- UI work in this pass was viewed mainly through input and service layers rather than through a dedicated Android-like HUD stack.

### Physics And Collision

- `fxgl-core/src/main/java/com/almasb/fxgl/physics/PhysicsWorld.java` wraps Box2D-like world stepping, delayed add/remove of bodies while the world is locked, collision handler registration, sensor handling, and pixel/meter conversion in one engine-owned subsystem.

### Tooling, Android Integration, Or Other Notable Areas

- `fxgl-io/src/main/kotlin/com/almasb/fxgl/profile/SaveLoadService.kt` uses pluggable save/load handlers and bundle-based serialization instead of hardwiring game-state persistence into specific scenes.
- `fxgl-io/src/main/kotlin/com/almasb/fxgl/net/NetService.kt` exposes typed TCP and UDP server/client factories plus download tasks, showing how the framework treats networking as a reusable engine service rather than game-specific glue.
- `fxgl-core/pom.xml`, `fxgl-io/pom.xml`, and `fxgl-samples/pom.xml` confirm a modular Maven layout that keeps core runtime, IO, and samples separate.

## Reusable Takeaways

- A service lifecycle with clear phases is valuable for medium-to-large games even outside a full engine context.
- Input capture and replay are worth remembering as a testing and tutorial technique.
- Virtual touch controls should be treated as input translation layers, not as ad hoc UI buttons.
- Save/load and networking become easier to reuse when they are pluggable services with typed boundaries.

## Evidence Summary

- `fxgl-core/src/main/kotlin/com/almasb/fxgl/core/EngineService.kt` - engine-service lifecycle
- `fxgl-core/src/main/java/com/almasb/fxgl/entity/Entity.java` - component-based entity model and reusability hooks
- `fxgl-core/src/main/kotlin/com/almasb/fxgl/input/Input.kt` - centralized input service
- `fxgl-core/src/main/kotlin/com/almasb/fxgl/input/virtual/VirtualInput.kt` - virtual controller and joystick abstractions
- `fxgl-core/src/main/kotlin/com/almasb/fxgl/input/InputCapture.kt` - input capture and replay
- `fxgl-core/src/main/java/com/almasb/fxgl/physics/PhysicsWorld.java` - physics world and collision pipeline
- `fxgl-io/src/main/kotlin/com/almasb/fxgl/profile/SaveLoadService.kt` - pluggable save/load service
- `fxgl-io/src/main/kotlin/com/almasb/fxgl/net/NetService.kt` - reusable network service
- `fxgl-core/pom.xml` - core module structure and dependencies
- `fxgl-io/pom.xml` - IO module structure and dependencies
- `fxgl-samples/pom.xml` - sample-app dependency surface

## Risks Or Limits

- The strongest reviewed path is JavaFX-first, so direct Android transfer is weaker than for the other batch repositories.
- Mixed Java/Kotlin implementation increases adaptation cost if the lab wants Kotlin-only references.
- No build or runtime validation was attempted in this batch.

## Catalog Decision

- Keep in main catalog: `no`
- Primary category: `reference-only`
- Focus tags: `2d`, `input`, `physics`, `ui-hud`, `networking`
- Follow-up needed:
  - only if the lab wants a deeper study of service-oriented engine architecture or JavaFX-to-mobile comparison points
