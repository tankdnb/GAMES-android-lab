# Research Note

## Repository Snapshot

- Repository: `Quillraven/Dark-Matter`
- Source URL: [https://github.com/Quillraven/Dark-Matter](https://github.com/Quillraven/Dark-Matter)
- Owner: `Quillraven`
- Batch ID: [`BATCH-2026-06-04-U`](../batches/BATCH-2026-06-04-U.md)
- Type: `android-game`
- License: `MIT`
- Selection date: `2026-06-04`
- Last pushed at selection: `2023-02-05`
- Stars at selection: `55`
- Default branch at selection: `master`
- Investigated commit: `676da9ddaec5b61e8ff08253cae99d01705dedb8`
- Research status: `accepted`
- Build mode: `static-review + gradle-help-failed-no-jdk-tools`
- Catalog card: [catalog/projects/quillraven-dark-matter.md](../../catalog/projects/quillraven-dark-matter.md)

## Why This Repository Was Selected

- `Quillraven/Dark-Matter` was the next exact-license-verified repository in the short backlog and the strongest remaining direct Android game candidate.
- The main question for this batch was whether an older, narrower LibGDX autoscroller from the same author as `Quilly-s-Adventure` still contains enough reusable structure to stay in the main catalog.
- The answer is yes: it is smaller and older than `Quilly-s-Adventure`, but it still preserves a clean Ashley ECS shell, fixed-step interpolated movement, pointer-follow mobile input, code-driven Scene2D HUD patterns, and a few presentation tricks that remain easy to cite later.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: LibGDX + LibKTX + Ashley ECS
- Rendering stack:
  - libGDX `Stage`, `Batch`, `Viewport`, `TextureAtlas`, and `ShaderProgram`
  - Sprite-based ECS rendering with z/y sort order
  - scrolling repeated background plus outline shader for shielded player rendering
- Android target: direct Android application module with portrait orientation, immersive mode, shared root assets, and copied native libraries
- Build system: Gradle Kotlin DSL multi-module project with `buildSrc`, `core`, `android`, and `desktop`
- Repository layout summary:
  - `core/` contains the shared game runtime, ECS, assets, UI, and screens
  - `android/` contains the Android launcher, manifest, and packaging configuration
  - `desktop/` contains the desktop launcher and fat-jar packaging path
  - `assets/` stores shared content for both Android and desktop
- Source footprint:
  - total files counted in repository: `191`
  - Kotlin/Java files counted in repository: `40`
  - test files found: `0`
- Key modules reviewed:
  - `README.md`
  - `build.gradle.kts`
  - `settings.gradle.kts`
  - `gradle.properties`
  - `buildSrc/src/main/kotlin/Versions.kt`
  - `.github/workflows/build.yml`
  - `core/build.gradle.kts`
  - `android/build.gradle.kts`
  - `desktop/build.gradle.kts`
  - `android/src/main/AndroidManifest.xml`
  - `android/src/main/kotlin/com/github/quillraven/darkmatter/android/launcher.kt`
  - `core/src/main/kotlin/com/github/quillraven/darkmatter/Game.kt`
  - `core/src/main/kotlin/com/github/quillraven/darkmatter/screen/Screen.kt`
  - `core/src/main/kotlin/com/github/quillraven/darkmatter/screen/LoadingScreen.kt`
  - `core/src/main/kotlin/com/github/quillraven/darkmatter/screen/MenuScreen.kt`
  - `core/src/main/kotlin/com/github/quillraven/darkmatter/screen/GameScreen.kt`
  - `core/src/main/kotlin/com/github/quillraven/darkmatter/event/event.kt`
  - `core/src/main/kotlin/com/github/quillraven/darkmatter/asset/asset.kt`
  - `core/src/main/kotlin/com/github/quillraven/darkmatter/audio/audio.kt`
  - `core/src/main/kotlin/com/github/quillraven/darkmatter/ecs/engine.kt`
  - `core/src/main/kotlin/com/github/quillraven/darkmatter/ecs/component/TransformComponent.kt`
  - `core/src/main/kotlin/com/github/quillraven/darkmatter/ecs/component/PlayerComponent.kt`
  - `core/src/main/kotlin/com/github/quillraven/darkmatter/ecs/component/PowerUpComponent.kt`
  - `core/src/main/kotlin/com/github/quillraven/darkmatter/ecs/component/GraphicComponent.kt`
  - `core/src/main/kotlin/com/github/quillraven/darkmatter/ecs/component/RemoveComponent.kt`
  - `core/src/main/kotlin/com/github/quillraven/darkmatter/ecs/system/MoveSystem.kt`
  - `core/src/main/kotlin/com/github/quillraven/darkmatter/ecs/system/PlayerInputSystem.kt`
  - `core/src/main/kotlin/com/github/quillraven/darkmatter/ecs/system/PowerUpSystem.kt`
  - `core/src/main/kotlin/com/github/quillraven/darkmatter/ecs/system/DamageSystem.kt`
  - `core/src/main/kotlin/com/github/quillraven/darkmatter/ecs/system/RenderSystem.kt`
  - `core/src/main/kotlin/com/github/quillraven/darkmatter/ecs/system/AnimationSystem.kt`
  - `core/src/main/kotlin/com/github/quillraven/darkmatter/ecs/system/AttachSystem.kt`
  - `core/src/main/kotlin/com/github/quillraven/darkmatter/ecs/system/CameraShakeSystem.kt`
  - `core/src/main/kotlin/com/github/quillraven/darkmatter/ecs/system/RemoveSystem.kt`
  - `core/src/main/kotlin/com/github/quillraven/darkmatter/ui/GameUI.kt`
  - `core/src/main/kotlin/com/github/quillraven/darkmatter/ui/MenuUI.kt`
  - `core/src/main/kotlin/com/github/quillraven/darkmatter/ui/skin.kt`

## Build And Runtime Notes

- The repository was investigated through static review plus lightweight Gradle discovery.
- `gradlew.bat --version` succeeds in the lab and confirms Gradle `6.8.1` running on the machine's Java `8` runtime.
- `gradlew.bat help --no-daemon` and `gradlew.bat :core:tasks --all --no-daemon` both fail at `:buildSrc:compileKotlin` because Gradle is using the machine's Java `8` JRE instead of a full JDK with compiler tools:
  - `Kotlin could not find the required JDK tools in the Java installation 'C:\Program Files\Java\jre1.8.0_321'`
- The inspected repository itself still expects the older full-JDK toolchain rather than a newer JVM:
  - Kotlin `1.4.10`
  - Android Gradle Plugin `4.0.2`
  - libGDX `1.9.12`
  - LibKTX `1.9.12-b1`
  - Java target `1.8`
- `.github/workflows/build.yml` confirms upstream CI on `windows-latest` with `actions/setup-java@v1` pinned to Java `8`, running `./gradlew clean build` and `./gradlew detekt` for `core/**` changes on `master`.
- The repository still uses `jcenter()`, so even with a full JDK it should be treated as an older build surface rather than a modern baseline.
- No runtime launch was attempted.

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `3`
- Implementation depth: `2`
- Code clarity: `3`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - this is a compact but coherent direct Android Kotlin game, not just a helper library or toy rendering demo
  - its ECS runtime, interpolation, HUD, and Android/Desktop split are all small enough to study quickly and still rich enough to transfer into future mobile prototypes
  - it is narrower and older than stronger references such as `Quilly-s-Adventure`, but it still clears the bar as a main catalog entry because the code is readable and the gameplay/runtime seams are genuinely reusable

## Interesting Findings

### Engine Architecture And Core Loop

- `core/src/main/kotlin/com/github/quillraven/darkmatter/Game.kt` builds a shared runtime around one lazy `Stage`, async asset loading, one `PooledEngine`, and a hand-assembled system order. The same engine is reused across menu, gameplay, and game-over screens instead of creating separate loops.
- `LoadingScreen.kt` splits startup into two phases: preload only the skin-related assets, build the Scene2D skin in code, then enter a loading screen that pulls the rest of the assets and constructs the remaining screens.
- `Screen.kt` is a clean small-screen shell: it async-loads per-screen music, applies viewport resizing for both game and UI surfaces, and on hide it clears the stage, stops audio, removes all ECS entities, and unloads the screen-specific music asset.
- `MenuScreen.kt` is a useful compact pattern for menu attract mode: it reuses the live ECS runtime to show a moving ship and dark-matter hazard in the background, then toggles the gameplay systems on again only when leaving the menu.

### Rendering And Graphics

- `TransformComponent.kt` implements the render ordering directly through `Comparable`, sorting first by `z` and then by `y`, which keeps the `RenderSystem` simple and makes layering rules visible in the entity data.
- `RenderSystem.kt` combines several small but reusable ideas:
  - scrolling repeated background rendering through a single wrapped `Sprite`
  - background vertical speed reacting to speed-boost pickups
  - entity rendering sorted by transform rather than by insertion order
  - a dedicated outline shader pass that draws only shielded player entities after the normal ECS render
- `AnimationSystem.kt` caches enum-addressed atlas animations once, updates frame state per entity, and immediately seeds new animation entities with their first frame via the entity-listener hook.

### Gameplay Systems

- `ecs/engine.kt` keeps entity creation practical and readable: `createPlayer()` builds the ship plus a second attached exhaust-fire entity, while `createDarkMatter()` spawns the persistent bottom hazard as a normal ECS entity instead of as special renderer state.
- `MoveSystem.kt` is one of the strongest files in the repo. It runs the simulation at a fixed `1/25f` update rate, stores previous positions before each step, interpolates render positions between steps, and emits distance/speed events for HUD updates.
- `PowerUpSystem.kt` uses short spawn-pattern sequences rather than pure randomness, which is a nice small-game pattern for making pickup waves feel intentional without adding heavy level scripting.
- `DamageSystem.kt` turns the bottom dark-matter strip into a real gameplay subsystem: shield absorbs first, block and damage sounds are rate-limited separately, death schedules delayed entity removal, and a one-shot explosion entity is spawned for feedback.
- `RemoveSystem.kt` centralizes delayed cleanup and routes player removal into a `PlayerDeath` event, which keeps death handling out of the movement or damage systems.

### Input And Controls

- `PlayerInputSystem.kt` uses only one control metaphor: horizontal follow of the current pointer position. Because it unprojects against the game viewport, the same code path works for desktop mouse and Android touch.
- `GameScreen.kt` keeps input flow mobile-friendly by gating the actual simulation behind an initial tap, then enabling the pause button only after the player has explicitly begun the run.
- `MenuScreen.kt` and `GameScreen.kt` together show a compact pattern where gameplay controls stay in the shared ECS world, while screen-level buttons and menu actions stay in Scene2D UI code.

### UI, HUD, And Menus

- `GameUI.kt` is a good small Scene2D HUD reference: life is represented by `scaleX`, shield by alpha, the warning overlay flashes through queued actions, and the "touch to begin" prompt is just another reusable pulsing label.
- `ui/skin.kt` is a durable pattern for teams that want to avoid bulky JSON skin definitions: styles are assembled from atlases and fonts in Kotlin code, keeping the skin refactorable and type-visible.
- `MenuUI.kt` keeps the full menu in code, including high-score formatting, multi-button layout, and sound/controls/credits/quit affordances, which makes it easy to compare against Compose-only game shells in the lab.

### Audio

- `audio/audio.kt` has one particularly reusable idea: `DefaultAudioService` coalesces duplicate sound requests inside one frame and plays only the loudest version, which prevents effect spam without a larger audio bus.
- The same service cleanly separates queued effect playback from `currentMusic` ownership, which is enough structure for a small game without forcing the project into a heavier audio abstraction too early.

### Tooling, Android Integration, Or Other Notable Areas

- `asset/asset.kt` centralizes all asset descriptors as enums, which keeps async loading, sound lookup, shader lookup, and bundle access explicit and grep-friendly.
- `android/build.gradle.kts` shares the root `assets/` directory with the Android app, extracts native `.so` files into ABI-specific `libs/` folders during packaging, and keeps the Android shell minimal around the shared `core`.
- `android/src/main/AndroidManifest.xml` and `android/.../launcher.kt` confirm the expected direct Android shape: portrait game activity, immersive mode, hidden status bar, and no extra Android service/app-shell complexity beyond the launcher.

## Reusable Takeaways

- Small Android LibGDX games can stay readable if they treat ECS, UI, and event routing as three narrow layers instead of collapsing everything into one `Screen`.
- Fixed-step movement with interpolated render positions is still one of the most transferable patterns for lightweight mobile action games, even without Box2D.
- A code-defined Scene2D skin plus code-defined HUD/menu layer can remain pleasant to maintain when the scope is intentionally small.
- Patterned power-up spawning is often a better fit for arcade-feeling pickup flow than purely random spawning.

## Evidence Summary

- `Game.kt`, `LoadingScreen.kt`, `Screen.kt`, `MenuScreen.kt`, and `GameScreen.kt` - shared runtime, staged asset load, screen lifecycle, attract-mode menu shell, and gameplay flow
- `event/event.kt` - compact gameplay event bus for spawn, move, hit, block, death, and power-up updates
- `ecs/engine.kt` - ship, exhaust, and dark-matter entity factories
- `MoveSystem.kt`, `PowerUpSystem.kt`, `DamageSystem.kt`, and `RemoveSystem.kt` - fixed-step movement, pickup flow, bottom-hazard damage, and delayed cleanup
- `RenderSystem.kt`, `AnimationSystem.kt`, `AttachSystem.kt`, and `TransformComponent.kt` - sorted rendering, animation caching, attached entities, interpolation, and presentation hooks
- `PlayerInputSystem.kt` - one-path mouse/touch horizontal follow input
- `GameUI.kt`, `MenuUI.kt`, and `ui/skin.kt` - code-driven HUD/menu/skin composition
- `asset/asset.kt`, `android/build.gradle.kts`, `AndroidManifest.xml`, and `launcher.kt` - asset routing, Android packaging, and direct Android launcher shape
- `build.gradle.kts`, `buildSrc/src/main/kotlin/Versions.kt`, `.github/workflows/build.yml`, and the `gradlew help` failure - old but readable build surface plus local JRE-vs-JDK limitation

## Risks Or Limits

- The repository is stale by code activity; the last pushed date at selection was `2023-02-05`, and the latest inspected commit was `Delete trigger` from `2022-12-04`.
- The tooling stack is old: AGP `4.0.2`, Kotlin `1.4.10`, LibGDX `1.9.12`, and `jcenter()`.
- No test files were found in the inspected tree. CI only proves `clean build` plus `detekt`, not gameplay-level regression coverage.
- The game is intentionally narrow: a vertical survival autoscroller with one main control metaphor and a small pickup set, so it complements rather than replaces richer gameplay references.
- Local Gradle discovery in this lab is blocked by the machine using a Java `8` JRE without compiler tools, even though upstream CI indicates the project itself expected a full JDK `8`.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `android-game`
- Focus tags: `2d`, `android`, `libgdx`, `ecs`, `input`, `ui-hud`, `audio`
- Follow-up needed:
  - if the lab revisits this repository, rerun `clean build`, `detekt`, and selected module tasks in a full JDK `8`-compatible environment
  - the most useful narrow revisit targets would be `MoveSystem`, `RenderSystem`, or the code-driven Scene2D HUD/menu layer rather than the whole repository
