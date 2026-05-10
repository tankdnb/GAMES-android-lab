# Research Note

## Repository Snapshot

- Repository: `Quillraven/Quilly-s-Adventure`
- Source URL: [https://github.com/Quillraven/Quilly-s-Adventure](https://github.com/Quillraven/Quilly-s-Adventure)
- Owner: `Quillraven`
- Batch ID: [`BATCH-2026-05-10-J`](../batches/BATCH-2026-05-10-J.md)
- Type: `android-game`
- License: `MIT`
- Selection date: `2026-05-10`
- Last pushed at selection: `2024-10-26`
- Stars at selection: `98`
- Investigated commit: `a477151a7e5e29d680ea00d771d8f175bd2d6b7d`
- Research status: `accepted`
- Build mode: `static-review + gradle-help-failed-java8-needs-java11`
- Catalog card: [catalog/projects/quillraven-quilly-s-adventure.md](../../catalog/projects/quillraven-quilly-s-adventure.md)

## Why This Repository Was Selected

- It was the strongest remaining gameplay-heavy Kotlin candidate after the recent engine-heavy batches.
- Compared with `ore-infinium`, `thelema-engine`, `minigdx/minigdx`, and `kotcity`, it offered the best balance of direct Android transfer, manageable size, permissive licensing, and likely subsystem yield.
- It is especially useful for the lab because it combines LibGDX, LibKTX, Ashley ECS, Box2D, Tiled, and touch-oriented HUD controls inside one complete game sample rather than only one isolated subsystem.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: LibGDX + LibKTX + Ashley ECS + Box2D
- Rendering stack: SpriteBatch, OrthogonalTiledMapRenderer, Box2D Lights, custom shaders, framebuffers for screen and map transitions
- Android target: direct Android application module with touch HUD controls, native dependency packaging, and shared asset folder
- Build system: multi-module Gradle Groovy DSL project with `android`, `core`, `lwjgl3`, and `teavm` modules
- Repository layout summary: shared game logic in `core/`, Android launcher in `android/`, desktop launcher/packaging in `lwjgl3/`, browser build in `teavm/`, and common assets in root `assets/`
- Source footprint:
  - total files reviewed in repository: `450`
  - Kotlin/Java files reviewed across the repository: `108`
- Key modules reviewed:
  - `README.md`
  - `build.gradle`
  - `settings.gradle`
  - `gradle.properties`
  - `core/build.gradle`
  - `android/build.gradle`
  - `lwjgl3/build.gradle`
  - `teavm/build.gradle`
  - `core/src/main/kotlin/com/github/quillraven/quillysadventure/Main.kt`
  - `core/src/main/kotlin/com/github/quillraven/quillysadventure/PhysicContactListener.kt`
  - `core/src/main/kotlin/com/github/quillraven/quillysadventure/ecs/EcsUtils.kt`
  - `core/src/main/kotlin/com/github/quillraven/quillysadventure/map/Map.kt`
  - `core/src/main/kotlin/com/github/quillraven/quillysadventure/map/MapManager.kt`
  - `core/src/main/kotlin/com/github/quillraven/quillysadventure/event/GameEventManager.kt`
  - `core/src/main/kotlin/com/github/quillraven/quillysadventure/screen/LoadingScreen.kt`
  - `core/src/main/kotlin/com/github/quillraven/quillysadventure/screen/Screen.kt`
  - `core/src/main/kotlin/com/github/quillraven/quillysadventure/screen/GameScreen.kt`
  - `core/src/main/kotlin/com/github/quillraven/quillysadventure/ecs/system/RenderSystem.kt`
  - `core/src/main/kotlin/com/github/quillraven/quillysadventure/ecs/system/PhysicSystem.kt`
  - `core/src/main/kotlin/com/github/quillraven/quillysadventure/ecs/system/PlayerInputSystem.kt`
  - `core/src/main/kotlin/com/github/quillraven/quillysadventure/ecs/system/PlayerCollisionSystem.kt`
  - `core/src/main/kotlin/com/github/quillraven/quillysadventure/ecs/system/AttackSystem.kt`
  - `core/src/main/kotlin/com/github/quillraven/quillysadventure/ecs/system/AbilitySystem.kt`
  - `core/src/main/kotlin/com/github/quillraven/quillysadventure/ecs/system/CameraSystem.kt`
  - `core/src/main/kotlin/com/github/quillraven/quillysadventure/ecs/system/SaveSystem.kt`
  - `core/src/main/kotlin/com/github/quillraven/quillysadventure/ecs/system/TriggerSystem.kt`
  - `core/src/main/kotlin/com/github/quillraven/quillysadventure/ecs/system/TutorialSystem.kt`
  - `core/src/main/kotlin/com/github/quillraven/quillysadventure/trigger/Trigger.kt`
  - `core/src/main/kotlin/com/github/quillraven/quillysadventure/audio/DefaultAudioService.kt`
  - `core/src/main/kotlin/com/github/quillraven/quillysadventure/ui/GameHUD.kt`
  - `core/src/test/kotlin/com/github/quillraven/quillysadventure/trigger/TriggerTests.kt`

## Build And Runtime Notes

- The repository was investigated primarily through static code review plus lightweight Gradle discovery.
- `.\gradlew.bat help --no-daemon` and `.\gradlew.bat :core:test --dry-run --no-daemon` both failed during root-project configuration because `com.android.tools.build:gradle:8.5.2` requires at least Java `11`, while the current research environment still exposes Java `8`.
- `README.md` confirms an October 2024 modernization pass that upgraded LibGDX, Kotlin, Gradle, LibKTX, and added a TeaVM backend.
- `android/build.gradle` confirms a real Android application target with `compileSdk 34`, `targetSdkVersion 34`, `minSdkVersion 19`, shared root assets, and native LibGDX packaging tasks.
- `lwjgl3/build.gradle` and `teavm/build.gradle` confirm that the same shared game logic also targets desktop and browser builds.
- No runtime launch was attempted.
- Known setup limitations:
  - Java `11+` is required for meaningful Gradle discovery on the inspected revision
  - the current automated test surface is small compared with the runtime surface; only the trigger DSL has explicit repository tests in this snapshot

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `3`
- Implementation depth: `3`
- Code clarity: `3`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - this repository is a strong Android-relevant gameplay reference because it connects ECS, Box2D, Tiled, UI controls, save/load, triggers, and map transitions into one coherent loop
  - it is smaller than the heavy sandbox or engine candidates, which makes the reusable patterns easier to extract and transfer into new Android games
  - it is not groundbreaking as engine research, but it is very strong as a practical gameplay-architecture reference for Kotlin + LibGDX projects

## Interesting Findings

### Engine Architecture And Core Loop

- `core/src/main/kotlin/com/github/quillraven/quillysadventure/Main.kt` builds a shared runtime around `PooledEngine`, Box2D world, screen framebuffers, DI-style context registration, and a `GameEventManager` input/event hub. Screen transitions are rendered through two framebuffers rather than instantaneous swaps.
- `core/src/main/kotlin/com/github/quillraven/quillysadventure/screen/LoadingScreen.kt` is the real assembly point of the game. It creates the `MapManager`, registers the full ordered ECS pipeline, spawns the player entity once, and only then wires the menu, intro, game, and end screens around the shared engine.
- `core/src/main/kotlin/com/github/quillraven/quillysadventure/screen/Screen.kt` pauses almost all non-render systems whenever a dialog is visible, then resumes them automatically when the dialog closes. This is a clean pattern for modal story interactions in action games without creating a second paused simulation path.
- `core/src/main/kotlin/com/github/quillraven/quillysadventure/event/GameEventManager.kt` acts as a small bus for input, map-change, and gameplay events. Systems and screens subscribe only to the event categories they need, which keeps HUD, tutorial, audio, and trigger logic decoupled from direct system references.

### ECS Composition, Physics, And Gameplay

- `core/src/main/kotlin/com/github/quillraven/quillysadventure/ecs/EcsUtils.kt` is the most valuable file in the repository. It centralizes entity factories for characters, items, scenery, portals, particle effects, missiles, and triggers, so Tiled objects and config data become entity composition rather than ad hoc screen code.
- `EcsUtils.kt` also shows a practical Box2D body layout for platformer characters: a high-friction main body, zero-friction side fixtures to avoid wall sticking, a dedicated foot sensor for grounded checks, and optional aggro sensors for AI range detection.
- `core/src/main/kotlin/com/github/quillraven/quillysadventure/PhysicContactListener.kt` cleanly separates contact collection from physical blocking. It tracks ground contacts, aggro sensors, and general collisions, while `preSolve` selectively disables physics response for interactions such as player-vs-enemy or player-vs-NPC without losing contact events.
- `core/src/main/kotlin/com/github/quillraven/quillysadventure/ecs/system/PhysicSystem.kt` steps Box2D with a fixed `1/45f` interval, caps how much backlog can accumulate, stores previous physics positions, and interpolates render positions after stepping. This is directly reusable for smoother mobile rendering over a fixed physics step.
- `core/src/main/kotlin/com/github/quillraven/quillysadventure/ecs/system/AttackSystem.kt` creates short-lived damage-emitter entities instead of embedding hit logic directly into animation or body fixtures. Attack cooldowns and "attack ready" feedback are also routed through the event bus.
- `core/src/main/kotlin/com/github/quillraven/quillysadventure/ecs/system/AbilitySystem.kt` keeps ability update and cast-order consumption inside one system, while each ability instance decides whether it can cast and how it dispatches its gameplay effect.

### Map, Content, And Scene Flow

- `core/src/main/kotlin/com/github/quillraven/quillysadventure/map/Map.kt` defines a compact Tiled contract: named layers for collisions, enemies, save points, NPCs, items, portals, and triggers, plus map properties for ambient light, sun color, portal targets, parallax, and trigger collision behavior.
- `core/src/main/kotlin/com/github/quillraven/quillysadventure/map/MapManager.kt` is a high-yield implementation. It caches loaded maps, stores the IDs of surviving map-linked entities, rebuilds scenery/NPC/item/portal/trigger entities from Tiled objects when entering a map, and repositions the player either to spawn points or portal exits.
- `MapManager.kt` uses `TmxMapComponent.id` and a per-map entity cache to preserve world progression across map transitions without keeping every map live in memory at once. That is a strong reusable pattern for 2D adventure games with multiple rooms or zones.
- `core/src/main/kotlin/com/github/quillraven/quillysadventure/screen/GameScreen.kt` layers a second transition system on top of the screen transition: map changes snapshot the previous and current map render into framebuffers and crossfade them, while the HUD and stage stay active.

### Input, UI, And Android Transfer

- `core/src/main/kotlin/com/github/quillraven/quillysadventure/ecs/system/PlayerInputSystem.kt` translates abstract move/jump/attack/cast input events into ECS orders rather than directly moving bodies.
- `core/src/main/kotlin/com/github/quillraven/quillysadventure/ui/GameHUD.kt` is one of the best Android-transfer files in the repo. It exposes a touchpad plus touch-and-hold action buttons that dispatch the same abstract input events used by keyboard controls, so the gameplay layer stays platform-agnostic.
- `GameScreen.kt` and `GameHUD.kt` also show a useful split between lightweight in-play HUD updates and a richer stats screen that can be opened from the portrait, with double-tap skill activation for choosing the current castable ability.
- `android/build.gradle` shares the root `assets/` directory across Android and other targets, which keeps content packaging consistent across mobile, desktop, and web builds.

### Rendering, Lighting, And Presentation

- `core/src/main/kotlin/com/github/quillraven/quillysadventure/ecs/system/RenderSystem.kt` renders sorted ECS sprites between Tiled background and foreground layers, supports per-layer parallax based on Tiled properties, updates animated tiles, and exposes several shader modes such as grayscale, sepia-vignette, and configurable color filtering.
- `core/src/main/kotlin/com/github/quillraven/quillysadventure/ecs/system/CameraSystem.kt` clamps the camera to map bounds when maps are larger than the viewport, but automatically falls back to simple follow behavior on smaller maps.
- `MapManager.kt` plus `RenderSystem.kt` and the shared `RayHandler` setup create a nice combined lighting model: map properties configure ambient light and sun light, while runtime systems handle rendering and resizing of the light FBOs.
- `Main.kt` applies a second framebuffer-based crossfade for full screen switches, which complements the in-map transition flow without requiring each screen to know how to animate transitions itself.

### Progression, Save/Load, And Scripting-Like Triggers

- `core/src/main/kotlin/com/github/quillraven/quillysadventure/ecs/system/SaveSystem.kt` serializes a compact save snapshot into `Preferences`: current map, alive map entity IDs, shown tutorials, checkpoint, unlocked abilities, and player stats. This is smaller and more robust than trying to serialize the entire live ECS world.
- `core/src/main/kotlin/com/github/quillraven/quillysadventure/ecs/system/PlayerCollisionSystem.kt` ties together portals, items, save points, and triggers. Portal transitions can immediately request a save, items produce floating feedback text and stat growth, and checkpoints both heal the player and persist progress.
- `core/src/main/kotlin/com/github/quillraven/quillysadventure/trigger/Trigger.kt` implements a pooled trigger DSL with typed actions and conditions obtained through reflection pools. Triggers can be activated by collisions or by world-state conditions and then execute staged actions over time.
- `core/src/main/kotlin/com/github/quillraven/quillysadventure/ecs/system/TriggerSystem.kt` and `TutorialSystem.kt` show how the event bus and trigger model work together: one system activates or removes scripted triggers, while another turns gameplay milestones into one-time tutorial dialogs.

### Audio, Tooling, And Verification Surface

- `core/src/main/kotlin/com/github/quillraven/quillysadventure/audio/DefaultAudioService.kt` caches both music and sounds, avoids queueing the same sound effect several times in one frame, and uses map-change events to switch background music.
- `lwjgl3/build.gradle` adds desktop packaging via Construo, while `teavm/build.gradle` shows that the shared core was intentionally adapted for browser export after the 2024 refresh.
- `core/build.gradle` has a real but narrow test surface: Kotlin test + MockK on JUnit Platform.
- `core/src/test/kotlin/com/github/quillraven/quillysadventure/trigger/TriggerTests.kt` verifies the trigger DSL, including condition/action registration and delayed action execution. The tests do not cover the entire runtime, but they do validate one of the more custom reusable subsystems.

## Reusable Takeaways

- A small action-adventure can stay maintainable if Tiled objects map into ECS entity factories instead of being interpreted ad hoc inside screens.
- Fixed-step Box2D plus render interpolation is still one of the most transferable patterns for Android-friendly 2D games, especially when paired with an input-event abstraction rather than direct body mutation from UI code.
- Saving only map identity, surviving map object IDs, player checkpoint/state, and tutorial progression is often enough for a content-driven adventure game; serializing the full runtime is not always necessary.
- Touch controls become much easier to keep honest when they emit the same abstract jump/attack/cast/move events as keyboard controls.

## Evidence Summary

- `README.md` - repo purpose, update-to-2024 note, TeaVM addition, claimed finished gameplay slice
- `build.gradle`, `settings.gradle`, `core/build.gradle`, `android/build.gradle`, `lwjgl3/build.gradle`, `teavm/build.gradle` - target matrix and build surface
- `Main.kt` - shared runtime, Box2D init, DI context, screen transition FBOs
- `LoadingScreen.kt` - asset loading, ECS system ordering, shared screen assembly
- `Screen.kt` - automatic simulation pause during dialogs
- `GameEventManager.kt` - input/map/game event bus
- `EcsUtils.kt` - entity factories, body layout, triggers, missiles, portals, scenery
- `PhysicContactListener.kt` - contact routing and selective non-blocking collisions
- `PhysicSystem.kt` - fixed physics step and interpolation
- `Map.kt` and `MapManager.kt` - Tiled contract, map cache, entity reconstruction, ambient light
- `RenderSystem.kt` and `CameraSystem.kt` - parallax, shader modes, sorted entity rendering, clamped camera
- `PlayerInputSystem.kt` and `GameHUD.kt` - abstract input layer plus Android-style touch HUD
- `PlayerCollisionSystem.kt`, `SaveSystem.kt`, `Trigger.kt`, `TriggerSystem.kt`, and `TutorialSystem.kt` - progression, savepoints, triggers, tutorials, and portal flow
- `DefaultAudioService.kt` - cached audio playback and map-driven music switching
- `TriggerTests.kt` - verification of trigger DSL behavior

## Risks Or Limits

- The project is active enough to modernize dependencies in late 2024, but it is not especially fresh now, so it should not be treated as a fast-moving reference.
- The current test surface is narrow relative to the runtime complexity; most gameplay systems are unverified by repository tests in this snapshot.
- Build discovery is blocked in the current environment because the repository now requires Java `11+`, while the lab machine still has Java `8`.
- The repository is a strong adventure/platformer reference, but it is narrower than a general-purpose engine or sandbox game.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `android-game`
- Focus tags: `2d`, `android`, `libgdx`, `physics`, `save-load`, `input`, `ui-hud`, `asset-pipeline`
- Follow-up needed:
  - if the lab revisits this repository later, focus on one subsystem such as the trigger DSL, the Tiled-to-ECS map flow, or the TeaVM compatibility adjustments
  - if a Java `11+` environment becomes available, verify whether `:core:test` actually passes and whether the Android/Desktop/Web targets still build cleanly on the refreshed toolchain
