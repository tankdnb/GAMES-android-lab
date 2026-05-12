# Research Note

## Repository Snapshot

- Repository: `sgalluz/k2d`
- Source URL: [https://github.com/sgalluz/k2d](https://github.com/sgalluz/k2d)
- Owner: `sgalluz`
- Batch ID: [`BATCH-2026-05-13-A`](../batches/BATCH-2026-05-13-A.md)
- Type: `engine-framework`
- License: `Apache-2.0`
- Selection date: `2026-05-13`
- Last pushed at selection: `2026-05-08`
- Stars at selection: `0`
- Investigated commit: `da72e4948a6d952995c74850f20379c5992d2efd`
- Research status: `accepted`
- Build mode: `static-review + gradle-help-failed-java8-needs-java17`
- Catalog card: [catalog/projects/sgalluz-k2d.md](../../catalog/projects/sgalluz-k2d.md)

## Why This Repository Was Selected

- From the current carry-over backlog, `k2d` offered the best balance of fresh activity, explicit permissive licensing, and expected architecture yield.
- The repository is interesting because it tries to keep Compose in the runtime layer instead of letting UI code swallow the whole engine design.
- It still has zero stars and remains desktop-first, but the engine/sample split and the stronger-than-expected test and publication surface made it worth a focused pass before the weaker licensed backlog alternatives.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: custom `K2D` micro-engine
- Rendering stack: Compose Multiplatform / Compose Desktop `Canvas` plus ECS-owned render systems
- Android target: indirect today; the architecture explicitly aims at future Android/Web/iOS support, but the checked-in sample is desktop-only
- Build system: Gradle Kotlin DSL multi-module JVM workspace
- Repository layout summary: root build plus `engine` library module, `sample` desktop application module, Gradle version catalog, and a surprisingly serious CI/publish surface for a pre-alpha engine
- Source footprint:
  - total files reviewed in repository: `85`
  - Kotlin/Java files reviewed across the repository: `49`
- Test surface:
  - test files found: `19`
  - meaningful engine/runtime/rendering tests found: `19`
- Key modules reviewed:
  - `README.md`
  - `build.gradle.kts`
  - `settings.gradle.kts`
  - `engine/build.gradle.kts`
  - `sample/build.gradle.kts`
  - `gradle/libs.versions.toml`
  - `.java-version`
  - `.github/workflows/main-checks.yml`
  - `.github/workflows/gradle-checks.yml`
  - `engine/src/main/kotlin/dev/sgalluz/k2d/core/GameLoop.kt`
  - `engine/src/main/kotlin/dev/sgalluz/k2d/core/TimeTicker.kt`
  - `engine/src/main/kotlin/dev/sgalluz/k2d/ecs/Entity.kt`
  - `engine/src/main/kotlin/dev/sgalluz/k2d/ecs/Components.kt`
  - `engine/src/main/kotlin/dev/sgalluz/k2d/ecs/World.kt`
  - `engine/src/main/kotlin/dev/sgalluz/k2d/ecs/systems/MovementSystem.kt`
  - `engine/src/main/kotlin/dev/sgalluz/k2d/ecs/systems/FrictionSystem.kt`
  - `engine/src/main/kotlin/dev/sgalluz/k2d/ecs/systems/BoundarySystem.kt`
  - `engine/src/main/kotlin/dev/sgalluz/k2d/ecs/systems/CollisionSystem.kt`
  - `engine/src/main/kotlin/dev/sgalluz/k2d/ecs/systems/collision/CollisionResponseDispatcher.kt`
  - `engine/src/main/kotlin/dev/sgalluz/k2d/input/InputConfig.kt`
  - `engine/src/main/kotlin/dev/sgalluz/k2d/input/systems/InputSystem.kt`
  - `engine/src/main/kotlin/dev/sgalluz/k2d/input/systems/MouseSystem.kt`
  - `engine/src/main/kotlin/dev/sgalluz/k2d/rendering/GameCanvas.kt`
  - `engine/src/main/kotlin/dev/sgalluz/k2d/rendering/systems/ShapeRenderSystem.kt`
  - `engine/src/main/kotlin/dev/sgalluz/k2d/runtime/GameLoopProvider.kt`
  - `engine/src/main/kotlin/dev/sgalluz/k2d/runtime/compose/ComposeGameLoop.kt`
  - `sample/src/main/kotlin/Main.kt`
  - `engine/src/test/kotlin/dev/sgalluz/k2d/core/GameLoopTest.kt`
  - `engine/src/test/kotlin/dev/sgalluz/k2d/ecs/systems/CollisionSystemTest.kt`
  - `engine/src/test/kotlin/dev/sgalluz/k2d/rendering/GameCanvasTest.kt`
  - `engine/src/test/kotlin/dev/sgalluz/k2d/runtime/ComposeGameLoopSmokeTest.kt`
  - `engine/src/test/kotlin/dev/sgalluz/k2d/runtime/GameLoopProviderTest.kt`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeds and reports Gradle `9.5.0` on a Java `8` launcher.
- `cmd /c gradlew.bat help --no-daemon` fails immediately because the build requires a newer JVM than the current lab machine exposes:
  - `Gradle requires JVM 17 or later to run. Your build is currently configured to use JVM 8.`
- The checked-in metadata shows that the JVM floor is expected, not accidental:
  - `.java-version` pins `21.0.7`
  - `gradle/libs.versions.toml` pins Kotlin `2.3.21` and Compose `1.10.3`
  - `engine/build.gradle.kts` enables `jacoco`, `dokka`, `maven-publish`, and `signing`
  - JaCoCo coverage verification is configured with `0.80` line and `0.70` branch thresholds
  - `.github/workflows/main-checks.yml` and `.github/workflows/gradle-checks.yml` wire assemble, ktlint, tests, coverage, and Sonatype snapshot publish
- No runtime launch was attempted.

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `2`
- Implementation depth: `3`
- Code clarity: `3`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - `k2d` is small, but it demonstrates a clean separation between pure engine timing logic and the Compose runtime adapter layer.
  - Its ECS, input, collision, and rendering seams are straightforward enough to reuse or rewrite inside Android-focused experiments.
  - The repository is pre-alpha and not yet Android-native, but the architecture is intentional enough that it earns a place as a lightweight reference rather than staying only in backlog.

## Interesting Findings

### Engine Architecture And Core Loop

- `engine/src/main/kotlin/dev/sgalluz/k2d/core/TimeTicker.kt` keeps delta-time calculation as a pure logic class with no Compose or coroutine dependency. That makes the frame clock portable even if the rendering/runtime layer changes later.
- `engine/src/main/kotlin/dev/sgalluz/k2d/core/GameLoop.kt` is intentionally tiny: it converts frame nanos into a delta and only then delegates to `onUpdate`. The runtime host is not allowed to own game-step math directly.
- `engine/src/main/kotlin/dev/sgalluz/k2d/runtime/compose/ComposeGameLoop.kt` and `engine/src/main/kotlin/dev/sgalluz/k2d/runtime/GameLoopProvider.kt` show the key architecture choice: Compose only provides frames through `withFrameNanos`, while the engine surface exposes a `GameLoopClock` through a `CompositionLocal`.
- `engine/src/main/kotlin/dev/sgalluz/k2d/ecs/World.kt` and `engine/src/main/kotlin/dev/sgalluz/k2d/ecs/Entity.kt` show a deliberately flat ECS shape: entities are just class-keyed component maps, systems run over one shared list, and `DeletionMark` cleanup happens after each update instead of through a more elaborate archetype system.
- `sample/src/main/kotlin/Main.kt` keeps `InputSystem`, `MouseSystem`, and `ShapeRenderSystem` outside `World`. That is a useful design hint: not every subsystem must be forced into the same ECS scheduler if a thinner boundary stays clearer.

### Rendering And Graphics

- `engine/src/main/kotlin/dev/sgalluz/k2d/rendering/GameCanvas.kt` is a minimal Compose render adapter. It reads `LocalGameLoopClock.current.frameTick.value` only to trigger redraws, then delegates actual drawing to `onRender`. This keeps Compose responsible for invalidation, not for engine state.
- `engine/src/main/kotlin/dev/sgalluz/k2d/rendering/systems/ShapeRenderSystem.kt` shows a simple but reusable ECS-to-Compose bridge: `Position` and `Sprite` become `drawRect` calls, while collision state can tint colliders red without needing a separate debug overlay system.
- `sample/src/main/kotlin/Main.kt` demonstrates how a normal Compose `Window` can host the engine surface while surrounding input capture and other UI remain normal Compose code instead of engine-owned shell code.

### Gameplay Systems

- `engine/src/main/kotlin/dev/sgalluz/k2d/ecs/systems/MovementSystem.kt` and `FrictionSystem.kt` keep simulation basics explicit and readable: direct position integration plus drag-based velocity decay without hidden scheduler behavior.
- `sample/src/main/kotlin/Main.kt` assembles a compact demo world with player, crosshair, NPC, static obstacle, pushable box, and mines. That sample is narrow, but it exercises most of the checked-in subsystems in one scene instead of hiding them in isolated toy tests.
- The gameplay value of `k2d` is less about finished game rules and more about how a tiny engine can keep world, runtime, and sample composition separate without over-abstracting.

### Input And Controls

- `engine/src/main/kotlin/dev/sgalluz/k2d/input/InputConfig.kt` maps abstract actions like `UP`, `DOWN`, `LEFT`, and `RIGHT` to Compose keys. This is a small but important seam for future multi-platform input adapters.
- `engine/src/main/kotlin/dev/sgalluz/k2d/input/systems/InputSystem.kt` only mutates entities that carry both `Velocity` and `PlayerInput`, which keeps control intent data-driven instead of binding one hardcoded player object into the runtime shell.
- `engine/src/main/kotlin/dev/sgalluz/k2d/input/systems/MouseSystem.kt` pushes raw mouse state into ECS `Position` for `MouseFollower` entities. It is simple, but it shows how platform events can be projected into world state rather than consumed directly by render code.
- `sample/src/main/kotlin/Main.kt` captures keyboard state and pointer state outside the engine core, then passes only the distilled state into systems. That is a useful boundary for Android-hosted Compose experiments as well.

### UI, HUD, And Menus

- `k2d` currently exposes almost no dedicated HUD or menu layer. The meaningful point is architectural: because the runtime surface is ordinary Compose, overlays and surrounding UI can stay ordinary Compose too instead of requiring engine-specific HUD primitives.

### Physics And Collision

- `engine/src/main/kotlin/dev/sgalluz/k2d/ecs/systems/CollisionSystem.kt` uses a naive pairwise `O(n^2)` AABB overlap scan over entities carrying `Position` plus `BoxCollider`. That is not scalable, but it is easy to reason about and well-suited to the repository's prototype scope.
- `engine/src/main/kotlin/dev/sgalluz/k2d/ecs/systems/collision/CollisionResponseDispatcher.kt` routes collisions by high-level response intent: `EXPLODE`, `STATIC`, `BOUNCE`, and `PUSH`. This is a clean pattern for keeping response policies separate from overlap detection.
- `engine/src/main/kotlin/dev/sgalluz/k2d/ecs/systems/BoundarySystem.kt` clamps entities against world bounds and conditionally flips velocity when a moving body crosses an edge. It is a useful small reference for keeping edge-bounce behavior deterministic and centralized.
- `engine/src/test/kotlin/dev/sgalluz/k2d/ecs/systems/CollisionSystemTest.kt` covers more cases than the code size suggests: overlap detection, no-collision directions, static resolution, bounce, push, explode, corner cases, and state-reset behavior. The tests make this subsystem more reusable than many tiny hobby-engine collision sketches.

### Tooling, Android Integration, Or Other Notable Areas

- `engine/build.gradle.kts` is stronger than expected for a zero-star pre-alpha engine: source jars, Dokka Javadoc jars, Maven publication metadata, PGP signing, and coverage gates are already wired.
- `.github/workflows/main-checks.yml` treats the engine like a real library surface rather than just a sample app. Assemble, lint, test, coverage, and snapshot publication all exist before any visible Android backend lands.
- `README.md` explicitly describes Compose as a runtime adapter rather than engine logic, which matches the reviewed code. However, the same README still references a `docs/` directory that is not present in the inspected tree, so some documentation claims are ahead of the current repository contents.

## Reusable Takeaways

- A Compose-based game experiment stays easier to port when frame timing remains a pure logic layer and Compose only acts as the frame source plus redraw host.
- Even a minimal ECS can stay useful if input, rendering, and collision seams are explicit and test-covered instead of being hidden inside one monolithic game class.
- A tiny engine benefits from publication and verification discipline early. The `k2d` build surface is a reminder that good CI, coverage, and publishing metadata are not only for mature frameworks.
- When Android support is still future work, it is still worth checking whether the runtime boundary is clean enough that an Android host could be added later without rewriting the engine core.

## Evidence Summary

- `core/GameLoop.kt`, `core/TimeTicker.kt` - pure timing core separated from the Compose host
- `runtime/compose/ComposeGameLoop.kt`, `runtime/GameLoopProvider.kt` - Compose frame sourcing and `CompositionLocal` loop injection
- `ecs/Entity.kt`, `ecs/Components.kt`, `ecs/World.kt` - flat ECS model and deferred deletion cleanup
- `input/InputConfig.kt`, `input/systems/InputSystem.kt`, `input/systems/MouseSystem.kt` - abstract action mapping and platform-state-to-ECS projection
- `ecs/systems/CollisionSystem.kt`, `ecs/systems/collision/CollisionResponseDispatcher.kt`, `ecs/systems/BoundarySystem.kt` - overlap detection plus response dispatch
- `rendering/GameCanvas.kt`, `rendering/systems/ShapeRenderSystem.kt` - Compose `Canvas` adapter and ECS-driven debug-friendly rectangle rendering
- `sample/src/main/kotlin/Main.kt` - one compact scene that shows how the engine is meant to be hosted
- `engine/build.gradle.kts`, `.github/workflows/main-checks.yml`, `.java-version` - modern JVM floor, coverage gates, testing, and publication discipline

## Risks Or Limits

- The repository is still `pre-alpha`, small in scope, and has `0` stars, so it should be treated as a promising low-signal reference rather than as validated community practice.
- There is no real Android module or Android runtime target in the inspected revision yet; Android value is architectural and future-facing rather than directly production-ready.
- The collision approach is intentionally naive and will not scale without a broad-phase or spatial partitioning layer.
- The sample remains desktop-first and shape-primitive-first, so the lab should not treat it as evidence for asset pipelines, audio, or large-game production flow.
- README and repository contents are slightly out of sync because the readme references a `docs/` directory that is not present in the inspected tree.
- Local build validation in the lab is blocked by the machine's Java `8` runtime. That limitation appears environmental, but full Gradle task execution was not completed here.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `engine-framework`
- Focus tags: `2d`, `multiplatform`, `ecs`, `input`, `collision`, `testing`
- Follow-up needed:
  - rerun Gradle discovery and selected tests in a Java `17+` or `21` environment
  - if the lab revisits this repository later, isolate the runtime-adapter boundary, the flat ECS shape, or the collision-response tests instead of reopening the whole codebase broadly
