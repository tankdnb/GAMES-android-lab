# Research Note

## Repository Snapshot

- Repository: `fredboy/cavedroid`
- Source URL: [https://github.com/fredboy/cavedroid](https://github.com/fredboy/cavedroid)
- Owner: `fredboy`
- Batch ID: [`BATCH-2026-05-11-G`](../batches/BATCH-2026-05-11-G.md)
- Type: `android-game`
- License: `MIT`
- Selection date: `2026-05-11`
- Last pushed at selection: `2026-05-08`
- Stars at selection: `13`
- Investigated commit: `68d22d2b66341f0ea354f03b5381b3ee3ed26665`
- Research status: `accepted`
- Build mode: `static-review + gradle-help-failed-java8-needs-java17`
- Catalog card: [catalog/projects/fredboy-cavedroid.md](../../catalog/projects/fredboy-cavedroid.md)

## Why This Repository Was Selected

- It was the strongest fresh direct-Android Kotlin candidate in the refreshed shortlist once already-researched repositories and low-signal noise were excluded.
- The repository combines direct Android relevance, permissive MIT licensing, recent maintenance, and a much denser systems surface than a typical small mobile sample.
- The wrapped-world runtime, procedural generation, save pipeline, touch controls, and Android/Desktop split made it a good test of whether the lab could find a compact but still high-yield sandbox architecture.

## Technical Profile

- Main language(s): Kotlin, Java
- Engine / framework: LibGDX + Box2D + Box2DLights + Dagger
- Rendering stack: LibGDX `SpriteBatch`/`ShapeRenderer`, chunk frame buffers, dual cameras, and Box2DLights
- Android target: direct Android app, with desktop support and an untested iOS target also present in the workspace
- Build system: multi-module Gradle Kotlin DSL monorepo
- Repository layout summary: `android/`, `desktop/`, `ios/`, `assets/`, `fastlane/`, `buildSrc/`, and a heavily split `core/` tree for common, data, domain, entity, game, gameplay, and gdx-specific modules
- Source footprint:
  - total files reviewed in repository: `1023`
  - Kotlin/Java files reviewed across the repository: `495`
- Test surface:
  - unit-test files found: `5`
- Key modules reviewed:
  - `README.md`
  - `LICENSE`
  - `build.gradle.kts`
  - `settings.gradle.kts`
  - `gradle/wrapper/gradle-wrapper.properties`
  - `android/build.gradle.kts`
  - `android/src/main/AndroidManifest.xml`
  - `android/src/main/kotlin/ru/fredboy/cavedroid/AndroidLauncher.kt`
  - `desktop/build.gradle.kts`
  - `core/common/src/main/kotlin/ru/fredboy/cavedroid/common/model/StartGameConfig.kt`
  - `core/common/src/main/kotlin/ru/fredboy/cavedroid/common/utils/WorldEdgeMirror.kt`
  - `core/common/src/test/kotlin/ru/fredboy/cavedroid/common/utils/WorldEdgeMirrorTest.kt`
  - `core/data/save/src/main/kotlin/ru/fredboy/cavedroid/data/save/repository/SaveDataRepositoryImpl.kt`
  - `core/gdx/src/main/kotlin/ru/fredboy/cavedroid/gdx/game/GameScreen.kt`
  - `core/gdx/src/main/java/ru/fredboy/cavedroid/gdx/game/GameProc.java`
  - `core/game/world/src/main/kotlin/ru/fredboy/cavedroid/game/world/GameWorld.kt`
  - `core/game/world/src/main/kotlin/ru/fredboy/cavedroid/game/world/generator/GameWorldGenerator.kt`
  - `core/game/window/src/main/kotlin/ru/fredboy/cavedroid/game/window/GameWindowsManager.kt`
  - `core/game/window/src/main/kotlin/ru/fredboy/cavedroid/game/window/inventory/AbstractInventoryWindow.kt`
  - `core/game/controller/mob/src/main/kotlin/ru/fredboy/cavedroid/game/controller/mob/MobController.kt`
  - `core/game/controller/projectile/src/main/kotlin/ru/fredboy/cavedroid/game/controller/projectile/ProjectileController.kt`
  - `core/gameplay/controls/src/main/kotlin/ru/fredboy/cavedroid/gameplay/controls/input/handler/touch/JoystickInputHandler.kt`
  - `core/gameplay/physics/src/main/kotlin/ru/fredboy/cavedroid/gameplay/physics/impl/ChunkedGameWorldSolidBlockBodiesManagerImpl.kt`
  - `core/gameplay/physics/src/main/kotlin/ru/fredboy/cavedroid/gameplay/physics/task/GameWorldBlocksLogicControllerTask.kt`
  - `core/gameplay/physics/src/main/kotlin/ru/fredboy/cavedroid/gameplay/physics/task/GameWorldFluidsLogicControllerTask.kt`
  - `core/gameplay/physics/src/main/kotlin/ru/fredboy/cavedroid/gameplay/physics/task/GameWorldMobSpawnControllerTask.kt`
  - `core/gameplay/rendering/src/main/kotlin/ru/fredboy/cavedroid/gameplay/rendering/GameRenderer.kt`
  - `core/gameplay/rendering/src/main/kotlin/ru/fredboy/cavedroid/gameplay/rendering/renderer/world/BlocksRenderer.kt`
  - `core/gameplay/rendering/src/main/kotlin/ru/fredboy/cavedroid/gameplay/rendering/renderer/world/BackgroundBlocksRenderer.kt`
  - `core/gameplay/rendering/src/main/kotlin/ru/fredboy/cavedroid/gameplay/rendering/renderer/hud/TouchControlsRenderer.kt`
  - `core/gameplay/rendering/src/main/kotlin/ru/fredboy/cavedroid/gameplay/rendering/renderer/hud/WindowsRenderer.kt`
  - `core/gameplay/rendering/src/main/kotlin/ru/fredboy/cavedroid/gameplay/rendering/renderer/hud/onboarding/OnboardingController.kt`
  - `core/gameplay/rendering/src/test/kotlin/ru/fredboy/cavedroid/gameplay/rendering/renderer/hud/onboarding/OnboardingControllerTest.kt`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `java -version` on the lab machine still reports `1.8.0_321`.
- `cmd /c gradlew.bat --version` succeeds and reports Gradle `9.0.0`, but it also confirms that the current launcher JVM is still Java `8`.
- `cmd /c gradlew.bat help --no-daemon` fails before project configuration because Gradle `9.0.0` requires JVM `17+`, while the current lab environment remains on Java `8`.
- The checked-in build scripts match that failure shape: root `build.gradle.kts` configures Java/Kotlin toolchain `17`, and `android/build.gradle.kts` targets `compileSdk 36` / `targetSdk 36`.
- `README.md` additionally warns that Windows desktop builds need asset-directory symlink adjustments even when the right JDK is available.
- No runtime launch was attempted.
- Known setup limitations:
  - local build verification in this lab is blocked by the JDK floor
  - Windows desktop packaging also has an asset-symlink caveat
  - external repository code remained static-review-only by design

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `3`
- Implementation depth: `3`
- Code clarity: `2`
- Novelty: `3`
- Overall verdict: `accepted`
- Why:
  - the repository is directly relevant to Android game development because it is a real Android-first LibGDX game rather than a desktop-only engine or toy prototype
  - it contains several durable systems worth reusing together: wrapped-world runtime rules, seam-safe rendering/physics mirroring, chunk-local invalidation, procedural terrain/cave generation, touch control-mode switching, and a compact but rich save format
  - the codebase is larger and denser than a minimal sample, but the subsystem boundaries are still readable enough to extract reusable patterns

## Interesting Findings

### Engine Architecture And Core Loop

- `core/common/src/main/kotlin/ru/fredboy/cavedroid/common/model/StartGameConfig.kt` and `core/gdx/src/main/kotlin/ru/fredboy/cavedroid/gdx/game/GameScreen.kt` split new-vs-load startup into typed configs, then build a per-game Dagger component with its own `GameContext`, joystick state, and camera rectangles. This is a clean way to isolate one running world/session from the application shell.
- `core/gdx/src/main/java/ru/fredboy/cavedroid/gdx/game/GameProc.java` is the real runtime coordinator. It schedules fluids, block logic, environmental mob damage, and mob spawning as separate timer tasks, while the frame loop only updates world physics, mobs, drops, projectiles, input, rendering, containers, and weather audio. That split keeps long-lived world simulation logic out of the immediate render tick.
- `core/game/world/src/main/kotlin/ru/fredboy/cavedroid/game/world/GameWorld.kt` centralizes horizontally wrapped block access through `transformX`, owns day/night time, moon phases, weather transitions, and steps Box2D through a fixed `1f / 60f` accumulator instead of using a variable-step physics loop.

### Rendering And Graphics

- `core/gameplay/rendering/src/main/kotlin/ru/fredboy/cavedroid/gameplay/rendering/GameRenderer.kt` sorts world and HUD renderer sets by layer, keeps separate world-meter and HUD-pixel cameras, optionally blends camera targeting between player and cursor, darkens the sky by weather intensity, and forces a `rayHandler.update()` when the wrapped world causes a camera seam jump. That last piece is especially reusable for looped-world lighting.
- `core/gameplay/rendering/src/main/kotlin/ru/fredboy/cavedroid/gameplay/rendering/renderer/world/BlocksRenderer.kt` and `.../BackgroundBlocksRenderer.kt` cache chunk frame buffers instead of redrawing the full tile field every frame, split background shading from actual block sprites, and support neighbor-attached decorative blocks through rotation/origin-aware sprite drawing.
- `core/common/src/main/kotlin/ru/fredboy/cavedroid/common/utils/WorldEdgeMirror.kt` plus `core/common/src/test/kotlin/ru/fredboy/cavedroid/common/utils/WorldEdgeMirrorTest.kt` capture the seam-mirroring rules explicitly. The helpers clamp the mirror band, compute which edge chunks need mirror copies, and test wrapped-range checks so rendering and physics can stay consistent at the horizontal seam.

### Gameplay Systems

- `core/game/world/src/main/kotlin/ru/fredboy/cavedroid/game/world/generator/GameWorldGenerator.kt` uses periodic 1D fractal noise for surface heights, biome segments across the world width, biome-specific surface dressing, randomized ore veins, cellular-automata cave carving, plus water and lava fill passes. It is a compact but layered reference for 2D sandbox worldgen.
- `core/gameplay/physics/src/main/kotlin/ru/fredboy/cavedroid/gameplay/physics/task/GameWorldBlocksLogicControllerTask.kt` listens to block placement/destruction, marks only the affected chunk and its border neighbors dirty, and then updates fall/require-support logic chunk-by-chunk. This is a strong pattern for keeping tile logic incremental instead of rescanning the whole world.
- `core/gameplay/physics/src/main/kotlin/ru/fredboy/cavedroid/gameplay/physics/task/GameWorldFluidsLogicControllerTask.kt` limits fluid simulation to the player's nearby area, uses a priority queue for updates, and turns water/lava interactions into explicit stone/obsidian/cobblestone transformations. That scope-limiting is directly relevant for mobile sandbox performance.
- `core/gameplay/physics/src/main/kotlin/ru/fredboy/cavedroid/gameplay/physics/task/GameWorldMobSpawnControllerTask.kt` keeps mob spawning chunk-based and time-of-day-aware, using `64`-block lanes across world width rather than trying to spawn globally or only on-screen.
- `core/game/controller/mob/src/main/kotlin/ru/fredboy/cavedroid/game/controller/mob/MobController.kt` separates queued mob spawns from active update, drops inventory/armor on player death, and keeps audio side effects beside entity updates instead of scattering them through individual mob classes.
- `core/game/controller/projectile/src/main/kotlin/ru/fredboy/cavedroid/game/controller/projectile/ProjectileController.kt` is intentionally small but reusable: it spawns item-backed projectiles into Box2D, updates them centrally, and optionally turns dead projectiles back into world drops.

### Input And Controls

- `core/gameplay/controls/src/main/kotlin/ru/fredboy/cavedroid/gameplay/controls/input/handler/touch/JoystickInputHandler.kt` implements a good mobile touch pattern for sandbox games: the left screen half owns a joystick, short release becomes jump or creative-flight activation, drags map to velocity, and the player switches cleanly between `WALK` and `CURSOR` control modes.
- The same file explicitly excludes touches inside the hotbar bounds, which prevents the most obvious UI/gameplay input conflict without needing a separate overlay input subsystem.
- `core/gameplay/rendering/src/main/kotlin/ru/fredboy/cavedroid/gameplay/rendering/renderer/hud/TouchControlsRenderer.kt` draws touch buttons only when the app is on a touch device and no inventory window is open, which keeps mobile HUD layers decoupled from the actual input handlers.

### UI, HUD, And Menus

- `core/game/window/src/main/kotlin/ru/fredboy/cavedroid/game/window/GameWindowsManager.kt` keeps all inventory-like window state in one manager and drops leftover craft-grid items into the world on close instead of silently deleting them.
- `core/game/window/src/main/kotlin/ru/fredboy/cavedroid/game/window/inventory/AbstractInventoryWindow.kt` implements practical stack merge/split behavior plus pointer ownership for selected items, which is useful when mobile inventory interactions can involve more than one touch pointer.
- `core/gameplay/rendering/src/main/kotlin/ru/fredboy/cavedroid/gameplay/rendering/renderer/hud/WindowsRenderer.kt` routes actual rendering by typed window kind instead of letting each window own its own draw loop.
- `core/gameplay/rendering/src/main/kotlin/ru/fredboy/cavedroid/gameplay/rendering/renderer/hud/onboarding/OnboardingController.kt` adapts tutorial steps between touch and keyboard/mouse, persists the "already shown" flag, and keeps progression state separate from the renderer. `.../OnboardingControllerTest.kt` verifies branch-specific flow such as skipping aim on keyboard or requiring the correct inventory window type.

### Physics And Collision

- `core/gameplay/physics/src/main/kotlin/ru/fredboy/cavedroid/gameplay/physics/impl/ChunkedGameWorldSolidBlockBodiesManagerImpl.kt` is one of the strongest findings in the repository. It rebuilds static collision bodies per `16x16` chunk, merges neighboring solid tiles by block type, traces the cluster outline into Box2D `ChainShape`s, and mirrors edge chunks near the seam so physics and shadows still work in a horizontally looped world.
- `core/game/world/src/main/kotlin/ru/fredboy/cavedroid/game/world/GameWorld.kt` keeps world stepping fixed-step, which makes the chunked collider and entity systems more predictable than a naive variable-step Box2D setup.
- `core/common/src/test/kotlin/ru/fredboy/cavedroid/common/utils/WorldEdgeMirrorTest.kt` materially improves trust in the wrapped-world implementation because it covers clamping, side selection, and wrap-range behavior for tiny and normal world widths.

### Persistence And Save/Load

- `core/data/save/src/main/kotlin/ru/fredboy/cavedroid/data/save/repository/SaveDataRepositoryImpl.kt` uses a hybrid save strategy that is unusually practical for a tile sandbox:
  - block dictionaries plus custom run-length encoding for foreground/background maps
  - GZIP wrapping for block maps and biome strips
  - ProtoBuf DTOs for meta, mobs, drops, containers, and projectiles
  - auto-generated save-slot screenshots for preview UX
- The same class also version-tags the map format and separates map data from runtime-controller snapshots, which makes it a strong reference for evolving save formats without serializing an entire game session as one giant object graph.

### Tooling, Android Integration, Or Other Notable Areas

- `android/src/main/kotlin/ru/fredboy/cavedroid/AndroidLauncher.kt` keeps Android glue thin: it boots a LibGDX `AndroidApplication`, uses immersive mode, disables back navigation, resolves the app data directory once, and injects an Android-specific preferences store into the shared game application.
- `android/src/main/AndroidManifest.xml` confirms a single landscape launcher activity with no additional Android service surface, which makes the Android target straightforward to reason about.
- `android/build.gradle.kts` shows stronger-than-average Android release hygiene for a small game repo: `compileSdk 36`, `minSdk 23`, `foss` and `store` distribution flavors, manual native `.so` extraction into `jniLibs`, copied third-party notices, generated asset-attribution indexes, and Google Services / Crashlytics explicitly disabled on `foss` variants.
- `desktop/build.gradle.kts` also makes the desktop side worth noting: runnable debug/touch tasks, ProGuard shrinking, signed-jar generation, and `construo` packaging targets are all present, which helps explain why the repository feels more product-like than a simple jam prototype.

## Reusable Takeaways

- If a 2D world wraps horizontally, treat seam handling as a first-class systems problem across rendering, lights, and physics rather than as a camera-only trick.
- Chunk-local invalidation, collider rebuilding, and framebuffer caching are strong mobile-friendly patterns for tile sandbox games.
- A hybrid save format is often better than a single serializer strategy: tile maps, metadata, entity controllers, and UI previews have different storage needs.
- Touch controls for sandbox games benefit from explicit cursor-vs-movement modes instead of assuming one direct-manipulation scheme for every action.
- Tutorial/onboarding state deserves its own controller plus tests when input schemes differ between touch and keyboard.

## Evidence Summary

- `GameScreen.kt`, `StartGameConfig.kt` - per-session bootstrap and game-context assembly
- `GameProc.java` - split timer-driven world logic vs frame-driven update loop
- `GameWorld.kt` - wrapped world access, time/weather, fixed-step Box2D
- `GameWorldGenerator.kt` - terrain, biome, cave, ore, and fluid generation
- `GameRenderer.kt` - dual-camera rendering, seam-aware light updates, HUD/world split
- `BlocksRenderer.kt`, `BackgroundBlocksRenderer.kt` - chunk frame buffers and layered tile rendering
- `JoystickInputHandler.kt`, `TouchControlsRenderer.kt` - touch movement, cursor mode, and HUD control overlays
- `GameWindowsManager.kt`, `AbstractInventoryWindow.kt`, `OnboardingController.kt` - inventory UX and onboarding flow
- `ChunkedGameWorldSolidBlockBodiesManagerImpl.kt`, `WorldEdgeMirror.kt`, `WorldEdgeMirrorTest.kt` - seam-safe chunk collision and tested wrap helpers
- `SaveDataRepositoryImpl.kt` - hybrid save pipeline with RLE, GZIP, ProtoBuf, and slot screenshots
- `android/build.gradle.kts`, `AndroidLauncher.kt`, `AndroidManifest.xml` - Android packaging, launcher shell, and product-flavor setup
- `desktop/build.gradle.kts` - desktop packaging and release tasks

## Risks Or Limits

- The repository has low popularity signal at selection time, so its patterns are valuable mainly by code quality and direct fit rather than by broad ecosystem adoption.
- The lab did not run real tests or builds beyond lightweight Gradle discovery because the current machine still exposes only Java `8`.
- The build now requires JDK `17+`, and Windows desktop builds also carry an asset-symlink caveat called out by upstream `README.md`.
- The codebase is large, split across many modules, and still mixes Kotlin and Java, so it is a reference source rather than something to wholesale copy into a new game.
- iOS support exists in the repository layout but is explicitly untested in upstream documentation.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `android-game`
- Focus tags: `2d`, `android`, `libgdx`, `physics`, `input`, `save-load`, `procedural-generation`, `ui-hud`
- Follow-up needed:
  - if the lab revisits this repository later, rerun lightweight build/test discovery in a real JDK `17+` environment and consider a narrower deep dive into either seam-safe wrapped-world infrastructure or the save pipeline
