# Koishi-Satori/KStg

## Repository Snapshot

- Repository: `Koishi-Satori/KStg`
- Source URL: `https://github.com/Koishi-Satori/KStg`
- Owner: `Koishi-Satori`
- Batch ID: `BATCH-2026-07-10-A`
- Type: `engine-framework`
- License: `Apache-2.0`
- Selection date: `2026-07-10`
- Last pushed at selection: `2023-10-07`
- Stars at selection: `4`
- Investigated commit: `d65d9d962903120683aee3d00ce8c828b470121b`
- Research status: `reference-only`
- Build mode: `static-review + gradle-version + gradle-help + test-dry-run`
- Catalog card: [card](../../catalog/projects/koishi-satori-kstg.md)

## Why This Repository Was Selected

- It was the strongest remaining queued engine wildcard: an Apache-2.0 Kotlin STG engine with explicit bootstrap, object-pool, script-loading, plugin, replay, collision, and Java2D rendering seams.
- It adds a bullet-hell / shoot-em-up engine comparison point to the lab even though its checked-in target is desktop JVM rather than Android.

## Technical Profile

- Main language(s): Kotlin, Java, C++ bootstrapper support
- Engine / framework: custom JVM STG engine
- Rendering stack: Java2D / Swing, optional Java2D OpenGL acceleration flags, `BufferedImage` and `VolatileImage` buffers
- Android target: none found in the checked-in repository
- Build system: Gradle Kotlin DSL, Gradle wrapper `7.1`, Kotlin JVM `1.5.31`, CrashHandler subproject
- Repository layout summary: single Kotlin engine source tree under `src/main/kotlin`, Java `CrashHandler` module, test/sample game code under `src/test/kotlin`, script/assets under `test/`, C++ launcher scaffold under `cpp_bootstrapper/`, plugin jar sample under `plugins/`.
- Key modules reviewed: `boot`, `logic`, `gfx`, `common`, `script`, `audio`, `replay`, `exceptions`, `boot/jvm`, sample tests and stage code.

## Build And Runtime Notes

- The repository was inspected statically first.
- `cmd /c gradlew.bat --version` succeeded and downloaded/used Gradle `7.1` under Java `1.8.0_321`.
- `cmd /c gradlew.bat help --no-daemon` succeeded locally.
- `cmd /c gradlew.bat test --dry-run --no-daemon` succeeded and showed root plus `CrashHandler` test tasks as skipped dry-run tasks.
- Runtime launch was not attempted because the repository is desktop/Swing-oriented, includes bundled sample assets, plugin jars, and an external crash-handler process path; static plus Gradle discovery was sufficient for this batch.

## Usefulness Assessment

- Reuse potential: `2`
- Android transfer: `1`
- Implementation depth: `2`
- Code clarity: `2`
- Novelty: `2`
- Overall verdict: `reference-only`
- Why: the repository contains useful engine-shaping ideas for a small STG runtime, especially bootstrap, resource scripts, object pools, subchunk collision optimization, and replay recording. It is not strong enough for `accepted` because it is stale, desktop-only, has no Android host, and visible code defects make it better as a comparison reference than as a main architecture baseline.

## Interesting Findings

### Engine Architecture And Core Loop

- `src/main/kotlin/top/kkoishi/stg/boot/Bootstrapper.kt` is a fluent startup facade that loads definition loaders, configures a `JFrame`, attaches key binds, handles fullscreen/scale/VRAM settings, runs an `initMethod`, then starts `InfoSystem`, `Renderer`, `GameLoop`, and `AudioPlayer`.
- `src/main/kotlin/top/kkoishi/stg/logic/Threads.kt` centralizes periodic scheduling through `ScheduledThreadPoolExecutor.scheduleAtFixedRate`, with a default `16ms` period and named threads. This is a simple but transferable model for separating logic, rendering, info, and audio tasks.
- `src/main/kotlin/top/kkoishi/stg/logic/GameLoop.kt` switches behavior by `GenericSystem.gameState`, updating player, stage actions, UI, objects, bullets, subchunk indexes, key binds, and delayed tasks in a predictable order.
- `src/main/kotlin/top/kkoishi/stg/logic/ObjectPool.kt` keeps separate pools for loading content, UI objects, player, bullets, and other objects while maintaining a UUID lookup map. The pool exposes snapshot iterators to avoid direct concurrent mutation during iteration.

