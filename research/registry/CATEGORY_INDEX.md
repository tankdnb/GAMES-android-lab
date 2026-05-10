# Category Index

Use this file to group reusable findings across multiple repositories.

This is not the accepted-project catalog. For accepted project cards grouped by normalized catalog categories, use `catalog/CATEGORY_INDEX.md`.

## Engine Architecture And Core Loop

- [antimine-android](../findings/lucasnlm-antimine-android.md) - game flow is isolated in `GameController`, with minefield creation split into pure Kotlin and native-backed generators.
- [korge](../findings/korlibs-korge.md) - `SceneContainer` and `Stage` show a reusable scene-graph runtime with transitions, history, and dependency injection.
- [godot-kotlin-jvm](../findings/utopia-rise-godot-kotlin-jvm.md) - `Bootstrap` and the native bridge show a full Kotlin-to-engine startup and registration chain.
- [littlektframework-littlekt](../findings/littlektframework-littlekt.md) - `Context` and `LwjglContext` show a callback-driven runtime around a WebGPU-first frame loop.
- [pandulapeter-kubriko](../findings/pandulapeter-kubriko.md) - `Kubriko` and `InternalViewport` show a Compose-embedded manager runtime with lifecycle-aware ticking.
- [retrowars-retrowars](../findings/retrowars-retrowars.md) - `RetrowarsGame`, `GameScreen`, and `Games` show a shared shell for several minigames.
- [almasb-fxgl](../findings/almasb-fxgl.md) - `EngineService` is a strong reference for a service-oriented engine lifecycle.
- [unciv](../findings/yairm210-unciv.md) - `UncivGame` and `WorldScreen` show how to split heavy loading and turn-resolution work across background threads and the GL thread in a large Android game.
- [candy-crush-clone](../findings/tobsef-candy-crush-clone.md) - `main.kt` and `GameFlow` show a compact DI-composed match-3 runtime driven by typed events and animation-completion sequencing.
- [remsengine](../findings/antonionoack-remsengine.md) - `EngineBase`, `WindowManagement`, `RemsEngine`, and `OfficialExtensions` show an editor-first engine lifecycle with extension-loaded modules and split window/render loops.
- [minigdx-tiny](../findings/minigdx-tiny.md) - `GameEngine`, `GameResourceProcessor`, `GameResourceCollector`, and `GameScript` show a fixed-step KMP runtime with ordered resource bootstrapping, state-preserving Lua hot reload, and script-to-script transitions.
- [curioustorvald-terrarum](../findings/curioustorvald-terrarum.md) - `App`, `CommonResourcePool`, `ModMgr`, `IngameInstance`, and `GameUpdateGovernor` show background module bootstrapping with explicit GL-thread handoff, PRTree-backed actor queries, and fixed-step update governance.
- [hugobros3-chunkstories](../findings/hugobros3-chunkstories.md) - `ClientImplementation`, `IngameClientImplementation`, `TickingThread`, `WorldImplementation`, and `AutoRebuildingProperty` show a split render/simulation runtime, 60 TPS logic loop, player-near chunk ticking, and task-driven rebuilds for expensive derived world data.

## Rendering And Graphics

