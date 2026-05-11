# Research Note

## Repository Snapshot

- Repository: `wajahatkarim3/DinoCompose`
- Source URL: [https://github.com/wajahatkarim3/DinoCompose](https://github.com/wajahatkarim3/DinoCompose)
- Owner: `wajahatkarim3`
- Batch ID: [`BATCH-2026-05-11-F`](../batches/BATCH-2026-05-11-F.md)
- Type: `android-game`
- License: `Apache-2.0`
- Selection date: `2026-05-11`
- Last pushed at selection: `2022-01-09`
- Stars at selection: `285`
- Investigated commit: `10ee4069d57c3c15c47161fcf88a07107f6e83c6`
- Research status: `reference-only`
- Build mode: `static-review + gradle-help-failed-java8-needs-java11`
- Catalog card: [catalog/projects/wajahatkarim3-dinocompose.md](../../catalog/projects/wajahatkarim3-dinocompose.md)

## Why This Repository Was Selected

- It remained the strongest lightweight Android-native Kotlin candidate in the refreshed shortlist after filtering out fresher but near-zero-signal repositories.
- The repository is directly relevant to the lab because it shows a Jetpack Compose-only endless-runner sample rather than another LibGDX, KorGE, or multiplatform stack.
- Even though it is small, it is useful as a comparison point next to `mariodujic/Neon` and `vgupta98/compose-game`, especially for path-based vector rendering, debug hitbox overlays, and tiny endless-runner state modeling.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: Android SDK + Jetpack Compose + LiveData
- Rendering stack: Compose `Canvas`, transformed vector `Path` drawing via `PathParser`, dashed line effects for the ground, and theme-driven recoloring
- Android target: direct single-app Android application
- Build system: single-app Gradle Groovy DSL project
- Repository layout summary: one `app/` module with a single activity, one main gameplay composable, code-embedded vector paths, lightweight state-holder models, and placeholder host/instrumentation tests
- Source footprint:
  - total files reviewed in repository: `50`
  - Kotlin/Java files reviewed across the repository: `11`
- Test surface:
  - unit-test files found: `1`
  - instrumentation-test files found: `1`
- Key modules reviewed:
  - `README.md`
  - `LICENSE`
  - `settings.gradle`
  - `build.gradle`
  - `app/build.gradle`
  - `gradle/wrapper/gradle-wrapper.properties`
  - `app/src/main/AndroidManifest.xml`
  - `app/src/main/java/com/wajahatkarim3/dino/compose/MainActivity.kt`
  - `app/src/main/java/com/wajahatkarim3/dino/compose/DinoComposeGame.kt`
  - `app/src/main/java/com/wajahatkarim3/dino/compose/AssetPaths.kt`
  - `app/src/main/java/com/wajahatkarim3/dino/compose/Theme.kt`
  - `app/src/main/java/com/wajahatkarim3/dino/compose/model/GameState.kt`
  - `app/src/main/java/com/wajahatkarim3/dino/compose/model/DinoState.kt`
  - `app/src/main/java/com/wajahatkarim3/dino/compose/model/CactusState.kt`
  - `app/src/main/java/com/wajahatkarim3/dino/compose/model/CloudState.kt`
  - `app/src/main/java/com/wajahatkarim3/dino/compose/model/EarthState.kt`
  - `app/src/test/java/com/wajahatkarim3/dino/compose/ExampleUnitTest.kt`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` confirms the wrapper is on Gradle `7.0.2` and the current lab JVM is still `1.8.0_321`.
- `cmd /c gradlew.bat help --no-daemon` fails immediately because `com.android.tools.build:gradle:7.0.2` requires Java `11`, while the current lab machine still exposes Java `8`.
- `cmd /c gradlew.bat :app:testDebugUnitTest --dry-run --no-daemon` fails for the same reason before test-task discovery can complete.
- `build.gradle` and `app/build.gradle` also show an older toolchain shape: `compose_version = "1.0.3"`, `compileSdkVersion 30`, `jcenter()`, the Kotlin EAP Bintray repository, and deprecated `kotlin-android-extensions`.
- No runtime launch was attempted.
- Known setup limitations:
  - local build verification in this lab is blocked by the Java runtime floor
  - long-term reproducibility is additionally weakened by dead or legacy repository dependencies such as `jcenter()` and `dl.bintray.com`

## Usefulness Assessment

- Reuse potential: `2`
- Android transfer: `3`
- Implementation depth: `1`
- Code clarity: `1`
- Novelty: `2`
- Overall verdict: `reference-only`
- Why:
  - the repository is directly transferable to Android because it is a native Compose game sample
  - the path-based rendering, endless-runner recycling, and debug hitbox overlay are worth keeping
  - it is still too small and too architecture-compromised to treat as a primary catalog model: the gameplay loop mutates state during composition, key dimensions live in globals, the score state still relies on `LiveData`, and the test surface is effectively placeholder-only

## Interesting Findings

### Engine Architecture And Core Loop

- `app/src/main/java/com/wajahatkarim3/dino/compose/MainActivity.kt` keeps the Android shell minimal: it reads `DisplayMetrics`, writes `deviceWidthInPixels` and `distanceBetweenCactus` into global mutable state, then launches `DinoGameScene(GameState())`.
- `app/src/main/java/com/wajahatkarim3/dino/compose/DinoComposeGame.kt` keeps runtime state in four remembered holders: `CloudState`, `EarthState`, `CactusState`, and `DinoState`. While `!gameState.isGameOver`, it increments score, advances every subsystem, and runs collision checks directly inside composition. This is useful mainly as a minimal Compose-game loop example and as a cautionary counterexample for production structure.
- `app/src/main/java/com/wajahatkarim3/dino/compose/model/GameState.kt` stores score and high score in `MutableLiveData` and exposes them through `observeAsState()`, preserving an early Compose-era bridge between old lifecycle state and composable UI.
- `app/src/main/java/com/wajahatkarim3/dino/compose/model/DinoState.kt` models the dinosaur as a tiny state machine with `velocityY`, `gravity`, `isJumping`, and a two-keyframe path animation that only advances while grounded.

### Rendering And Graphics

- `app/src/main/java/com/wajahatkarim3/dino/compose/AssetPaths.kt` is the strongest technical reference in the repository. It embeds cloud, cactus, and dinosaur silhouettes as SVG-like path strings, parses them with `PathParser`, rescales them through Android `Matrix`, and converts them back into Compose `Path` objects.
- `app/src/main/java/com/wajahatkarim3/dino/compose/DinoComposeGame.kt` renders the whole runner inside one Compose `Canvas`, using `withTransform`, `drawPath`, and dashed `PathEffect` lines for the ground instead of sprite sheets or a `SurfaceView`.
- `app/src/main/java/com/wajahatkarim3/dino/compose/Theme.kt` maps light and dark Material colors into game-specific earth/cloud/dino/score colors, letting the same vector art switch cleanly between bright and dark variants without duplicating assets.

### Gameplay Systems

- `app/src/main/java/com/wajahatkarim3/dino/compose/model/CactusState.kt` shows a compact endless-runner obstacle queue: it seeds three randomized cacti, advances them left every tick, and replaces the head with a newly randomized cactus positioned after the current tail.
- `app/src/main/java/com/wajahatkarim3/dino/compose/model/CloudState.kt` and `app/src/main/java/com/wajahatkarim3/dino/compose/model/EarthState.kt` use the same recycle-forward idea for background clouds and dashed ground blocks, keeping scrolling logic out of the rendering code.
- `GameState.replay()` plus `CactusState.initCactus()` and `DinoState.init()` provide a tiny replay loop that preserves the high score before resetting runtime state.

### Input And Controls

- `app/src/main/java/com/wajahatkarim3/dino/compose/DinoComposeGame.kt` makes the full gameplay column `clickable`, so any tap either triggers `dinoState.jump()` or reinitializes the run after game over. This is a simple but effective single-input pattern for tiny mobile prototypes.
- `ShowBoundsSwitchView()` inside the same file adds an in-scene debug toggle instead of requiring a second debug screen or build variant.

### UI, HUD, And Menus

- `HighScoreTextViews()` shows a compact score HUD with padded `HI`, high-score, and current-score fields rather than using a separate HUD layer system.
- `GameOverTextView()` overlays the `GAME OVER` label and replay icon directly on top of the play field, which is enough for a minimal runner loop.
- `drawBoundingBox()` exposes both the raw and deflated collision boxes at runtime, which is a useful visual-debugging trick for toy or prototype projects.

### Physics And Collision

- `DinoComposeGame.kt` checks collisions by taking `DinoState.getBounds()` and each `CactusModel.getBounds()`, deflating both rects by `DOUBT_FACTOR`, and then calling `Rect.overlaps(...)`. This is a practical way to approximate hitboxes from vector art without implementing shape-aware collision.
- `app/src/main/java/com/wajahatkarim3/dino/compose/model/CactusState.kt` keeps the cactus hitbox scale-aware so collision math still tracks the randomized cactus scale used for drawing.

### Tooling, Android Integration, Or Other Notable Areas

- `app/build.gradle` confirms a direct Android app target with `minSdkVersion 22`, `targetSdkVersion 30`, Compose enabled, and `runtime-livedata` included specifically to bridge `LiveData` into Compose.
- `app/src/main/AndroidManifest.xml` confirms that the project is intentionally a single-launcher-activity app without cross-platform abstraction layers or extra Android services.
- `app/src/test/java/com/wajahatkarim3/dino/compose/ExampleUnitTest.kt` is only the default `2 + 2` placeholder, which materially lowers the repository's value as a verified architecture reference.

## Reusable Takeaways

- Code-embedded vector paths plus `PathParser` and matrix scaling are a useful asset-light technique for small Compose game prototypes.
- Small state-holder classes are enough to model obstacle, ground, and cloud recycling in an endless runner without a larger engine layer.
- A runtime hitbox toggle is cheap and worth keeping in prototype-friendly Android game scaffolds.
- Pure Compose can support tiny game prototypes directly, but production gameplay updates should move out of composition and into a frame-driven effect or engine loop.

## Evidence Summary

- `MainActivity.kt` - Android shell, display metrics, and global runtime dimensions
- `DinoComposeGame.kt` - main Compose scene, inline game loop, input, HUD, debug bounds, and collision checks
- `AssetPaths.kt` - embedded vector path parsing and scaling
- `Theme.kt` - light/dark game palette adaptation
- `model/GameState.kt` - score/high-score state and replay flow
- `model/DinoState.kt` - jump arc and keyframe switching
- `model/CactusState.kt` - obstacle queue, randomized spacing, and scale-aware hitboxes
- `model/CloudState.kt` - recycled background cloud logic
- `model/EarthState.kt` - recycled dashed ground segments
- `app/build.gradle` and `gradle-wrapper.properties` - old Compose/AGP build surface and Java requirement
- `ExampleUnitTest.kt` - placeholder-only test surface

## Risks Or Limits

- The gameplay loop mutates runtime state directly during composition, which makes this a weak primary architecture model.
- Key dimensions such as screen width and cactus spacing are stored in global mutable variables.
- The project is stale at selection time and still built around Compose `1.0.3`, AGP `7.0.2`, `jcenter()`, and the Kotlin EAP Bintray repository.
- The automated test surface is effectively absent beyond placeholders.
- The game scope is very narrow, so the repository is most useful for tiny runner and vector-drawing ideas rather than for broader Android game architecture.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `reference-only`
- Focus tags: `2d`, `android`, `input`, `ui-hud`, `collision`
- Follow-up needed:
  - if the lab revisits this repository later, focus on either the path-based vector rendering approach or on how the loop should be moved into a frame-driven Compose effect such as `LaunchedEffect` with a proper tick source