### Rendering And Graphics

- `src/main/kotlin/top/kkoishi/stg/gfx/Renderer.kt` renders by game state into an offscreen buffer, then paints that buffer to the Swing container with optional scaling or fullscreen transforms.
- `src/main/kotlin/top/kkoishi/stg/gfx/Graphics.kt` owns global graphics state: frame insets, UI insets, screen center, rendering hints, fonts, a `BufferedImage` buffer, and a compatible `VolatileImage` VRAM buffer.
- `src/main/kotlin/top/kkoishi/stg/gfx/Texture.kt` caches texture operations such as normal draw, rotation transforms, convolution effects, and VRAM-backed texture variants. The idea is reusable for sprite-heavy Android games, but the concrete Java2D implementation is not portable as-is.
- `src/main/kotlin/top/kkoishi/stg/script/GFXLoader.kt` loads sprite sheets through a small resource script language with `gfx`, `shear`, `loop`, `font`, and `shear_font` instructions, including deferred resolution when a texture depends on another texture loaded later.

### Gameplay Systems

- `src/main/kotlin/top/kkoishi/stg/common/Stage.kt`, `AbstractStage.kt`, and `StageAction.kt` model stage progression as an ordered queue of frame-delayed actions. The sample `src/test/kotlin/top/kkoishi/stg/test/common/stages/Stage1.kt` uses this to schedule music changes, enemy waves, boss/dialog insertion, clear screen objects, and replay saving.
- `src/main/kotlin/top/kkoishi/stg/common/entities/Entity.kt` and `src/main/kotlin/top/kkoishi/stg/common/entities/Object.kt` keep the game-object contract very small: update, collision, paint, UUID, and shape for entities. This is simple enough to port, but less flexible than the lab's stronger ECS references.

### Input And Controls

- `src/main/kotlin/top/kkoishi/stg/logic/keys/KeyBinds.kt` stores global key state in a boolean array, supports object-bound and generic key events, and allows temporary input barriers.
- `src/test/kotlin/top/kkoishi/stg/test/Test.kt` demonstrates binding pause/resume to player key events and binding F11 screenshots through a generic key event.
- `src/main/kotlin/top/kkoishi/stg/replay/ReplayPlayer.kt` reuses key barriers and forced key states for replay playback, but playback still contains a `TODO("finish this.")`, so only the input-barrier idea is reusable today.

### UI, HUD, And Menus

- `src/main/kotlin/top/kkoishi/stg/common/ui/*` provides menu/sidebar base classes that are rendered from the same object pool as game UI.
- `src/test/kotlin/top/kkoishi/stg/test/common/ui/MainMenu.kt`, `PauseMenu.kt`, and `GameSideBar.kt` show a small menu/HUD layer built from engine objects rather than a separate UI framework.

### Physics And Collision

- `src/main/kotlin/top/kkoishi/stg/gfx/CollideSystem.kt` supports rectangle, circle, and convex polygon collision checks with a rough bounds pretest and optional user-registered shape handlers.
- `src/main/kotlin/top/kkoishi/stg/gfx/Polygons.kt` includes SAT and GJK-style convex polygon intersection paths, making it a useful small-engine comparison point.
- `src/main/kotlin/top/kkoishi/stg/logic/coordinatespace/SubChunks.kt` partitions the playfield into a 2D mesh of UUID sets and lets player collision tests skip bullets outside the player's occupied subchunks. This is the most transferable performance idea in the repository.
- Important caveat: `CollideSystem.circleIntersectCircle` currently returns `distance >= r`, which appears inverted for ordinary circle collision. Treat this file as a source of ideas, not copy-ready collision code.

### Tooling, Android Integration, Or Other Notable Areas