- [antimine-android](../findings/lucasnlm-antimine-android.md) - `MinefieldStage` and `AreaActor` show a LibGDX surface embedded into an Android game with custom cell composition.
- [korge](../findings/korlibs-korge.md) - `GameWindow` and Android-specific window implementations show how KorGE abstracts platform rendering surfaces.
- [littlektframework-littlekt](../findings/littlektframework-littlekt.md) - WebGPU backend setup and `MutableTextureAtlas` show a clean render boundary plus runtime atlas generation.
- [pandulapeter-kubriko](../findings/pandulapeter-kubriko.md) - `InternalViewport` and `ActorManagerImpl` tie rendering to Compose sizing, scaling, and visible-actor filtering.
- [retrowars-retrowars](../findings/retrowars-retrowars.md) - `GameViewport` reserves HUD space inside the game viewport instead of assuming full-screen world rendering.
- [candy-crush-clone](../findings/tobsef-candy-crush-clone.md) - `GameFieldRenderer` and `TileAnimator` keep a mirrored tile-image grid synchronized with command-driven board animation.
- [remsengine](../findings/antonionoack-remsengine.md) - `RenderGraph` and `WindowManagement` show graph-driven rendering plus explicit multi-window OpenGL orchestration and idle pacing.
- [minigdx-tiny](../findings/minigdx-tiny.md) - `DefaultVirtualFrameBuffer` and `SprLib` show a palette-index 2D framebuffer with texture batching, stencil modes, cached readback, and runtime sprite-sheet mutation.
- [curioustorvald-terrarum](../findings/curioustorvald-terrarum.md) - `IngameRenderer`, `LightmapRenderer`, `WeatherMixer`, `WorldCamera`, and `AssembledSpriteAnimation` show multi-FBO 2D compositing, RGB+UV tiled lighting, weather-driven sky rendering, wraparound camera sampling, and equipment-aware skeletal sprite assembly.
- [hugobros3-chunkstories](../findings/hugobros3-chunkstories.md) - `GraphicsEngineImplementation`, `GraphicsBackendsEnum`, `deffered_world_render_graph`, `BuiltInRendergraphs`, `TaskCreateChunkMesh`, and `TaskComputeChunkOcclusion` show backend-neutral pass graphs, Vulkan/OpenGL fallback, async chunk meshing with AO/light packing, and precomputed chunk-face visibility.

## Gameplay Systems

- [antimine-android](../findings/lucasnlm-antimine-android.md) - no-guess generation, solver-backed validation, and board sizing logic are directly reusable gameplay-system patterns.
- [retrowars-retrowars](../findings/retrowars-retrowars.md) - the minigame registry and compact per-game state holders are useful for multi-mode or multi-game products.
- [unciv](../findings/yairm210-unciv.md) - `GameStarter`, `GameInfo.nextTurn`, and the built-in simulation harness show a full-scale turn-based gameplay pipeline with generation, save-state restoration, and multi-actor turn processing.
- [candy-crush-clone](../findings/tobsef-candy-crush-clone.md) - `GameMechanics`, `Level`, `LevelCheck`, and `Scoring` separate board rules, scripted reserve tiles, goals, and combo scoring in a reusable puzzle-game shape.
- [remsengine](../findings/antonionoack-remsengine.md) - `Entity`, `Systems`, and the sample games under `test/src/me/anno/games/` show how gameplay scenarios are built on top of a scene hierarchy plus runtime systems bridge.
- [minigdx-tiny](../findings/minigdx-tiny.md) - `MapLib` turns LDtk levels, layers, flags, and custom fields into Lua-facing runtime data, while `TinyLib` plus boot/game scripts provide a lightweight multi-script scene flow.
- [curioustorvald-terrarum](../findings/curioustorvald-terrarum.md) - `WorldSimulator` and `worldgenerator/*` show localized environmental simulation, graph-based wire propagation, and staged terrain/cave/aquifer/ore/biome/tree generation with versioned parameters.
- [hugobros3-chunkstories](../findings/hugobros3-chunkstories.md) - `ChunkImplementation`, `WorldImplementation`, `WorldMasterImplementation.tick()`, and `TaskGenerateWorldSlice` show chunk-local world state, cadence-based near-player physics work, and staged wave-based slice generation.

## Input And Controls

- [korge](../findings/korlibs-korge.md) - input and lifecycle hooks are centralized through `Stage` and `GameWindow`, which is useful for Android host integration.
- [littlektframework-littlekt](../findings/littlektframework-littlekt.md) - `InputMapController` unifies keyboard, pointer, and gamepad input into custom game signals.
- [pandulapeter-kubriko](../findings/pandulapeter-kubriko.md) - `PointerInputManagerImpl` normalizes embedded viewport coordinates and dispatches drag/zoom/pointer callbacks.
- [retrowars-retrowars](../findings/retrowars-retrowars.md) - `SoftController` shows declarative on-screen controller layouts with optional gesture-only modes.
- [almasb-fxgl](../findings/almasb-fxgl.md) - `Input`, `VirtualInput`, and `InputCapture` provide centralized bindings, touch overlays, and replayable input sequences.
- [candy-crush-clone](../findings/tobsef-candy-crush-clone.md) - `DragListener` and `MoveTileObserver` translate raw drags into adjacent grid-cell swap commands before gameplay logic runs.
- [remsengine](../findings/antonionoack-remsengine.md) - `JVMExtension` keeps controller polling and JVM-only input/platform glue inside an extension layer instead of polluting core runtime code.
- [minigdx-tiny](../findings/minigdx-tiny.md) - `LwjglInput`, `TouchManager`, and `GameOptions` normalize desktop input into virtual touch/key state and even support debugger-driven remote key injection.

