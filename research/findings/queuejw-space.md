# Research Note

## Repository Snapshot

- Repository: `queuejw/Space`
- Source URL: [https://github.com/queuejw/Space](https://github.com/queuejw/Space)
- Owner: `queuejw`
- Batch ID: [`BATCH-2026-06-04-F`](../batches/BATCH-2026-06-04-F.md)
- Type: `android-game`
- License: `Apache-2.0`
- Selection date: `2026-06-04`
- Last pushed at selection: `2025-09-05`
- Stars at selection: `7`
- Default branch at selection: `android-16`
- Investigated commit: `e4da4ca519c1be17b7f0dded4e92cab836067096`
- Research status: `accepted`
- Build mode: `static-review + gradle-help-failed-java8-needs-java17`
- Catalog card: [catalog/projects/queuejw-space.md](../../catalog/projects/queuejw-space.md)

## Why This Repository Was Selected

- `Space` was already the next verified candidate in the compact explicit-license shortlist and still had the strongest direct Android relevance among the remaining backlog entries.
- The repository is a standalone Kotlin Android game derived from the Android 14-16 Easter Egg code path, which makes it a promising reference for Android-native real-time rendering, input, and platform-shell patterns without external engines.
- The main question for this pass was whether the project offers reusable Android gameplay implementation ideas beyond being a thin repackage of upstream AOSP code. The answer is yes, although the scope remains narrow.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: custom Android-native Compose game shell with a small in-repo simulator/physics layer
- Rendering stack: Compose-driven drawing via custom `DrawModifierNode`, vector paths, `Canvas`-style primitives, and per-step draw invalidation
- Android target: direct and exclusive; the repository is a single Android application module
- Build system: Gradle Kotlin DSL Android app with Compose, WindowManager, and Material dependencies
- Repository layout summary: one `app` module with gameplay/runtime code under `app/src/main/java`, resources under `app/src/main/res`, and no extra engine/library split
- Source footprint:
  - total files counted in repository: `49`
  - Kotlin/Java/Gradle files counted in repository: `17`
- Test surface:
  - test files found: `0`
  - meaningful automated tests found: `0`
- Key modules reviewed:
  - `README.md`
  - `settings.gradle.kts`
  - `build.gradle.kts`
  - `gradle/libs.versions.toml`
  - `gradle/wrapper/gradle-wrapper.properties`
  - `app/build.gradle.kts`
  - `app/src/main/AndroidManifest.xml`
  - `app/src/main/java/ru/queuejw/space/game/MainActivity.kt`
  - `app/src/main/java/ru/queuejw/space/game/VisibleUniverse.kt`
  - `app/src/main/java/ru/queuejw/space/game/Universe.kt`
  - `app/src/main/java/ru/queuejw/space/game/Physics.kt`
  - `app/src/main/java/ru/queuejw/space/game/Autopilot.kt`
  - `app/src/main/java/ru/queuejw/space/game/DreamUniverse.kt`
  - `app/src/main/java/ru/queuejw/space/game/UniverseProgressNotifier.kt`
  - `app/src/main/java/ru/queuejw/space/game/ComposeTools.kt`
  - `app/src/main/java/ru/queuejw/space/game/PathTools.kt`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `README.md` explicitly says this is the author's version of the Android 16 Easter Egg and links back to the AOSP source tree; most runtime files also retain Android Open Source Project copyright headers.
- `cmd /c gradlew.bat --version` succeeds and reports Gradle `9.0.0` on the current lab machine.
- `cmd /c gradlew.bat help --no-daemon` fails because the current lab machine still exposes only Java `8`:
  - `Gradle requires JVM 17 or later to run. Your build is currently configured to use JVM 8.`
- The checked-in build surface itself is modern:
  - AGP `8.13.0`
  - Kotlin `2.2.10`
  - `compileSdk` / `targetSdk` `36`
  - Java source/target compatibility `21`
- No runtime launch was attempted.

## Usefulness Assessment

- Reuse potential: `2`
- Android transfer: `3`
- Implementation depth: `2`
- Code clarity: `3`
- Novelty: `1`
- Overall verdict: `accepted`
- Why:
  - `Space` is narrow in gameplay scope and clearly AOSP-derived, but it is also a concise and readable Android-native real-time game shell with several directly transferable ideas.
  - The strongest value is not genre depth; it is the way the project combines Compose rendering, a tiny simulation loop, custom touch controls, foldable-aware layout behavior, a dream-service mode, and Android 16 progress notifications without introducing a heavy engine stack.

## Interesting Findings

### Engine Architecture And Core Loop

- `Physics.kt` defines a compact `Simulator` abstraction with `updateAll`, `solveAll`, and `postUpdateAll`, plus a `step(nanos)` method that converts frame time into simulation time and clamps bogus long gaps with `MAX_VALID_DT`. That is a clean minimal pattern for Android mini-games that want continuous simulation without a full engine.
- `MainActivity.kt` drives the simulation with `withInfiniteAnimationFrameNanos { u.step(frameTimeNanos) }` inside a `LaunchedEffect`, which keeps the main loop inside Compose instead of splitting it into a separate thread or `SurfaceView` render loop.
- `VisibleUniverse.kt` separates simulation stepping from visual invalidation. `Telescope` and `UniverseModifierNode` subscribe to `Simulator.addSimulationStepListener` and invalidate only when a sim step completes, which is a useful pattern for frame-driven Compose games.
- `DreamUniverse.kt` reuses the same `Universe` runtime in a `DreamService` screensaver mode by only swapping host wiring and enabling autopilot, which is a good example of keeping the runtime portable across Android host surfaces inside one app.

### Rendering And Graphics

- `VisibleUniverse.kt` implements the whole visual stack as vector-style drawing over Compose primitives: stars, orbit rings, gravitational fields, ship outlines, autopilot overlays, tracks, sparks, landing flags, and debug grids are all drawn through one zoom-aware draw pipeline.
- `ZoomedDrawScope` is a practical micro-abstraction. It keeps track of the current zoom so the renderer can scale world geometry while still drawing fixed-pixel strokes where needed.
- `PathTools.kt` gives the renderer reusable helpers for polygons, stars, and a tiny SVG path parser. The ship and landing-leg shapes are authored as path data rather than bitmap sprites, which keeps the art pipeline trivial for a compact Android game.
- `MainActivity.kt` combines dynamic camera zoom, optional touch zoom/pan, and foldable-aware framing. When the app detects a half-open fold state through `WindowInfoTracker`, it shifts the camera center fraction instead of treating the fold as a generic inset.

### Gameplay Systems

- `Universe.kt` builds a full tiny solar-system sandbox rather than a purely cosmetic animation. It procedurally seeds a star plus `1..10` planets, computes orbital velocity from a simplified Kepler relationship, and tracks exploration/discovery per planet.
- Landing and exploration are modeled as game rules, not UI decoration. `Universe.solveAll` transitions the ship into a `Landing` constraint when angle conditions are met, flags planets as explored, and records `latestDiscovery`.
- `Spacecraft` owns thrust, launch timing, orbit/exhaust effects, landing attach/detach state, and a persistent flight track, keeping ship behavior relatively self-contained.

### Input And Controls

- `FlightStick` in `MainActivity.kt` is a concrete reusable Android touch-control pattern. It captures a one-finger gesture, stores origin and target offsets, converts stick radius into thrust magnitude, and keeps a dead-zone-orientation ring for re-aiming without accelerating.
- Manual ship control is intentionally separate from camera manipulation. `TOUCH_CAMERA_PAN` and `TOUCH_CAMERA_ZOOM` are optional transformable overlays, while the ship itself is controlled through the flight stick and explicit autopilot toggle.
- The repository is a good reference for small direct-Android control schemes where gesture capture and input visualization are owned by Compose rather than by a custom `View`.

### Physics And Collision

- `Physics.kt` uses a simple position-based flow: update velocities/positions, solve constraints, then recompute velocity from new and old positions. That gives the project a compact, understandable simulation core without a full physics engine dependency.
- `Universe.updateAll` applies gravity from every planet/star to the ship except during a short post-launch MECO window, and `Container` constrains the ship to a ring-fenced universe radius.
- `Landing` is implemented as a constraint instead of special-case state smeared across the whole update loop, which is a useful small-scale design choice for mobile games with attach/dock/land mechanics.

### AI And Behavior

- `Autopilot.kt` is a surprisingly useful small AI reference. It computes relative velocity and time-to-target in the target's moving reference frame, uses a smoothed braking-distance estimate, and switches among `CHASING`, `APPROACHING`, `LANDING`, `LANDED`, and `LAUNCHING` strategies.
- The autopilot also exposes telemetry text plus leading-position overlays consumed by the renderer, which is a nice example of making AI state debuggable and visually legible in-game.

### UI, HUD, And Android Integration

- `Telemetry` in `MainActivity.kt` shows a dense but readable in-game HUD pattern for small Android games: animated console-like overlays, system designation text, ship telemetry, explored-body catalog entries, and an in-world `AUTO` toggle all coexist inside the Compose shell.
- `DreamUniverse.kt` rehosts the same game into an Android daydream/screen-saver service, randomizes the ship start point for variety, and enables autopilot automatically. That is a niche but very Android-specific reuse pattern.
- `UniverseProgressNotifier.kt` is one of the most distinctive platform integrations in the repo. It maps ship angle into `notification.iconLevel`, uses Android 16 `Notification.ProgressStyle`, swaps end icons by planet size, and turns autopilot state into live progress notifications.

## Reusable Takeaways

- Compose can host a lightweight real-time Android game without `SurfaceView` if simulation, invalidation, drawing, and input are kept explicit and small.
- A tiny `Simulator` plus constraint layer is often enough for arcade/sandbox-style mobile games that only need gravity, landing, and bounded movement.
- Small Android games can get real product value from platform features such as foldable posture detection, dream services, and progress notifications instead of treating them as afterthoughts.
- Path-based vector rendering is a practical way to keep art assets lightweight when the game mostly needs symbols, rings, flags, and simple ships rather than texture-heavy scenes.

## Evidence Summary

- `Physics.kt` - compact simulator lifecycle, per-step listeners, and simple constraint-based motion flow
- `MainActivity.kt` - Compose frame loop, flight-stick input, dynamic camera, foldable-aware framing, and HUD shell
- `VisibleUniverse.kt` - zoom-aware custom draw pipeline, simulation-driven invalidation, vector ship/star/orbit rendering, and autopilot overlays
- `Universe.kt` - seeded solar-system generation, gravity, landing/exploration logic, and ship state ownership
- `Autopilot.kt` - small relative-motion guidance logic with explicit strategy transitions and telemetry
- `DreamUniverse.kt` - DreamService host mode reusing the same runtime
- `UniverseProgressNotifier.kt` - Android-native live progress notification integration around the running simulation

## Risks Or Limits

- The repository is intentionally narrow. It is best treated as a compact Android-native reference, not as a general-purpose engine or large-product architecture baseline.
- `README.md` says there are almost no changes from the original Android Easter Egg, and the source tree retains AOSP copyright headers throughout. That lowers originality, even though the repo is still useful as a standalone reading reference.
- No automated tests or CI workflows were found in the checked-in tree.
- The build now depends on a modern JVM/AGP stack (`Gradle 9`, `AGP 8.13`, Java `17+` to configure, Java `21` source/target), so the current lab machine cannot validate it beyond wrapper discovery.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `android-game`
- Focus tags: `2d`, `android`, `input`, `ui-hud`, `physics`, `ai`, `procedural-generation`
- Follow-up needed:
  - if the lab revisits this repository, do it in a real JDK `17+` or `21` Android environment and focus on the Compose draw-loop/invalidation seam, the autopilot behavior model, or the Android dream/notification integration rather than reopening the whole app broadly
