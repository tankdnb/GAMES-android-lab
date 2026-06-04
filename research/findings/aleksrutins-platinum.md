# Research Note

## Repository Snapshot

- Repository: `aleksrutins/platinum`
- Source URL: [https://github.com/aleksrutins/platinum](https://github.com/aleksrutins/platinum)
- Owner: `aleksrutins`
- Batch ID: [`BATCH-2026-06-04-AC`](../batches/BATCH-2026-06-04-AC.md)
- Type: `engine-framework`
- License: `MIT`
- Selection date: `2026-06-04`
- Last pushed at selection: `2026-05-31`
- Stars at selection: `5`
- Default branch at selection: `master`
- Investigated commit: `82f8d4b1983dfae0e49e193c6e114538c388000b`
- Research status: `reference-only`
- Build mode: `static-review + gradle-help-failed-java8-needs-java17`
- Catalog card: [catalog/projects/aleksrutins-platinum.md](../../catalog/projects/aleksrutins-platinum.md)

## Why This Repository Was Selected

- `platinum` led the carry-over exact-license shortlist because it still had the best current balance of freshness, explicit licensing, and at least some public signal among the remaining unresearched engine candidates.
- The repository also looked small enough to audit almost completely in one pass, which makes it useful for checking whether the lab should keep a compact ECS-plus-renderer prototype as a comparison baseline.
- Static review answers the main question conservatively: `platinum` is worth preserving as `reference-only`, but it is too incomplete and too desktop-specific to act as a primary Kotlin game-engine model for Android-facing work.

## Technical Profile

- Main language(s): Kotlin, Java
- Engine / framework: custom JVM 2D engine prototype with a tiny ECS-like runtime, Swing/AWT rendering, and a placeholder desktop editor
- Rendering stack: Swing `JComponent` + `Graphics2D` + `BufferedImage` sprites + transform-offset camera
- Android target: none in the checked-in tree; Android relevance is only indirect through a few transferable Kotlin runtime patterns
- Build system: Gradle multi-project build with `lib`, `example`, and `editor` modules, Kotlin `2.2.21`, Gradle `9.2.1`, and a declared JVM toolchain of `21`
- Repository layout summary:
  - `lib/` contains the engine core, ECS types, input helpers, 2D rendering, collision, and level-loading code
  - `example/` contains one desktop sample that wires keyboard input, rendering, a camera, and a small tilemap scene
  - `editor/` contains an early Swing editor shell
- Source footprint:
  - total files counted in repository: `37`
  - Kotlin/KTS/Java files counted in repository: `30`
- Test surface:
  - test files found: `1`
  - meaningful engine/gameplay tests found: `0`
- Key modules and files reviewed:
  - `settings.gradle.kts`
  - `gradle/wrapper/gradle-wrapper.properties`
  - `lib/build.gradle.kts`
  - `example/build.gradle.kts`
  - `editor/build.gradle.kts`
  - `lib/src/main/java/platinum/Game.kt`
  - `lib/src/main/java/platinum/Scene.kt`
  - `lib/src/main/java/platinum/ecs/Component.kt`
  - `lib/src/main/java/platinum/ecs/Entity.kt`
  - `lib/src/main/java/platinum/ecs/System.kt`
  - `lib/src/main/java/platinum/input/KeyboardManager.kt`
  - `lib/src/main/java/platinum/twod/RenderSystem2D.kt`
  - `lib/src/main/java/platinum/twod/Transform2D.kt`
  - `lib/src/main/java/platinum/twod/Sprite2D.kt`
  - `lib/src/main/java/platinum/twod/Camera2D.kt`
  - `lib/src/main/java/platinum/twod/CameraEntity2D.kt`
  - `lib/src/main/java/platinum/twod/PlatformerPhysics2D.kt`
  - `lib/src/main/java/platinum/twod/collision/CollisionBox2D.kt`
  - `lib/src/main/java/platinum/twod/level/LevelLoader.kt`
  - `lib/src/test/java/platinum/GameTest.kt`
  - `example/src/main/java/platinum/example/Main.kt`
  - `editor/src/main/java/platinum/editor/Editor.java`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- No root `README.md`, checked-in docs, or CI workflows were present, so the initial understanding came mostly from GitHub metadata, the module graph, and direct source inspection.
- `cmd /c gradlew.bat --version` succeeds in the lab and reports Gradle `9.2.1` running on Java `8`.
- `cmd /c gradlew.bat help --no-daemon` fails because the current lab machine still exposes only Java `8`:
  - `Gradle requires JVM 17 or later to run. Your build is currently configured to use JVM 8.`
- The checked-in build files request a newer toolchain than the current lab environment:
  - Kotlin plugin `2.2.21`
  - `jvmToolchain(21)` in `lib/build.gradle.kts` and `example/build.gradle.kts`
- No runtime launch was attempted.

## Usefulness Assessment

- Reuse potential: `1`
- Android transfer: `1`
- Implementation depth: `1`
- Code clarity: `2`
- Novelty: `1`
- Overall verdict: `reference-only`
- Why:
  - `platinum` is readable and compact enough to preserve as a tiny comparison sample for ECS wiring, input polling, tilemap entity loading, and rollback-based collision handling.
  - At the same time, the inspected revision is too incomplete to recommend as a primary reference: there is no Android target, no real docs, almost no tests, and a notable runtime gap where scene entities are not actually used by the main render/collision paths.

## Interesting Findings

### Engine Architecture And Core Loop

- `lib/src/main/java/platinum/Game.kt`, `ecs/System.kt`, `ecs/Entity.kt`, and `ecs/Component.kt` show a tiny ECS-like runtime where components declare one target system type via the generic superclass and then only initialize or update against matching systems. It is minimal, but it is a readable example of how little infrastructure is needed for a toy engine loop.
- `Game.mainLoop(...)` is deliberately simple: a `TimerTask` fires at the display refresh rate, calls a user callback, then runs `updateAll()` across registered systems. That gives the outer game shell direct control over whether the loop continues.
- `Scene.kt` plus `Game.getEntities()` suggest an intended split between base entities and scene-local entities, but the current runtime does not follow through. `RenderSystem2D`, `Camera2D`, and `CollisionBox2D` iterate only `game.baseEntities`, so `switchScene(...)` does not currently route scene entities through the normal update or render path.

### Rendering And Graphics

- `RenderSystem2D.kt` is a compact but useful pattern: rendering is just another system. The Swing `JComponent` clears its surface in `paint(...)`, then asks each base entity to `update(this)` inside the render pass.
- `Sprite2D.kt` keeps sprites extremely lightweight. A `BufferedImage` plus `Transform2D.actXi` and `actYi` is enough for draw calls, which makes the rendering flow easy to audit.
- `Camera2D.kt` uses a global offset model instead of a matrix or viewport object. It rewrites `xMod` and `yMod` on every base-entity transform, which is simple but also a good cautionary example because it turns the camera into a shared side effect across the whole entity list.

### Input And Controls

- `input/KeyboardManager.kt` is a very small AWT input shell: attach one `KeyListener`, store pressed key codes in a set, and expose `isDown(...)` for polling.
- `example/Main.kt` keeps control decisions in the outer game loop instead of burying them inside entity classes. That is a good small-scale pattern even though the concrete implementation is desktop-only.

### Physics And Collision

- `Transform2D.kt` stores a short history of positions and exposes `rollback()`, which becomes the core of the collision-resolution approach.
- `CollisionBox2D.kt` uses simple AABB overlap tests and resolves movable collisions by repeatedly rolling back the transform until overlap clears. This is crude, but it is a readable prototype technique for tiny grid or platformer experiments.
- `PlatformerPhysics2D.kt` keeps gravity and jumping intentionally small: falling just adds a constant Y delta when no collision is present, and jumping subtracts Y velocity from the same transform state.

### Tooling, Android Integration, Or Other Notable Areas

- `LevelLoader.kt` is one of the few content-facing seams in the repository. It slices subimages from a tilemap atlas by index, attaches `Transform2D`, `Sprite2D`, and `CollisionBox2D`, and uses a callback to inject custom gameplay entities. That is a good tiny pattern for array-authored 2D content.
- `editor/src/main/java/platinum/editor/Editor.java` confirms that the editor claim is still only a placeholder. The checked-in editor is currently just a `JFrame` with a `Hello World` button.

## Reusable Takeaways

- A tiny Kotlin ECS loop can stay readable when component-to-system compatibility is explicit and no extra reflection or registry layer is added beyond the minimum.
- Transform-history rollback is a viable prototype collision-resolution pattern for very small 2D experiments, even if it does not scale well.
- Tile-atlas slicing plus callback-driven entity injection is a compact way to bridge authored level data into runtime entities.
- The repository is also a useful caution: adding a `Scene` abstraction does not help unless the rest of the runtime actually uses it instead of hard-coding `baseEntities`.

## Evidence Summary

- `lib/src/main/java/platinum/Game.kt` - timer-driven main loop, system registration, entity storage, and scene switch seam
- `lib/src/main/java/platinum/ecs/Component.kt`, `Entity.kt`, `System.kt` - system-typed component updates and small ECS-like ownership model
- `lib/src/main/java/platinum/twod/RenderSystem2D.kt`, `Sprite2D.kt`, `Camera2D.kt` - Swing rendering path and global transform-offset camera
- `lib/src/main/java/platinum/input/KeyboardManager.kt` and `example/src/main/java/platinum/example/Main.kt` - raw key polling and outer-loop control ownership
- `lib/src/main/java/platinum/twod/Transform2D.kt`, `collision/CollisionBox2D.kt`, and `PlatformerPhysics2D.kt` - transform-history rollback, AABB overlap checks, and simple gravity/jump behavior
- `lib/src/main/java/platinum/twod/level/LevelLoader.kt` - tilemap slicing and callback-driven gameplay entity injection
- `editor/src/main/java/platinum/editor/Editor.java` - placeholder editor shell
- `lib/src/test/java/platinum/GameTest.kt` - only trivial entity-addition test

## Risks Or Limits

- There is no direct Android target in the checked-in tree, so Android relevance is only indirect.
- No root `README.md`, docs, or CI workflows were found.
- The scene system is not wired through the main runtime because the renderer, camera, and collisions all traverse only `baseEntities`.
- The editor claim is mostly aspirational in the inspected revision.
- The visible test surface is only one trivial test.
- The latest inspected commit (`82f8d4b`) adds the MIT license, which means the recent freshness signal is real but still partially superficial.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `reference-only`
- Focus tags: `2d`, `input`, `collision`
- Follow-up needed:
  - if the lab revisits this repository, keep it narrow: rerun Gradle discovery in a JDK `21` environment and isolate the small ECS loop, the scene-versus-`baseEntities` wiring gap, the rollback collision path, or the tilemap callback loader instead of treating the whole repository as an Android-ready engine baseline