## UI, HUD, And Menus

- [antimine-android](../findings/lucasnlm-antimine-android.md) - the LibGDX stage and actor layering demonstrate a custom in-game board UI inside a standard Android app shell.
- [ktx](../findings/libktx-ktx.md) - the Scene2D DSL is a strong pattern for reducing UI boilerplate in Kotlin game UIs.
- [pandulapeter-kubriko](../findings/pandulapeter-kubriko.md) - `DebugMenuManager` treats debug overlays as a first-class manager instead of gameplay-specific debug code.
- [retrowars-retrowars](../findings/retrowars-retrowars.md) - `MultiplayerLobbyScreen` shows a state-driven Scene2D lobby that safely stages cross-thread UI changes.
- [unciv](../findings/yairm210-unciv.md) - `WorldScreen` is a strong reference for composing a map-heavy HUD around chat, minimap, diplomacy, notifications, and tile/unit panels without a static layout.
- [candy-crush-clone](../findings/tobsef-candy-crush-clone.md) - `ScoringRenderer` and `LevelCheckRenderer` show lightweight puzzle HUD patterns for floating feedback, remaining moves, and tile objectives.
- [remsengine](../findings/antonionoack-remsengine.md) - `PanelListY`, `UI.md`, `RemsEngine`, and `ExportMenu` show Android-inspired weighted layouts reused for editor, inspector, and export tooling surfaces.
- [hugobros3-chunkstories](../findings/hugobros3-chunkstories.md) - `IngameUI` keeps HUD overlays, selection state, and debug widgets trait-driven, while exposing hot-reload and rendergraph refresh actions directly in the running client.

## Physics And Collision

- [pandulapeter-kubriko](../findings/pandulapeter-kubriko.md) - separate collision and physics managers show a compact plugin-friendly simulation shape.
- [almasb-fxgl](../findings/almasb-fxgl.md) - `PhysicsWorld` centralizes world stepping, collision handlers, sensors, and body lifecycle.
- [remsengine](../findings/antonionoack-remsengine.md) - `BulletPhysics` and `BulletMod` show how a large optional physics subsystem can stay modular while integrating deeply with ECS entities and constraints.

## Audio

- [candy-crush-clone](../findings/tobsef-candy-crush-clone.md) - `SoundMachine` and `JukeBox` keep sound effects and looping background music as separate small services.
- [minigdx-tiny](../findings/minigdx-tiny.md) - `SoundManager`, `VirtualSoundBoard`, and `MusicGenerator` keep synthesis, loop-friendly music generation, and RMS-aware multi-track mixing inside the engine instead of delegating everything to external assets.
- [curioustorvald-terrarum](../findings/curioustorvald-terrarum.md) - `SpatialAudioMixer` and `App.audioMixer` show explicit surround-mix matrices, panning-law helpers, and a dedicated high-priority audio thread with live mixer reload support.

## AI And Behavior

- [ktx](../findings/libktx-ktx.md) - the behavior-tree DSL shows a clean Kotlin wrapper for AI task composition.
- [unciv](../findings/yairm210-unciv.md) - `WorkerAutomation`, `ConstructionAutomation`, and `BarbarianAutomation` show staged scoring-based automation with road planning, tile simulation, and explicit fallback ladders.

## Persistence And Data

- [antimine-android](../findings/lucasnlm-antimine-android.md) - `SaveFileSerializer` demonstrates compact explicit binary save/load logic.
- [ktx](../findings/libktx-ktx.md) - `AssetStorage` exposes coroutine-first asset loading with progress and dependency tracking.
- [littlektframework-littlekt](../findings/littlektframework-littlekt.md) - `AssetProvider` separates async loading from post-load preparation and prevents duplicate in-flight loads.
- [pandulapeter-kubriko](../findings/pandulapeter-kubriko.md) - `SerializationManagerImpl` uses typed metadata registration for actor save/load.
- [almasb-fxgl](../findings/almasb-fxgl.md) - `SaveLoadService` packages persistence as pluggable handlers rather than hardwired scene logic.
- [unciv](../findings/yairm210-unciv.md) - `GameInfo.setTransients`, `UncivFiles`, and the ruleset merge path separate durable serialized state from reconstructed runtime caches, previews, and mod compatibility repair.
- [minigdx-tiny](../findings/minigdx-tiny.md) - `FloppyLib` converts Lua tables into JSON-backed per-game storage with circular-reference detection, while `_tiny.json` keeps game resource declarations explicit and small.

