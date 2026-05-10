# Research Note

## Repository Snapshot

- Repository: `mariodujic/Neon`
- Source URL: [https://github.com/mariodujic/Neon](https://github.com/mariodujic/Neon)
- Owner: `mariodujic`
- Batch ID: [`BATCH-2026-05-10-L`](../batches/BATCH-2026-05-10-L.md)
- Type: `android-game`
- License: `MIT`
- Selection date: `2026-05-10`
- Last pushed at selection: `2025-11-22`
- Stars at selection: `81`
- Investigated commit: `bb633bc8cad5ad6dc0d8e787d0c3241f63adb3c2`
- Research status: `accepted`
- Build mode: `static-review + gradle-help-failed-java8-needs-java11`
- Catalog card: [catalog/projects/mariodujic-neon.md](../../catalog/projects/mariodujic-neon.md)

## Why This Repository Was Selected

- It was the strongest fresh-enough unresearched Android-native Kotlin game left in the current search results once the obvious low-signal student and toy repositories were filtered out.
- Compared with `mimoguz/tripeaks-gdx`, `kotcity/kotcity`, `wajahatkarim3/DinoCompose`, and `jayasuryat/minesweeper-j-compose`, it offered the best balance of direct Android relevance, recent enough maintenance, permissive licensing, and likely gameplay-architecture yield.
- It is especially useful because it shows a Jetpack Compose-only mobile shooter that still keeps its runtime organized into controllers, typed stage data, collision logic, boss patterns, and unit tests rather than collapsing everything into one monolithic composable.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: Android SDK + Jetpack Compose + coroutines
- Rendering stack: Compose `Image`/`Canvas` layers, animated gradients, Coil image loading for GIF explosions, and ExoPlayer-backed streamed music
- Android target: direct single-module Android application with portrait orientation and Compose UI
- Build system: single-app Gradle Groovy DSL project
- Repository layout summary: app entry and navigation in `MainActivity` plus `navigation/`, gameplay logic in `game/`, splash and pause UI in `splash/` and `gamepause/`, and tests under `app/src/test/`
- Source footprint:
  - total files reviewed in repository: `165`
  - Kotlin/Java files reviewed across the repository: `73`
- Test surface:
  - unit-test files found: `7`
  - instrumentation-test files found: `1`
- Key modules reviewed:
  - `README.md`
  - `build.gradle`
  - `settings.gradle`
  - `gradle.properties`
  - `app/build.gradle`
  - `gradle/wrapper/gradle-wrapper.properties`
  - `app/src/main/AndroidManifest.xml`
  - `.github/workflows/android-ci.yml`
  - `app/src/main/java/com/zero/neon/MainActivity.kt`
  - `app/src/main/java/com/zero/neon/navigation/Navigation.kt`
  - `app/src/main/java/com/zero/neon/game/GameScreen.kt`
  - `app/src/main/java/com/zero/neon/game/state/GameState.kt`
  - `app/src/main/java/com/zero/neon/core/Tinker.kt`
  - `app/src/main/java/com/zero/neon/game/world/GameWorld.kt`
  - `app/src/main/java/com/zero/neon/game/stage/Stage.kt`
  - `app/src/main/java/com/zero/neon/game/stage/StageController.kt`
  - `app/src/main/java/com/zero/neon/game/ship/ship/ShipController.kt`
  - `app/src/main/java/com/zero/neon/game/ship/laser/LasersController.kt`
  - `app/src/main/java/com/zero/neon/game/enemy/laser/EnemyLasersController.kt`
  - `app/src/main/java/com/zero/neon/game/enemy/ship/controller/EnemyController.kt`
  - `app/src/main/java/com/zero/neon/game/enemy/ship/factory/EnemyFactory.kt`
  - `app/src/main/java/com/zero/neon/game/enemy/ship/factory/FormationXOffset.kt`
  - `app/src/main/java/com/zero/neon/game/enemy/ship/model/RegularEnemy.kt`
  - `app/src/main/java/com/zero/neon/game/enemy/ship/model/LevelOneBoss.kt`
  - `app/src/main/java/com/zero/neon/game/enemy/ship/model/LevelTwoBoss.kt`
  - `app/src/main/java/com/zero/neon/game/spaceobject/SpaceObjectsController.kt`
  - `app/src/main/java/com/zero/neon/game/spaceobject/SpaceRock.kt`
  - `app/src/main/java/com/zero/neon/game/booster/BoosterController.kt`
  - `app/src/main/java/com/zero/neon/game/booster/GenerateBooster.kt`
  - `app/src/main/java/com/zero/neon/game/controls/MovementButtons.kt`
  - `app/src/main/java/com/zero/neon/game/audio/AudioPlayer.kt`
  - `app/src/test/java/com/zero/neon/core/TinkerTest.kt`
  - `app/src/test/java/com/zero/neon/game/stage/StageControllerTest.kt`
  - `app/src/test/java/com/zero/neon/game/enemy/ship/controller/EnemyControllerTest.kt`
  - `app/src/test/java/com/zero/neon/game/enemy/ship/factory/FormationXOffsetTest.kt`
  - `app/src/test/java/com/zero/neon/game/booster/BoosterControllerTest.kt`
  - `app/src/test/java/com/zero/neon/game/spaceobject/SpaceObjectsControllerTest.kt`

## Build And Runtime Notes

- The repository was investigated primarily through static code review plus lightweight Gradle discovery.
- `app/build.gradle` confirms a direct Android app target with `minSdk = 21`, `compileSdk = 36`, `targetSdk = 36`, Compose enabled, and dependencies on ExoPlayer, Coil, Navigation Compose, Mockito, and JUnit.
- `AndroidManifest.xml` confirms portrait-only gameplay and `INTERNET` permission, which is required because the current music playlist streams remote URIs rather than shipping only local audio assets.
- `.github/workflows/android-ci.yml` shows an intended CI path on JDK `17` via `./gradlew test`.
- `cmd /c gradlew.bat help --no-daemon` and `cmd /c gradlew.bat :app:testDebugUnitTest --dry-run --no-daemon` both fail in the current lab environment because the build resolves `com.android.tools.build:gradle:8.13.1`, which requires at least Java `11`, while the lab machine still exposes Java `8`.
- No runtime launch was attempted.
- Known setup limitations:
  - local build validation in this lab is blocked by the Java runtime floor
  - the current runtime architecture is Compose-state driven and best validated on-device rather than only from static reading

## Usefulness Assessment

- Reuse potential: `2`
- Android transfer: `3`
- Implementation depth: `2`
- Code clarity: `2`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - this repository is a useful direct-Android reference for Compose-native game structure, touch controls, simple scheduling, stage progression, and small but real unit-test coverage
  - it is not a large or especially advanced engine, but it fills a gap in the lab because most previous strong Android entries leaned on LibGDX or KorGE rather than pure Compose
  - it should be treated as a compact action-game sample, not as a high-performance or large-scale architecture baseline

## Interesting Findings

### Compose-Native Runtime Shell And Scheduling

- `app/src/main/java/com/zero/neon/MainActivity.kt` keeps the app shell very small: splash, game, and pause are routed through Compose Navigation, with the pause overlay implemented as a dialog destination rather than as a second activity or imperative fragment flow.
- `app/src/main/java/com/zero/neon/game/GameScreen.kt` separates the visible game shell into HUD, world, controls, and pause handling while all mutable gameplay state is provided by one `rememberGameState()` boundary.
- `app/src/main/java/com/zero/neon/game/state/GameState.kt` is the most valuable file in the repository. It assembles the runtime from specialized controllers for ship movement, ship lasers, enemy lasers, enemies, stars, boosters, explosions, minerals, space rocks, and stage flow, then projects them into UI-safe models for rendering.
- `app/src/main/java/com/zero/neon/core/Tinker.kt` is a compact micro-scheduler. It uses stable work IDs plus `Millis`, `Once`, and `Never` repeat policies so the game loop can express periodic work declaratively instead of maintaining many separate timers by hand.
- `GameState.kt` uses `tinker` to drive the whole loop: star animation, ship movement, collision monitoring, bullet processing, enemy spawning, boss entry, stage-time monitoring, and object cleanup. This is a clear pattern for a small action game that does not need a heavyweight custom engine.

### Stage Scripting, Progression, And Boss Flow

- `app/src/main/java/com/zero/neon/game/stage/Stage.kt` encodes the campaign as a typed sequence of `StageMessage`, `StageGame`, and `StageBoss` entries. Enemy stats, formations, spawn rates, and space-rock pressure are all described as data rather than being hidden inside imperative level logic.
- `app/src/main/java/com/zero/neon/game/stage/StageController.kt` adds an important twist: when stage time expires but the board is not clear yet, it returns `StageBreak` instead of advancing immediately. That makes progression dependent on both time and field state, which is a strong pattern for arcade wave design.
- `StageController.kt` also provides a custom `Saver`, and `rememberGameState()` wraps several runtime values in `rememberSaveable`. The result is not full disk persistence, but it does preserve important transient progress across configuration changes better than many small Android games.
- `app/src/main/java/com/zero/neon/game/enemy/ship/model/LevelOneBoss.kt` and `LevelTwoBoss.kt` provide two distinct boss patterns with low ceremony: one boss traces a rectangular path and aims shots toward the player position, while the other sweeps horizontally and emits a nearly wall-to-wall laser curtain with a random safe gap.

### Gameplay Controllers, Collisions, And Powerups

- `app/src/main/java/com/zero/neon/game/ship/ship/ShipController.kt` centralizes several subsystems that are often scattered in small games: movement clamping, shield timing, laser-booster timing, triple-shot timing, collision checks against four object families, HP changes, and powerup activation.
- `ShipController.kt` uses simple Compose `Rect` overlap tests and a larger circular shield rect to change the collision envelope when the shield is active. This is a practical lightweight collision approach for UI-driven 2D action games.
- `app/src/main/java/com/zero/neon/game/ship/laser/LasersController.kt` cleanly separates normal lasers, boosted lasers, and ultimate lasers. The same controller handles fire cadence, projectile cleanup, collision resolution against space rocks and enemies, and the screen-wide ultimate-laser sweep.
- `app/src/main/java/com/zero/neon/game/enemy/ship/controller/EnemyController.kt` keeps enemy lifecycle narrow: spawn through the factory, process movement/destroyed state, and trigger mineral drops plus explosions on death through injected callbacks.
- `app/src/main/java/com/zero/neon/game/enemy/ship/factory/EnemyFactory.kt` and `FormationXOffset.kt` show a useful tiny-factory pattern. Enemy waves are created from `EnemyType` data plus either `Row` or `ZigZag` formation metadata, while boss types spawn only once through `RepeatTime.Once`.
- `app/src/main/java/com/zero/neon/game/spaceobject/SpaceObjectsController.kt` and `app/src/main/java/com/zero/neon/game/booster/BoosterController.kt` show the same controller shape reused for hazards and pickups: spawn IDs, periodic processing, mutable list ownership, and one projection point back into Compose state.

### Rendering, HUD, Input, And Android Fit

- `app/src/main/java/com/zero/neon/game/world/GameWorld.kt` renders the game entirely with Compose primitives. Ships, enemies, lasers, rocks, minerals, boosters, and explosions are each layered as composables, while stars and the shield effect use `Canvas`.
- `GameWorld.kt` mixes several rendering techniques inside one Compose scene: `Image` sprites for most entities, animated radial gradients for the shield, simple canvas-based stars, and a Coil-loaded GIF explosion. This is a good reference for what a small Compose-only action game can look like without falling back to `SurfaceView`.
- `app/src/main/java/com/zero/neon/game/controls/MovementButtons.kt` uses `detectTapGestures(onPress)` plus `awaitRelease()` to expose hold-to-move semantics rather than only discrete taps. That is a direct reusable pattern for touch controls in mobile action games.
- `GameScreen.kt`, `StatusIndicator`, and `GamePauseDialog.kt` keep the HUD and pause affordances separate from the gameplay state loop. The pause dialog is also tied to `GameStatus`, so lifecycle pause, settings-button pause, and audio pause stay coordinated.
- `app/src/main/java/com/zero/neon/game/audio/AudioPlayer.kt` couples `GameStatus` to ExoPlayer playback. It remembers the last playback position when paused and resumes from that point, which is simple but effective for background music continuity.

### Verification Surface

- `app/src/test/java/com/zero/neon/core/TinkerTest.kt` verifies the custom scheduler rather than leaving the timing helper completely untested.
- `app/src/test/java/com/zero/neon/game/stage/StageControllerTest.kt` verifies stage advancement, break behavior, and end-of-list handling, which is especially valuable because the stage pipeline is one of the more reusable subsystems.
- `app/src/test/java/com/zero/neon/game/enemy/ship/controller/EnemyControllerTest.kt`, `FormationXOffsetTest.kt`, `BoosterControllerTest.kt`, and `SpaceObjectsControllerTest.kt` confirm that several gameplay controllers and formation helpers were written with at least some explicit behavioral verification instead of only manual testing.

## Reusable Takeaways

- A small Android action game can stay readable if Compose only renders projected UI models while controllers own movement, spawning, collisions, boosters, and progression.
- A micro-scheduler like `tinker` plus typed `RepeatTime` policies can be enough to express many arcade-game loops without introducing a full ECS or frame-callback engine layer.
- Typed stage lists with explicit break states are a strong alternative to burying wave progression inside one large update function.
- Press-and-hold touch controls implemented with `awaitRelease()` give more game-like input semantics than ordinary button clicks in Compose.

## Evidence Summary

- `MainActivity.kt` and `navigation/Navigation.kt` - confirmed the app shell, splash-to-game routing, and dialog-based pause flow
- `GameScreen.kt` and `GameWorld.kt` - confirmed the HUD/world split and fully Compose-driven rendering strategy
- `GameState.kt` and `Tinker.kt` - confirmed controller composition, periodic scheduling, lifecycle pause handling, and config-restorable transient state
- `Stage.kt` and `StageController.kt` - confirmed typed wave scripting, `StageBreak`, and stage saver behavior
- `ShipController.kt`, `LasersController.kt`, `EnemyLasersController.kt`, and `EnemyController.kt` - confirmed controller-owned movement, projectiles, collisions, enemy lifecycle, drops, and explosions
- `EnemyFactory.kt`, `FormationXOffset.kt`, `RegularEnemy.kt`, `LevelOneBoss.kt`, and `LevelTwoBoss.kt` - confirmed formation-based spawning and boss-pattern design
- `MovementButtons.kt` and `AudioPlayer.kt` - confirmed touch-hold controls and playback tied to game status
- unit tests plus `.github/workflows/android-ci.yml` - confirmed targeted verification surface and intended JDK 17 CI path

## Risks Or Limits

- The repository is a compact sample, not a broad engine or deep systems game.
- The runtime pushes frequent Compose state updates from a controller-driven loop, so it should be treated as a small-game pattern sample rather than a proven large-scale performance baseline.
- There is no durable disk save/load system; persistence is mostly limited to configuration-safe transient state through `rememberSaveable` and a custom `Saver`.
- Local build validation is blocked in this lab because the project requires Java `11+`, while the current environment still exposes Java `8`.
- Music currently streams from remote URLs, so audio behavior depends on network access rather than only packaged local assets.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `android-game`
- Focus tags: `2d`, `android`, `input`, `ui-hud`, `collision`, `audio`, `testing`
- Follow-up needed:
  - if the lab revisits this repository later, focus on one subsystem such as the `tinker` loop, stage scripting, or the controller-based collision/powerup flow
  - if a Java `11+` or `17` environment becomes available, verify whether the CI-intended unit-test surface still passes on the inspected revision
