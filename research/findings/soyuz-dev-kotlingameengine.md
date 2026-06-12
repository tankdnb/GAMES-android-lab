# Findings: `soyuz-dev/KotlinGameEngine`

## Snapshot

- Repository: `https://github.com/soyuz-dev/KotlinGameEngine`
- Investigated commit: `d3b54990abf7a5fceb64b96ccee770ef579163a0`
- License: `LGPL-3.0`
- Repository type: `engine-framework`
- Primary language: `Kotlin`
- Build mode: `static-review + gradle-version + gradle-help-failed-java8-needs-java17`
- Research date: `2026-06-12`

## What It Is

`KotlinGameEngine` is a compact Kotlin/LWJGL 2D engine prototype centered on a fixed-step runtime, object-owned entity model, SAT-based collider math, and a physics-first demo loop. The inspected tree is desktop-only and still early, but it already contains more engine substance than a typical one-file OpenGL experiment: runtime scene/entity ownership, shader/mesh rendering, event dispatch, continuous collision detection for circles, impulse resolution, joints, dynamic force fields, and targeted unit tests around geometry and physics.

## Why It Matters

This repository is useful to the lab as a small engine reference for teams that want direct ownership over loop, physics, and rendering seams instead of adopting a larger framework:

- the runtime loop is cleanly isolated in `RuntimeEngine` with accumulator-based fixed updates and render interpolation
- the engine intentionally rejects ECS ceremony and shows a lighter callback-driven entity model
- collision and physics are implemented in readable Kotlin without hiding behind native middleware
- the repo preserves a real test surface for collider, shape-query, joint, and rigid-body behavior

It is not a direct Android project, but it is a strong compact reference for custom runtime architecture that could inform Android-adjacent Kotlin engine work.

## Verified Technical Profile

- Primary category: `engine-framework`
- Focus tags: `2d`, `opengl`, `physics`, `collision`, `input`, `testing`
- Engine / framework: custom Kotlin JVM engine over LWJGL/GLFW/OpenGL
- Rendering approach: shader-based OpenGL 3.3 pipeline with explicit `Mesh`, `Shader`, `Camera`, and `Painter` abstractions
- Android target: none checked in
- Other targets seen in repo: desktop JVM only
- Build system: Gradle Kotlin DSL

## High-Value Reusable Ideas

### 1. The loop is fixed-step and intentionally decoupled from the demo shell

`engine/core/RuntimeEngine.kt` is one of the cleanest parts of the repo:

- `loadScene`, `start`, and `stop` keep scene initialization and cleanup explicit
- `tick(dt)` clamps bad frame deltas, accumulates fixed updates, and exposes `alpha` for interpolation-aware rendering
- scene lifecycle is guarded so init/cleanup only run when the current scene is actually active

This is a reusable small-engine pattern for Kotlin game runtimes that want deterministic simulation without tying loop ownership directly to window code.

### 2. The entity model stays lightweight without collapsing into global state

`RuntimeScene` plus `DefaultGameEntity` show a readable alternative to ECS:

- entities are stored in a linked map keyed by string id
- each entity directly owns `Transform`, `Shape2D`, and `Painter`
- behavior is attached with update and collision callbacks instead of external systems for everything
- the scene is still the authoritative owner for add/remove/find/all-entities queries

This is useful when a project needs more structure than a demo, but not the complexity cost of a full ECS.

### 3. Collision code is readable enough to study and adapt

`RuntimeCollisionSystem.kt`, `RectangleCollider.kt`, and the collider tests preserve several reusable patterns:

- SAT for rectangle-vs-rectangle overlap
- closest-point math for rectangle-vs-circle
- explicit contact generation with normal, depth, and point
- normal correction so resolution logic consistently treats contacts as A-to-B

The code is still narrow in supported shape pairs, but it is transparent enough to reuse for custom 2D collision work.

### 4. Physics is structured as a multi-phase pipeline instead of one opaque update

`RuntimePhysicsSystem.kt` makes the step order explicit:

- force accumulation on bodies
- optional permissive-joint force accumulation
- prospective position integration
- predictive circle CCD against rectangle AABBs
- discrete penetration pass with impulses and positional correction
- strict-joint solve iterations
- final velocity integration
- dynamic-force-field position refresh

That staged design is a useful reference even if the current implementation remains early and circle-centric.

### 5. The repo keeps practical physics experimentation close to the engine core

The combination of `PointMass`, `RigidBody`, `GravityField`, `RodJoint`, `RopeJoint`, `SpringJoint`, and the n-body demo in `Main.kt` shows a good prototype habit:

- core math is kept in reusable engine packages
- the demo exercises the same runtime pieces instead of bypassing them
- unusual ideas like exponent-based gravity-force culling are checked into normal source, not hidden in a branch or note

For lab purposes, this makes the repo a useful compact reference for experimenting with custom physics-first toy engines.

## Other Useful Implementations

- `RuntimeEventBus` provides a tiny type-keyed pub/sub seam for collision and runtime events.
- `Input` wraps keyboard and mouse listeners behind one singleton API, which is simple but practical for a desktop prototype.
- `Painter` plus `SolidColor` keep visual ownership on the entity side while still separating shader binding from physics/state.
- `IDEAS.md` is useful context because it exposes intended future directions: DSL authoring, broadphase hashing, debug overlays, and headless/threaded variants.

## Testing Surface

The repo has a real, if still modest, unit-test surface.

Verified examples:

- `engine/physics/RigidBodyTest.kt`
- `engine/physics/PointMassTest.kt`
- `engine/physics/joints/SpringJointTest.kt`
- `engine/collision/RectangleColliderTest.kt`
- `engine/collision/CircleColliderTest.kt`
- `engine/shape/ShapeQueriesTest.kt`

Visible checked-in test count is about `9` Kotlin test files across collision, shape, and physics.

## Android Relevance

### Direct relevance

Low.

No Android module, Android source set, or mobile host shell was visible in the inspected revision. The current runtime is explicitly LWJGL/GLFW desktop-first.

### Indirect relevance

Moderate and worth keeping.

Reasons:

- Kotlin-first engine code
- compact, readable runtime and physics ownership
- reusable fixed-step, collider, and callback-entity patterns
- useful contrast against heavier ECS or multiplatform engines already in the lab

## Build And Environment Notes

Verified locally:

- `gradlew.bat --version` succeeded and reported Gradle `9.2.1`
- `gradlew.bat help --no-daemon` failed because Gradle requires Java `17+`, while the lab machine currently exposes Java `8`
- the project itself declares `kotlin.jvmToolchain(21)` and uses the Foojay toolchain resolver plugin

Interpretation:

- the wrapper and build surface are real
- the visible failure is a lab-environment floor issue, not immediate evidence of a broken repository

## Risks And Limits

- desktop-only in the inspected revision
- current rendering/demo shell lives mostly in `Main.kt`, so host/runtime separation is not fully productized yet
- collision and CCD support are still partial; README explicitly lists broadphase and rectangle CCD as in-progress
- `README.md` text encoding is visibly rough in the inspected checkout, which lowers polish and may hint at documentation hygiene gaps
- LGPL-3.0 is acceptable for research, but downstream reuse constraints should be considered more carefully than MIT or Apache-2.0 references

## Catalog Verdict

`accepted`

The repository is worth keeping because it preserves a compact but real Kotlin engine reference: fixed-step loop ownership, callback-driven entities, SAT and closest-point collision math, staged physics resolution, joints, force fields, and a meaningful test surface. It is not Android-ready, but it is a good small-engine comparison point for future custom runtime work.