## Networking And Multiplayer

- [retrowars-retrowars](../findings/retrowars-retrowars.md) - client/server rooms, versioned DTOs, and public-server discovery are all first-class parts of the product shell.
- [almasb-fxgl](../findings/almasb-fxgl.md) - `NetService` exposes reusable typed TCP/UDP helpers and download tasks as engine services.
- [unciv](../findings/yairm210-unciv.md) - `Multiplayer`, `MultiplayerServer`, `ChatWebSocket`, and `ApiV2` show a hybrid local-preview plus remote-authority multiplayer stack with throttled refresh and reconnecting WebSockets.
- [hugobros3-chunkstories](../findings/hugobros3-chunkstories.md) - `LoadedContentTranslator`, `ConnectionsManager`, and `ServerModsProvider` show content-id compatibility checks, server metadata handshakes, and redistributable mod packaging, even though the current remote runtime path is unfinished on the inspected branch.

## Tooling And Content Pipeline

- [korge](../findings/korlibs-korge.md) - the reload agent is a concrete hot-reload tooling pattern for game iteration.
- [ktx](../findings/libktx-ktx.md) - async asset loading is a reusable asset-pipeline foundation.
- [godot-kotlin-jvm](../findings/utopia-rise-godot-kotlin-jvm.md) - registration-file generation and the Gradle plugin are strong examples of engine-binding tooling.
- [littlektframework-littlekt](../findings/littlektframework-littlekt.md) - runtime atlas generation is a useful content-pipeline fallback when a prebuilt atlas is not enough.
- [pandulapeter-kubriko](../findings/pandulapeter-kubriko.md) - the debug-menu manager is a strong example of keeping live inspection tooling separate from gameplay logic.
- [unciv](../findings/yairm210-unciv.md) - `RulesetCache`, `Ruleset`, and `RulesetValidator` treat mods as a validated JSON content pipeline with base rulesets, extension merges, removals, and fallback fills.
- [remsengine](../findings/antonionoack-remsengine.md) - `OfficialExtensions`, `FileReference`, `CacheSection`, and `ExportMenu` show how to organize asset-heavy editor/runtime tooling through extension modules, virtual file references, and preset-driven exporters.
- [minigdx-tiny](../findings/minigdx-tiny.md) - `CommonVirtualFileSystem`, `RunCommand`, `ExportCommand`, `tiny-web-editor`, and the annotation processors show a unified hot-reload/edit/debug/export toolchain around the same runtime.
- [curioustorvald-terrarum](../findings/curioustorvald-terrarum.md) - `ModMgr` and `CommonResourcePool` show a metadata-first mod/content pipeline for blocks, items, fluids, audio, weather, retextures, locales, IMEs, and crafting with explicit GL-thread realization.
- [hugobros3-chunkstories](../findings/hugobros3-chunkstories.md) - `GameContentStore`, `ModsManagerImplementation`, and `DefaultPluginManager` show a layered asset filesystem, embedded-jar classloading, mod-bundled plugins, and ordered registry reloads across blocks, items, entities, packets, generators, models, and localization.

## Android Platform Integration