- `src/main/kotlin/top/kkoishi/stg/script/AudioLoader.kt`, `Sounds.kt`, and `AudioPlayer.kt` define script-driven audio loading plus a simple scheduled clip queue and background music loop.
- `src/main/kotlin/top/kkoishi/stg/boot/jvm/KStgEngineMain.kt`, `PluginClassLoader.kt`, and `JvmPlugin.kt` implement plugin discovery from jars, interface checks, optional main-plugin selection, and fallback instance allocation. This is interesting for desktop tooling but should be treated carefully because it can use `Unsafe` allocation.
- `src/main/kotlin/top/kkoishi/stg/replay/ReplayRecorder.kt` records selected key states, FPS, and player coordinates into a temp binary file, then saves a compressed replay. This is useful as a compact replay-recording pattern, but replay playback is incomplete.
- `src/main/kotlin/top/kkoishi/stg/exceptions/ThreadExceptionHandler.kt` and the `CrashHandler` Java module show a separate watchdog/crash-report process model. It is more relevant to desktop tools than Android games.
- `src/main/kotlin/top/kkoishi/stg/script/execution/VM.kt` contains a small variable VM for resource scripts, but its division operator implementation currently performs addition, so the script VM must not be copied without fixes.

## Reusable Takeaways

- A fluent bootstrapper can keep game setup readable if it only wires platform host, loaders, input, and thread startup.
- For bullet-heavy games, a simple subchunk grid can reduce collision checks enough to be worth prototyping before adopting a heavier spatial index.
- Resource definition scripts can be useful for sprite-sheet slicing and audio registration, especially when paired with deferred reference resolution.
- Replay recording can start with deterministic seed, selected key bits, player position, and frame timing before attempting full entity snapshots.
- Keep desktop plugin/crash-handler ideas separate from Android runtime code; they are useful for tools, not mobile gameplay surfaces.

## Evidence Summary

- `src/main/kotlin/top/kkoishi/stg/boot/Bootstrapper.kt` - startup facade and platform host wiring
- `src/main/kotlin/top/kkoishi/stg/logic/Threads.kt` - scheduled thread-pool runtime
- `src/main/kotlin/top/kkoishi/stg/logic/GameLoop.kt` - state-driven gameplay loop
- `src/main/kotlin/top/kkoishi/stg/logic/ObjectPool.kt` - pooled object ownership
- `src/main/kotlin/top/kkoishi/stg/gfx/Renderer.kt` - buffer-based Java2D renderer
- `src/main/kotlin/top/kkoishi/stg/gfx/Graphics.kt` - global graphics buffers/insets/fonts
- `src/main/kotlin/top/kkoishi/stg/gfx/CollideSystem.kt` - shape collision entry point
- `src/main/kotlin/top/kkoishi/stg/logic/coordinatespace/SubChunks.kt` - mesh-based bullet collision optimization
- `src/main/kotlin/top/kkoishi/stg/script/GFXLoader.kt` - texture script loader
- `src/main/kotlin/top/kkoishi/stg/script/AudioLoader.kt` - audio script loader
- `src/main/kotlin/top/kkoishi/stg/replay/ReplayRecorder.kt` - replay serialization
- `src/main/kotlin/top/kkoishi/stg/boot/jvm/KStgEngineMain.kt` - plugin jar runtime
- `src/test/kotlin/top/kkoishi/stg/test/Test.kt` - sample game bootstrap
- `src/test/kotlin/top/kkoishi/stg/test/common/stages/Stage1.kt` - sample stage scripting

## Risks Or Limits

- No Android target or mobile host was found.
- The repository appears stale: last push at selection was `2023-10-07`.
- Some README text is mojibake in the Windows console, although the English sections were readable enough to verify intent.
- Several areas are not production-ready: replay playback is unfinished, script division is wrong, and circle-circle collision appears inverted.
- The runtime uses global singletons and desktop AWT/Swing state, which would need substantial redesign before Android reuse.
- Test surface exists, but much of the checked-in `src/test` tree is sample/demo code rather than assertive regression coverage.

## Catalog Decision

- Keep in main catalog: `yes, as reference-only`
- Primary category: `reference-only`
- Focus tags: `2d`, `input`, `collision`, `audio`, `asset-pipeline`
- Follow-up needed: only if future work needs a narrow STG-engine pass around subchunk collision, resource scripts, replay recording, or Java2D-to-Android rendering adaptation.
