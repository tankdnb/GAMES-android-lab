# Research Note

## Repository Snapshot

- Repository: `vgupta98/compose-game`
- Source URL: [https://github.com/vgupta98/compose-game](https://github.com/vgupta98/compose-game)
- Owner: `vgupta98`
- Batch ID: [`BATCH-2026-05-11-A`](../batches/BATCH-2026-05-11-A.md)
- Type: `engine-framework`
- License: `Apache-2.0`
- Selection date: `2026-05-11`
- Last pushed at selection: `2024-07-26`
- Stars at selection: `43`
- Investigated commit: `bb548e2eb911337c11da53094c3ce6e2ccad45c4`
- Research status: `accepted`
- Build mode: `static-review + gradle-help-failed-no-jdk`
- Catalog card: [catalog/projects/vgupta98-compose-game.md](../../catalog/projects/vgupta98-compose-game.md)

## Why This Repository Was Selected

- It was the strongest currently unresearched Compose-native Android engine/library candidate left after filtering the latest low-signal Android-game results.
- Compared with `minigdx/minigdx`, `zeganstyl/thelema-engine`, and `JohnLavender474/Megaman-Maverick`, it offered the best balance of direct Android relevance, permissive licensing, manageable scope, and likely reusable runtime patterns.
- It is useful because it packages a tiny engine as a reusable library module plus a sample app, which fills a different niche from the lab's bigger engine references and from app-level Compose games like `Neon`.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: Android SDK + Jetpack Compose + coroutine-driven micro-engine library
- Rendering stack: Compose `Canvas`, `VectorPainter`, and draw-scope helpers for circles and line boundaries
- Android target: direct Android library module plus sample Android app
- Build system: multi-module Gradle Groovy DSL project with version catalog
- Repository layout summary: reusable runtime in `compose-game/`, demonstration app in `app/`, wrapper/build metadata at root, and a Jitpack publication file for library distribution
- Source footprint:
  - total files reviewed in repository: `57`
  - Kotlin/Java files reviewed across the repository: `18`
- Test surface:
  - unit-test files found: `1`
  - instrumentation-test files found: `0`
- Key modules reviewed:
  - `README.md`
  - `LICENSE`
  - `jitpack.yml`
  - `build.gradle`
  - `settings.gradle`
  - `gradle.properties`
  - `gradle/libs.versions.toml`
  - `compose-game/build.gradle`
  - `app/build.gradle`
  - `app/src/main/AndroidManifest.xml`
  - `compose-game/src/main/kotlin/io/github/vgupta98/compose_game/domain/GameEngine.kt`
  - `compose-game/src/main/kotlin/io/github/vgupta98/compose_game/domain/GameEngineImpl.kt`
  - `compose-game/src/main/kotlin/io/github/vgupta98/compose_game/domain/GameFactory.kt`
  - `compose-game/src/main/kotlin/io/github/vgupta98/compose_game/domain/GameListener.kt`
  - `compose-game/src/main/kotlin/io/github/vgupta98/compose_game/domain/InitialConditionsChecker.kt`
  - `compose-game/src/main/kotlin/io/github/vgupta98/compose_game/data/GameObject.kt`
  - `compose-game/src/main/kotlin/io/github/vgupta98/compose_game/data/GameObjectImpl.kt`
  - `compose-game/src/main/kotlin/io/github/vgupta98/compose_game/data/Vector.kt`
  - `compose-game/src/main/kotlin/io/github/vgupta98/compose_game/presentation/GameBoard.kt`
  - `compose-game/src/main/kotlin/io/github/vgupta98/compose_game/presentation/GameDrawScope.kt`
  - `compose-game/src/main/kotlin/io/github/vgupta98/compose_game/presentation/model/GameResource.kt`
  - `compose-game/src/main/kotlin/io/github/vgupta98/compose_game/presentation/model/GameResourceImpl.kt`
  - `app/src/main/java/io/github/vgupta98/compose_game/MainActivity.kt`
  - `app/src/main/java/io/github/vgupta98/compose_game/MainViewModel.kt`
  - `compose-game/src/test/java/io/github/vgupta98/compose_game/ExampleUnitTest.kt`

## Build And Runtime Notes

- The repository was investigated primarily through static code review plus lightweight Gradle discovery.
- `compose-game/build.gradle` confirms a reusable Android library module with `compileSdk 34`, `minSdk 24`, Compose enabled, Java `17` source/target, and a `maven-publish` publication named `compose-game`.
- `app/build.gradle` confirms a sample Android app built around the same Compose stack, also on Java `17`, consuming the library module directly through `implementation(project(":compose-game"))`.
- `jitpack.yml` explicitly requests `openjdk17`, which matches the module compile settings, but it also references `./scripts/prepareJitpackEnvironment.sh`, and that script is not present in the inspected repository snapshot.
- `cmd /c gradlew.bat help --no-daemon` and `cmd /c gradlew.bat :compose-game:test --dry-run --no-daemon` both fail in the current lab environment because Gradle cannot find a Java compiler and this machine still exposes only a runtime without a full JDK.
- No runtime launch was attempted.
- Known setup limitations:
  - local build validation in this lab is blocked by the missing JDK/compiler
  - the repository test surface is effectively placeholder-only, so even a successful future build would still need manual judgment rather than leaning on meaningful automated coverage
  - Jitpack publication metadata may currently be incomplete because the referenced prepare script is absent from the inspected tree

## Usefulness Assessment

- Reuse potential: `2`
- Android transfer: `3`
- Implementation depth: `2`
- Code clarity: `2`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - this repository is a direct Android/Compose engine reference rather than another game sample, and it demonstrates a compact but reusable library seam for loop control, rendering, and collisions
  - it is small and limited, but that narrowness also makes the core design easy to study and cite later
  - it should be treated as a micro-engine pattern source for simple physics toys or small Compose games, not as a broad engine baseline

## Interesting Findings

### Engine Architecture And Core Loop

- `compose-game/src/main/kotlin/io/github/vgupta98/compose_game/domain/GameEngine.kt` defines a minimal public engine API with game-object lifecycle, loop control, and collision listener registration, keeping the library boundary intentionally small.
- `compose-game/src/main/kotlin/io/github/vgupta98/compose_game/domain/GameFactory.kt` exposes the runtime through one simple factory call, which keeps engine construction explicit without forcing dependency injection into small samples.
- `compose-game/src/main/kotlin/io/github/vgupta98/compose_game/domain/GameEngineImpl.kt` is the core of the repository. It stores immutable `GameObject` snapshots inside a Compose `mutableStateListOf`, advances time through `Animatable<Float>`, and uses an infinite `animateTo` loop over 10-second segments to keep simulation time moving.
- `GameEngineImpl.kt` uses `lastPausedTime` plus `gameLoopTime.value % LOOP_TIME_INTERVAL_IN_SECONDS` to resume from a paused point instead of restarting from zero. That is a compact pause/resume pattern for simple Compose-hosted simulations.
- The more interesting design choice is analytical motion rather than step-by-step mutation: `getPosition`, `getVelocity`, and `getRotation` derive state from `gameLoopTime - lastCollisionTime`, so the engine only needs to rewrite object state when a collision actually changes the trajectory.

### Rendering And Graphics

- `compose-game/src/main/kotlin/io/github/vgupta98/compose_game/presentation/GameBoard.kt` keeps rendering separate from simulation by consuming `GameResource` models keyed by engine object ID rather than by storing painters/colors inside the physics objects.
- `GameBoard.kt` also provides `onDrawBehind` and `onDrawAbove` hooks, which is a good micro-pattern for letting a host game add effects or overlays without forking the engine's draw loop.
- `compose-game/src/main/kotlin/io/github/vgupta98/compose_game/presentation/GameDrawScope.kt` wraps raw `DrawScope` with a tiny game-specific drawing API. Round objects are drawn by translating and rotating a `VectorPainter`, while boundaries are drawn as simple lines.
- `compose-game/src/main/kotlin/io/github/vgupta98/compose_game/presentation/model/GameResource.kt` and `GameResourceImpl.kt` formalize the separation between engine objects and visual assets, which is one of the cleaner reusable ideas in the repository.

### Gameplay Systems

- Gameplay itself is not the main value here. The sample app in `app/src/main/java/io/github/vgupta98/compose_game/MainViewModel.kt` mainly seeds five balls and four boundaries to demonstrate bouncing and rotation rather than to encode richer game rules.
- That said, the sample does show how a host app can keep content assembly outside the engine and treat the library as a small reusable runtime rather than as a full app architecture.

### Input And Controls

- There is no real engine-level input abstraction. `app/src/main/java/io/github/vgupta98/compose_game/MainActivity.kt` only exposes a simple play/pause button that starts or pauses the engine loop through a remembered coroutine scope.
- This is a limitation for reuse, but it also means the library is not overcommitted to one control model and can be embedded under a host app's own input layer.

### UI, HUD, And Menus

- `MainActivity.kt` shows the intended hosting model clearly: a normal Compose activity owns the coroutine scope, play/pause UI, and resource setup, while the engine provides only `GameBoard` plus the simulation state.
- That split is useful for Android projects that want to keep gameplay inside a reusable library while still using regular Compose screens and controls around it.

### Physics And Collision

- `compose-game/src/main/kotlin/io/github/vgupta98/compose_game/data/GameObjectImpl.kt` keeps the engine intentionally narrow: only `RoundObject` and `Boundary` are supported, with restitution, angular velocity, acceleration, and immutable state fields.
- `compose-game/src/main/kotlin/io/github/vgupta98/compose_game/domain/InitialConditionsChecker.kt` is stronger than it first appears. It validates restitution, mass, radius, collision-time ownership, and caps on momentum, velocity, and acceleration, which prevents obviously unstable host input from entering the simulation.
- `compose-game/src/main/kotlin/io/github/vgupta98/compose_game/data/Vector.kt` provides the small vector algebra set the engine needs: dot product, 2D cross-product magnitude, scaling, normalization, and scalar-vector multiplication.
- `GameEngineImpl.kt` handles circle-circle collisions with restitution-based parallel/perpendicular velocity decomposition and a very simple angular momentum response based on disk moment of inertia.
- `GameEngineImpl.kt` also supports circle-boundary collisions by projecting the ball onto the boundary segment, checking the normal-side approach condition, and reflecting the normal component with restitution.
- `updateGameObject` rewrites a copied `RoundObject` back into the state list only when a collision occurs. Combined with analytical motion, this keeps most frames read-only from the engine-state perspective, even though collision detection itself is still `O(n^2)`.

### Tooling, Android Integration, Or Other Notable Areas

- `compose-game/build.gradle` plus `jitpack.yml` show that the repository is intended as a publishable library, not just a local demo. The `maven-publish` block defines a release artifact with group `com.github.vgupta98.compose-game` and version `1.0.0`.
- `app/build.gradle`, `AndroidManifest.xml`, and `MainActivity.kt` show a direct Android sample app with `enableEdgeToEdge()` and no separate engine-owned activity shell.
- The biggest design weakness is in `GameBoard.kt`: it receives a public `GameEngine` but immediately casts it to `GameEngineImpl` to access `gameObjects` and helper methods. That leaks the implementation type through the rendering layer and weakens the intended abstraction boundary.
- The automated verification surface is effectively nonexistent. `compose-game/src/test/java/io/github/vgupta98/compose_game/ExampleUnitTest.kt` is only the default `2 + 2` placeholder and does not validate engine math, collisions, or rendering contracts.

## Reusable Takeaways

- A small Compose game engine can stay understandable if it separates simulation objects from render resources and lets the host app own the surrounding UI and coroutine scope.
- Analytical position/velocity derivation from collision timestamps is a viable pattern for simple physics toys or bounce-heavy prototypes where rewriting every object every frame is unnecessary.
- Resource-ID mapping plus `onDrawBehind` and `onDrawAbove` hooks is a clean way to keep a Compose-hosted renderer extensible without turning the engine into a full scene-graph framework.

## Evidence Summary

- `compose-game/src/main/kotlin/io/github/vgupta98/compose_game/domain/GameEngine.kt`, `GameFactory.kt`, and `GameEngineImpl.kt` - confirmed the public API, `Animatable`-driven loop, analytical kinematics, pause/resume model, and collision processing
- `compose-game/src/main/kotlin/io/github/vgupta98/compose_game/data/GameObjectImpl.kt`, `GameObject.kt`, and `Vector.kt` - confirmed the narrow object model and the vector math used by the engine
- `compose-game/src/main/kotlin/io/github/vgupta98/compose_game/domain/InitialConditionsChecker.kt` and `GameListener.kt` - confirmed runtime validation and the collision-listener seam
- `compose-game/src/main/kotlin/io/github/vgupta98/compose_game/presentation/GameBoard.kt`, `GameDrawScope.kt`, and `presentation/model/*` - confirmed the rendering strategy, draw hooks, and ID-mapped resource layer
- `app/src/main/java/io/github/vgupta98/compose_game/MainActivity.kt` and `MainViewModel.kt` - confirmed the intended Android hosting model and sample scene assembly
- `compose-game/build.gradle`, `app/build.gradle`, `jitpack.yml`, and `ExampleUnitTest.kt` - confirmed the Java `17` build floor, publication intent, placeholder-only tests, and the missing referenced Jitpack script

## Risks Or Limits

- The repository is a compact micro-engine, not a broad gameplay or engine architecture reference.
- Supported object types are extremely narrow: circles and line boundaries only.
- `GameBoard` depends on a cast from `GameEngine` to `GameEngineImpl`, so the abstraction boundary is weaker than the public API suggests.
- Collision checking is `O(n^2)` and the renderer linearly resolves resources by ID, so the current design should be treated as small-game only.
- Automated tests are effectively absent.
- Local build validation is blocked in this lab because the environment still lacks a full JDK/compiler.
- `jitpack.yml` references a prepare script that is missing from the inspected repository tree, so publication reproducibility is not fully trustworthy from metadata alone.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `engine-framework`
- Focus tags: `2d`, `android`, `collision`, `physics`, `ui-hud`
- Follow-up needed:
  - if the lab revisits this repository later, focus on one subsystem such as the analytical collision math or on removing the `GameEngineImpl` downcast from `GameBoard`
  - if a Java `17` JDK becomes available, verify the library/test/publication path and confirm whether the missing Jitpack prepare script is just stale metadata or a real packaging gap