- [antimine-android](../findings/lucasnlm-antimine-android.md) - separate `wear` and `auto` modules plus cloud-save wiring show unusually deep Android adaptation.
- [korge](../findings/korlibs-korge.md) - `KorgeAndroidView` and `AndroidGameWindowNoActivity` show host-view embedding without forcing a full activity-owned runtime.
- [godot-kotlin-jvm](../findings/utopia-rise-godot-kotlin-jvm.md) - Android export support includes explicit main-dex generation and plugin wiring.
- [pandulapeter-kubriko](../findings/pandulapeter-kubriko.md) - `KubrikoViewport` and `InternalViewport` show how to embed a game runtime directly inside Compose-based Android UI.
- [retrowars-retrowars](../findings/retrowars-retrowars.md) - `AndroidPlatform` isolates share intents, multicast locks, and IP handling behind a platform boundary.
- [unciv](../findings/yairm210-unciv.md) - `AndroidLauncher`, `AndroidGame`, `AndroidDisplay`, and `AndroidSaverLoader` show deep-link handling, SAF saves, background multiplayer workers, immersive-mode control, and external-mod bridging.
- [candy-crush-clone](../findings/tobsef-candy-crush-clone.md) - the KorGE target matrix in `build.gradle.kts` shows a compact path to Android delivery from a `commonMain` game codebase.
- [remsengine](../findings/antonionoack-remsengine.md) - `UI.md` and `PanelListY` show Android-inspired UI layout assumptions, but the engine itself remains JVM-first and should be treated as an architectural rather than turnkey Android reference.

## Performance And Memory

- [korge](../findings/korlibs-korge.md) - `GameWindowCoroutineDispatcher` budgets queued tasks per frame to protect frame time.
- [ktx](../findings/libktx-ktx.md) - render-thread dispatchers and background asset loading are directly useful for thread-aware Android game code.
- [littlektframework-littlekt](../findings/littlektframework-littlekt.md) - `LwjglContext` explicitly works with available frame time and deferred main-dispatcher work.
- [pandulapeter-kubriko](../findings/pandulapeter-kubriko.md) - `ActorManagerImpl` can avoid updating far-away actors and re-evaluates visibility through flows.
- [almasb-fxgl](../findings/almasb-fxgl.md) - `Entity` supports reusable entities and explicit update disabling for lower overhead.
- [unciv](../findings/yairm210-unciv.md) - `WorldScreen`, `Unique`, `GameInfo.updateCivilizationState`, and `PathingMap` show GL-thread deferral, regex-result caching, once-per-civ recomputation, and reusable multi-turn path caches.
- [remsengine](../findings/antonionoack-remsengine.md) - `WindowManagement` idle throttling plus `CacheSection` expiry/update logic are useful references for keeping editor-heavy runtimes responsive without overspending CPU.
- [minigdx-tiny](../findings/minigdx-tiny.md) - `DefaultVirtualFrameBuffer` uses clip/camera culling and cached readback, while `GameEngine` and the built-in profiler hooks keep live iteration performance visible.
- [curioustorvald-terrarum](../findings/curioustorvald-terrarum.md) - `WorldSimulator` merges overlapping update regions, `IngameRenderer` throttles light recalculation, and `LightmapRenderer` reuses fixed overscanned arrays instead of reallocating per frame.
- [hugobros3-chunkstories](../findings/hugobros3-chunkstories.md) - `WorkerThreadPool`, `AutoRebuildingProperty`, `TaskCreateChunkMesh`, and `WorldMasterImplementation.tick()` show task rescheduling, async derived-data rebuilds, neighbor-aware chunk meshing, and near-player simulation throttling.

## Build, Release, And Testing

- [godot-kotlin-jvm](../findings/utopia-rise-godot-kotlin-jvm.md) - the Gradle plugin, tooling model builder, harness tests, and Android dex task show a mature integration/build surface.
- [almasb-fxgl](../findings/almasb-fxgl.md) - the split Maven module layout keeps core runtime, IO, and sample applications separated for publication and maintenance.
- [candy-crush-clone](../findings/tobsef-candy-crush-clone.md) - `commonTest` coverage over board rules and coordinate mapping makes this sample stronger than a typical toy repository.
- [remsengine](../findings/antonionoack-remsengine.md) - the absence of a root Gradle/Maven build plus the huge `test/src/` sample surface make this repo a strong reading reference but a weaker reproducibility reference.
- [minigdx-tiny](../findings/minigdx-tiny.md) - the Gradle monorepo, embedded web debugger/export artifacts, and `commonTest` coverage across scripts, input, sound, and config make it a strong workflow reference even though a full build still needs a JDK.
- [hugobros3-chunkstories](../findings/hugobros3-chunkstories.md) - `gradlew help` shows a readable Gradle monorepo surface, but `buildAll --dry-run` fails in the standalone clone because the expected external `api` publication tasks are unavailable.
