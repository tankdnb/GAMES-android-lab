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
- [quillraven-quilly-s-adventure](../findings/quillraven-quilly-s-adventure.md) - `Main`, `LoadingScreen`, `Screen`, and `GameEventManager` show a shared LibGDX runtime with framebuffer-based screen transitions, centralized system assembly, dialog-aware ECS pausing, and a small event bus for input, maps, and gameplay.
- [egoal-darkest-pixel-dungeon](../findings/egoal-darkest-pixel-dungeon.md) - `Game`, `Actor`, `InterlevelScene`, and `GameScene` show a custom Android/GL runtime with buffered touch dispatch, time-scheduled actors, background interlevel loading, and layered scene composition.
- [mariodujic-neon](../findings/mariodujic-neon.md) - `MainActivity`, `GameScreen`, `rememberGameState`, `StageController`, and `tinker` show a Compose-native Android game shell assembled from controllers and timed jobs rather than from a custom surface runtime.
- [vgupta98-compose-game](../findings/vgupta98-compose-game.md) - `GameEngine`, `GameEngineImpl`, and `GameFactory` show a Compose-hosted micro-engine whose loop is driven by `Animatable` time and whose objects are re-derived analytically from `lastCollisionTime`.
- [remsengine](../findings/antonionoack-remsengine.md) - `EngineBase`, `WindowManagement`, `RemsEngine`, and `OfficialExtensions` show an editor-first engine lifecycle with extension-loaded modules and split window/render loops.
- [minigdx-tiny](../findings/minigdx-tiny.md) - `GameEngine`, `GameResourceProcessor`, `GameResourceCollector`, and `GameScript` show a fixed-step KMP runtime with ordered resource bootstrapping, state-preserving Lua hot reload, and script-to-script transitions.
- [curioustorvald-terrarum](../findings/curioustorvald-terrarum.md) - `App`, `CommonResourcePool`, `ModMgr`, `IngameInstance`, and `GameUpdateGovernor` show background module bootstrapping with explicit GL-thread handoff, PRTree-backed actor queries, and fixed-step update governance.
- [hugobros3-chunkstories](../findings/hugobros3-chunkstories.md) - `ClientImplementation`, `IngameClientImplementation`, `TickingThread`, `WorldImplementation`, and `AutoRebuildingProperty` show a split render/simulation runtime, 60 TPS logic loop, player-near chunk ticking, and task-driven rebuilds for expensive derived world data.
- [korlibs-korge-fleks](../findings/korlibs-korge-fleks.md) - `WorldConfigurationExt`, `EntityFactory`, `EntityBlueprint`, `MessagePassingSystem`, and `GameStateManager` show a ready-made ECS gameplay shell with blueprint-driven entity composition, decoupled message events, and YAML-backed bootstrap state.
- [minigdx-minigdx](../findings/minigdx-minigdx.md) - `Game`, `GameNode`, `Engine`, `GameWrapper`, and `ScriptExecutorSystem` show a compact multiplatform engine lifecycle with staged bootstrap, queued ECS mutations, framebuffer graph assembly, nested storyboard screens, and coroutine-backed gameplay scripts.

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
- [korlibs-korge-fleks](../findings/korlibs-korge-fleks.md) - `ObjectRenderSystem`, `LevelMapRenderSystem`, and `CameraSystem` show ECS-owned sprite/text/tile rendering, visible-window chunk-aware map drawing, and camera-driven parallax updates without storing heavyweight KorGE view objects inside components.
- [quillraven-quilly-s-adventure](../findings/quillraven-quilly-s-adventure.md) - `RenderSystem`, `Main`, `GameScreen`, and `MapManager` show sorted ECS sprite rendering around Tiled layers, map/screen crossfades via framebuffers, Tiled-property parallax, and ambient/sun-light coordination through Box2D Lights.
- [egoal-darkest-pixel-dungeon](../findings/egoal-darkest-pixel-dungeon.md) - `Tilemap`, `GameScene`, and `Game` show visible-range tile VBO updates, buffered touch-aware scene rendering, and layer-split terrain/water/UI composition.
- [mariodujic-neon](../findings/mariodujic-neon.md) - `GameWorld` shows a fully Compose-driven sprite scene with `Image`/`Canvas` layering, animated radial shield gradients, and Coil GIF explosions instead of a separate GL renderer.
- [vgupta98-compose-game](../findings/vgupta98-compose-game.md) - `GameBoard`, `GameDrawScope`, and `GameResourceImpl` show ID-mapped Compose `Canvas` rendering with host-provided draw hooks above and below engine-owned objects.
- [minigdx-minigdx](../findings/minigdx-minigdx.md) - `FrameBuffer`, `TextureFrameBuffer`, `RenderStage`, `QuadRenderStage`, and `ModelComponentRenderStage` show a dependency-aware framebuffer graph, reusable fullscreen post-process stage, shader-parameter abstraction, per-draw lighting uniforms, and transparent back-to-front sorting.

## Gameplay Systems

- [antimine-android](../findings/lucasnlm-antimine-android.md) - no-guess generation, solver-backed validation, and board sizing logic are directly reusable gameplay-system patterns.
- [retrowars-retrowars](../findings/retrowars-retrowars.md) - the minigame registry and compact per-game state holders are useful for multi-mode or multi-game products.
- [unciv](../findings/yairm210-unciv.md) - `GameStarter`, `GameInfo.nextTurn`, and the built-in simulation harness show a full-scale turn-based gameplay pipeline with generation, save-state restoration, and multi-actor turn processing.
- [candy-crush-clone](../findings/tobsef-candy-crush-clone.md) - `GameMechanics`, `Level`, `LevelCheck`, and `Scoring` separate board rules, scripted reserve tiles, goals, and combo scoring in a reusable puzzle-game shape.
- [quillraven-quilly-s-adventure](../findings/quillraven-quilly-s-adventure.md) - `EcsUtils`, `PlayerCollisionSystem`, `GameScreen`, and `TutorialSystem` show action-adventure progression through portal-linked maps, savepoints, stat-granting items, one-time tutorials, and gameplay-driven trigger events.
- [remsengine](../findings/antonionoack-remsengine.md) - `Entity`, `Systems`, and the sample games under `test/src/me/anno/games/` show how gameplay scenarios are built on top of a scene hierarchy plus runtime systems bridge.
- [minigdx-tiny](../findings/minigdx-tiny.md) - `MapLib` turns LDtk levels, layers, flags, and custom fields into Lua-facing runtime data, while `TinyLib` plus boot/game scripts provide a lightweight multi-script scene flow.
- [curioustorvald-terrarum](../findings/curioustorvald-terrarum.md) - `WorldSimulator` and `worldgenerator/*` show localized environmental simulation, graph-based wire propagation, and staged terrain/cave/aquifer/ore/biome/tree generation with versioned parameters.
- [hugobros3-chunkstories](../findings/hugobros3-chunkstories.md) - `ChunkImplementation`, `WorldImplementation`, `WorldMasterImplementation.tick()`, and `TaskGenerateWorldSlice` show chunk-local world state, cadence-based near-player physics work, and staged wave-based slice generation.
- [korlibs-korge-fleks](../findings/korlibs-korge-fleks.md) - `SpawnerSystem`, `WorldChunkSystem`, and `WorldMapData.loadNewChunksAndEntities` show blueprint-driven entity spawning, camera-quadrant chunk activation, and reusable platformer-world streaming patterns.
- [egoal-darkest-pixel-dungeon](../findings/egoal-darkest-pixel-dungeon.md) - `RegularLevel`, `LevelDigger`, `Mob`, `Pressure`, and `Generator` show weighted digger-based dungeon generation, data-backed mob state machines, stress mechanics, and controlled loot economy.
- [mariodujic-neon](../findings/mariodujic-neon.md) - `Stage`, `StageController`, `EnemyFactory`, `LasersController`, `LevelOneBoss`, and `LevelTwoBoss` show typed wave scripting, break-before-advance flow, formation-based spawns, and small but reusable boss-pattern design.
- [minigdx-minigdx](../findings/minigdx-minigdx.md) - `EntityFactoryDelegate`, `GraphSceneLoader`, `ParticleConfiguration`, and `Storyboard` show scene-to-ECS import, runtime sprite UV generation, emitter DSL flow, and nested screen/game transitions inside one engine shell.

## Input And Controls

- [korge](../findings/korlibs-korge.md) - input and lifecycle hooks are centralized through `Stage` and `GameWindow`, which is useful for Android host integration.
- [littlektframework-littlekt](../findings/littlektframework-littlekt.md) - `InputMapController` unifies keyboard, pointer, and gamepad input into custom game signals.
- [pandulapeter-kubriko](../findings/pandulapeter-kubriko.md) - `PointerInputManagerImpl` normalizes embedded viewport coordinates and dispatches drag/zoom/pointer callbacks.
- [retrowars-retrowars](../findings/retrowars-retrowars.md) - `SoftController` shows declarative on-screen controller layouts with optional gesture-only modes.
- [almasb-fxgl](../findings/almasb-fxgl.md) - `Input`, `VirtualInput`, and `InputCapture` provide centralized bindings, touch overlays, and replayable input sequences.
- [candy-crush-clone](../findings/tobsef-candy-crush-clone.md) - `DragListener` and `MoveTileObserver` translate raw drags into adjacent grid-cell swap commands before gameplay logic runs.
- [remsengine](../findings/antonionoack-remsengine.md) - `JVMExtension` keeps controller polling and JVM-only input/platform glue inside an extension layer instead of polluting core runtime code.
- [minigdx-tiny](../findings/minigdx-tiny.md) - `LwjglInput`, `TouchManager`, and `GameOptions` normalize desktop input into virtual touch/key state and even support debugger-driven remote key injection.
- [korlibs-korge-fleks](../findings/korlibs-korge-fleks.md) - `TouchInputSystem` shows entity-bounded touch routing with optional continuous touch and coordinate forwarding, although it is marked unused on the inspected revision.
- [quillraven-quilly-s-adventure](../findings/quillraven-quilly-s-adventure.md) - `PlayerInputSystem`, `GameEventManager`, and `GameHUD` show an abstract action-input layer shared across keyboard and touchpad/button controls.
- [egoal-darkest-pixel-dungeon](../findings/egoal-darkest-pixel-dungeon.md) - `Game` and `Touchscreen` show buffered Android `MotionEvent` handling and centralized multi-touch translation into engine touch signals.
- [mariodujic-neon](../findings/mariodujic-neon.md) - `MovementButtons`, `ShipController`, and the lifecycle/game-status wiring show hold-to-move touch controls and pause-aware input flow for a Compose-native Android action game.
- [minigdx-minigdx](../findings/minigdx-minigdx.md) - `TouchManager`, `LwjglInput`, `AndroidInputHandler`, and `FillViewportStrategy` show a shared virtual touch/key model, desktop mouse-to-touch emulation, and aspect-safe coordinate conversion across Android, JVM, and web.

## UI, HUD, And Menus

- [antimine-android](../findings/lucasnlm-antimine-android.md) - the LibGDX stage and actor layering demonstrate a custom in-game board UI inside a standard Android app shell.
- [ktx](../findings/libktx-ktx.md) - the Scene2D DSL is a strong pattern for reducing UI boilerplate in Kotlin game UIs.
- [pandulapeter-kubriko](../findings/pandulapeter-kubriko.md) - `DebugMenuManager` treats debug overlays as a first-class manager instead of gameplay-specific debug code.
- [retrowars-retrowars](../findings/retrowars-retrowars.md) - `MultiplayerLobbyScreen` shows a state-driven Scene2D lobby that safely stages cross-thread UI changes.
- [unciv](../findings/yairm210-unciv.md) - `WorldScreen` is a strong reference for composing a map-heavy HUD around chat, minimap, diplomacy, notifications, and tile/unit panels without a static layout.
- [candy-crush-clone](../findings/tobsef-candy-crush-clone.md) - `ScoringRenderer` and `LevelCheckRenderer` show lightweight puzzle HUD patterns for floating feedback, remaining moves, and tile objectives.
- [remsengine](../findings/antonionoack-remsengine.md) - `PanelListY`, `UI.md`, `RemsEngine`, and `ExportMenu` show Android-inspired weighted layouts reused for editor, inspector, and export tooling surfaces.
- [hugobros3-chunkstories](../findings/hugobros3-chunkstories.md) - `IngameUI` keeps HUD overlays, selection state, and debug widgets trait-driven, while exposing hot-reload and rendergraph refresh actions directly in the running client.
- [quillraven-quilly-s-adventure](../findings/quillraven-quilly-s-adventure.md) - `GameHUD`, `GameScreen`, and `Screen` show a touch-first mobile HUD, portrait-driven stats overlay, and dialog-controlled simulation pause without splitting the runtime into separate UI and gameplay loops.
- [egoal-darkest-pixel-dungeon](../findings/egoal-darkest-pixel-dungeon.md) - `GameScene`, `WndHero`, and `WndJournal` show layered in-game UI composition, tabbed hero sheets, and depth-aware journal/catalog flows.
- [mariodujic-neon](../findings/mariodujic-neon.md) - `GameScreen`, `StatusIndicator`, `GamePauseDialog`, and the navigation flow show a Compose HUD/world split with a dialog-route pause overlay instead of a second activity or fragment shell.
- [minigdx-minigdx](../findings/minigdx-minigdx.md) - `Game.createDebugRenderStage()`, `ImGuiRenderStage`, `BoundingBoxRenderStage`, and the text-component helpers show built-in debug overlay and sprite-font text capabilities instead of leaving them as game-local utilities.

## Physics And Collision

- [pandulapeter-kubriko](../findings/pandulapeter-kubriko.md) - separate collision and physics managers show a compact plugin-friendly simulation shape.
- [almasb-fxgl](../findings/almasb-fxgl.md) - `PhysicsWorld` centralizes world stepping, collision handlers, sensors, and body lifecycle.
- [remsengine](../findings/antonionoack-remsengine.md) - `BulletPhysics` and `BulletMod` show how a large optional physics subsystem can stay modular while integrating deeply with ECS entities and constraints.
- [korlibs-korge-fleks](../findings/korlibs-korge-fleks.md) - `GridMoveSystem`, `PlatformerCollisionResolver`, and `PlatformerGravitySystem` show stepped tile/grid platformer movement, edge-snap collision resolution, and grounded-state-controlled gravity.
- [quillraven-quilly-s-adventure](../findings/quillraven-quilly-s-adventure.md) - `PhysicSystem`, `PhysicContactListener`, `EcsUtils`, and `AttackSystem` show fixed-step Box2D with interpolation, selective non-blocking collision pairs, multi-fixture character bodies, and damage-emitter hitboxes.
- [mariodujic-neon](../findings/mariodujic-neon.md) - `ShipController` and `LasersController` show lightweight Rect/circle overlap collisions, shield-envelope switching, and controller-owned projectile cleanup without a dedicated physics engine.
- [vgupta98-compose-game](../findings/vgupta98-compose-game.md) - `RoundObject`, `Boundary`, `InitialConditionsChecker`, `Vector2D`, and `GameEngineImpl.checkForCollisions()` show analytical kinematics plus circle-circle and circle-boundary restitution handling inside a very small Compose-native physics runtime.
- [minigdx-minigdx](../findings/minigdx-minigdx.md) - `AABBCollisionResolver`, `SATCollisionResolver`, and `SATCollisionResolverTest` show both cheap axis-aligned overlap checks and a rotated-box SAT path with bounding-sphere short-circuiting and test coverage.

## Audio

- [candy-crush-clone](../findings/tobsef-candy-crush-clone.md) - `SoundMachine` and `JukeBox` keep sound effects and looping background music as separate small services.
- [minigdx-tiny](../findings/minigdx-tiny.md) - `SoundManager`, `VirtualSoundBoard`, and `MusicGenerator` keep synthesis, loop-friendly music generation, and RMS-aware multi-track mixing inside the engine instead of delegating everything to external assets.
- [curioustorvald-terrarum](../findings/curioustorvald-terrarum.md) - `SpatialAudioMixer` and `App.audioMixer` show explicit surround-mix matrices, panning-law helpers, and a dedicated high-priority audio thread with live mixer reload support.
- [korlibs-korge-fleks](../findings/korlibs-korge-fleks.md) - `SoundSystem` keeps playback position in ECS state so pause, resume, and snapshot-related world control can coordinate with audio.
- [mariodujic-neon](../findings/mariodujic-neon.md) - `AudioPlayer` ties ExoPlayer playback and remembered position to `GameStatus`, giving a compact pause/resume music pattern for Compose games.
- [minigdx-minigdx](../findings/minigdx-minigdx.md) - Android and JVM `PlatformFileHandler` implementations show a small cross-platform sound abstraction over `SoundPool` on Android and MP3 decode/playback on desktop.

## AI And Behavior

- [ktx](../findings/libktx-ktx.md) - the behavior-tree DSL shows a clean Kotlin wrapper for AI task composition.
- [unciv](../findings/yairm210-unciv.md) - `WorkerAutomation`, `ConstructionAutomation`, and `BarbarianAutomation` show staged scoring-based automation with road planning, tile simulation, and explicit fallback ladders.
- [egoal-darkest-pixel-dungeon](../findings/egoal-darkest-pixel-dungeon.md) - `Actor`, `Mob`, and `Database` show a time-based scheduler plus serializable mob AI modes and data-backed resistances, abilities, and loot tables.

## Persistence And Data

- [antimine-android](../findings/lucasnlm-antimine-android.md) - `SaveFileSerializer` demonstrates compact explicit binary save/load logic.
- [ktx](../findings/libktx-ktx.md) - `AssetStorage` exposes coroutine-first asset loading with progress and dependency tracking.
- [littlektframework-littlekt](../findings/littlektframework-littlekt.md) - `AssetProvider` separates async loading from post-load preparation and prevents duplicate in-flight loads.
- [pandulapeter-kubriko](../findings/pandulapeter-kubriko.md) - `SerializationManagerImpl` uses typed metadata registration for actor save/load.
- [almasb-fxgl](../findings/almasb-fxgl.md) - `SaveLoadService` packages persistence as pluggable handlers rather than hardwired scene logic.
- [unciv](../findings/yairm210-unciv.md) - `GameInfo.setTransients`, `UncivFiles`, and the ruleset merge path separate durable serialized state from reconstructed runtime caches, previews, and mod compatibility repair.
- [minigdx-tiny](../findings/minigdx-tiny.md) - `FloppyLib` converts Lua tables into JSON-backed per-game storage with circular-reference detection, while `_tiny.json` keeps game resource declarations explicit and small.
- [korlibs-korge-fleks](../findings/korlibs-korge-fleks.md) - `SnapshotSerializer`, `SnapshotSerializerSystem`, `Pool`, and `PoolableComponent` show JSON-backed world snapshots, rewind buffers, polymorphic Korge-type serialization, and pooled data-only component lifecycles.
- [quillraven-quilly-s-adventure](../findings/quillraven-quilly-s-adventure.md) - `SaveSystem` and `MapManager` show a compact progress-save model based on current map, surviving Tiled object IDs, player checkpoint/tutorial state, and current stats/abilities rather than a full serialized world snapshot.
- [egoal-darkest-pixel-dungeon](../findings/egoal-darkest-pixel-dungeon.md) - `Bundle`, `Dungeon`, `GamesInProgress`, `HeroPerk`, and `QuickSlot` show JSON/GZIP object persistence, split game-vs-level saves, multi-slot previews/backups, and placeholder-friendly inventory state.
- [mariodujic-neon](../findings/mariodujic-neon.md) - `rememberGameState`, `StageController.saver`, and the pervasive `rememberSaveable` usage show configuration-safe transient runtime state without needing a full disk-save system.
- [minigdx-minigdx](../findings/minigdx-minigdx.md) - `FileHandlerCommon` keeps typed asset caches, delayed `onLoad` mapping, and loading-progress reporting centralized so content consumers do not reopen files or duplicate decode work.

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
- [korlibs-korge-fleks](../findings/korlibs-korge-fleks.md) - `AssetStore`, `WorldMapData`, and `AssetReload` show common-vs-cluster asset lifetimes, asynchronous chunk activation, and the beginnings of a JVM-side live asset watcher flow.
- [quillraven-quilly-s-adventure](../findings/quillraven-quilly-s-adventure.md) - `LoadingScreen`, `MapManager`, and the multi-module Gradle setup show a shared-asset pipeline across Android/Desktop/Web plus Tiled-authored content layers mapped directly into runtime entities.
- [egoal-darkest-pixel-dungeon](../findings/egoal-darkest-pixel-dungeon.md) - `Database`, `RegularLevel`, and the split `core`/`SPD-classes` modules show a gameplay data layer where mob balance, loot, resistances, and some generation inputs are table-driven rather than purely hard-coded.
- [mariodujic-neon](../findings/mariodujic-neon.md) - `.github/workflows/android-ci.yml` plus the controller-focused unit-test tree show a lightweight but intentional workflow where timing helpers, stage logic, formations, boosters, and object controllers are validated separately from UI rendering.
- [minigdx-minigdx](../findings/minigdx-minigdx.md) - `FileHandlerCommon`, `GraphSceneLoader`, `EntityFactoryDelegate`, and the build workflow show a coherent pipeline from typed asset loading to scene import, runtime sprite setup, and KMP engine CI validation.

## Android Platform Integration

- [antimine-android](../findings/lucasnlm-antimine-android.md) - separate `wear` and `auto` modules plus cloud-save wiring show unusually deep Android adaptation.
- [korge](../findings/korlibs-korge.md) - `KorgeAndroidView` and `AndroidGameWindowNoActivity` show host-view embedding without forcing a full activity-owned runtime.
- [godot-kotlin-jvm](../findings/utopia-rise-godot-kotlin-jvm.md) - Android export support includes explicit main-dex generation and plugin wiring.
- [pandulapeter-kubriko](../findings/pandulapeter-kubriko.md) - `KubrikoViewport` and `InternalViewport` show how to embed a game runtime directly inside Compose-based Android UI.
- [retrowars-retrowars](../findings/retrowars-retrowars.md) - `AndroidPlatform` isolates share intents, multicast locks, and IP handling behind a platform boundary.
- [unciv](../findings/yairm210-unciv.md) - `AndroidLauncher`, `AndroidGame`, `AndroidDisplay`, and `AndroidSaverLoader` show deep-link handling, SAF saves, background multiplayer workers, immersive-mode control, and external-mod bridging.
- [candy-crush-clone](../findings/tobsef-candy-crush-clone.md) - the KorGE target matrix in `build.gradle.kts` shows a compact path to Android delivery from a `commonMain` game codebase.
- [remsengine](../findings/antonionoack-remsengine.md) - `UI.md` and `PanelListY` show Android-inspired UI layout assumptions, but the engine itself remains JVM-first and should be treated as an architectural rather than turnkey Android reference.
- [korlibs-korge-fleks](../findings/korlibs-korge-fleks.md) - the root `build.gradle.kts` enables `targetAndroid()`, while the pooling and serialization design explicitly accounts for tighter Android/JVM memory constraints than many desktop-first Kotlin engine samples do.
- [quillraven-quilly-s-adventure](../findings/quillraven-quilly-s-adventure.md) - `android/build.gradle` plus `GameHUD` show a direct Android LibGDX app target with touch-native controls while still reusing the same gameplay core on desktop and web.
- [egoal-darkest-pixel-dungeon](../findings/egoal-darkest-pixel-dungeon.md) - `core/build.gradle`, `Game`, and `Touchscreen` show a direct Android app target with custom GL shell and touch-first control plumbing rather than a desktop-first port.
- [mariodujic-neon](../findings/mariodujic-neon.md) - `app/build.gradle`, `AndroidManifest.xml`, and `MainActivity` show a direct portrait Android Compose app with immersive system-bar handling, dialog-based pause flow, and no cross-platform abstraction layer.
- [vgupta98-compose-game](../findings/vgupta98-compose-game.md) - `app/build.gradle`, `MainActivity`, and `MainViewModel` show a reusable engine library embedded into a normal Compose Android app rather than into an engine-owned activity shell.
- [minigdx-minigdx](../findings/minigdx-minigdx.md) - `MiniGdxActivity`, `MiniGdxSurfaceView`, Android `PlatformContextCommon`, and Android `PlatformFileHandler` show a direct Android engine shell around `GLSurfaceView`, `SoundPool`, viewport scaling, and shared KMP game code.

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
- [korlibs-korge-fleks](../findings/korlibs-korge-fleks.md) - `Pool`, `PoolableComponent`, `SnapshotSerializerSystem`, and `GridMoveSystem` show leak-accounted pooling, snapshot-buffer cleanup, GC-conscious component reuse, and stepped movement that reduces tile-collision tunneling.
- [quillraven-quilly-s-adventure](../findings/quillraven-quilly-s-adventure.md) - `PhysicSystem`, `EcsUtils`, `DefaultAudioService`, and `MapManager` show fixed physics cadence with interpolation, pooled Ashley entities/components, per-frame sound deduplication, and map caching instead of keeping the whole world live at once.
- [egoal-darkest-pixel-dungeon](../findings/egoal-darkest-pixel-dungeon.md) - `Tilemap`, `Actor`, `GameScene`, and `GamesInProgress` show partial tile-buffer updates, wait-for-animation turn scheduling, layered incremental map refresh, and split save-slot files/backups instead of one heavy snapshot.
- [minigdx-minigdx](../findings/minigdx-minigdx.md) - `TouchManager` pools internal input events, `FrameBuffer` reuses predeclared render targets, and the collision path short-circuits SAT checks with a radius test before doing axis projections.

## Build, Release, And Testing

- [godot-kotlin-jvm](../findings/utopia-rise-godot-kotlin-jvm.md) - the Gradle plugin, tooling model builder, harness tests, and Android dex task show a mature integration/build surface.
- [almasb-fxgl](../findings/almasb-fxgl.md) - the split Maven module layout keeps core runtime, IO, and sample applications separated for publication and maintenance.
- [candy-crush-clone](../findings/tobsef-candy-crush-clone.md) - `commonTest` coverage over board rules and coordinate mapping makes this sample stronger than a typical toy repository.
- [remsengine](../findings/antonionoack-remsengine.md) - the absence of a root Gradle/Maven build plus the huge `test/src/` sample surface make this repo a strong reading reference but a weaker reproducibility reference.
- [minigdx-tiny](../findings/minigdx-tiny.md) - the Gradle monorepo, embedded web debugger/export artifacts, and `commonTest` coverage across scripts, input, sound, and config make it a strong workflow reference even though a full build still needs a JDK.
- [hugobros3-chunkstories](../findings/hugobros3-chunkstories.md) - `gradlew help` shows a readable Gradle monorepo surface, but `buildAll --dry-run` fails in the standalone clone because the expected external `api` publication tasks are unavailable.
- [korlibs-korge-fleks](../findings/korlibs-korge-fleks.md) - `commonTest` covers snapshot rewind, tween serialization, and pool cleanup, but even lightweight Gradle discovery currently needs Java `21+` because the inspected KorGE plugin chain no longer supports the Java `8` environment used by this lab.
- [quillraven-quilly-s-adventure](../findings/quillraven-quilly-s-adventure.md) - the project has Android/Desktop/Web modules and some trigger tests, but even `gradlew help` and `:core:test --dry-run` currently require Java `11+` because the inspected Android Gradle Plugin `8.5.2` cannot configure on the Java `8` environment used by this lab.
- [egoal-darkest-pixel-dungeon](../findings/egoal-darkest-pixel-dungeon.md) - `build.gradle`, `core/build.gradle`, `SPD-classes/build.gradle`, and the wrapper properties show an older Android Gradle surface around Kotlin `1.5.20`, AGP `4.0.1`, and Gradle `6.6.1`; `gradlew help` still timed out in the lab and no real automated test tree was found.
- [mariodujic-neon](../findings/mariodujic-neon.md) - `build.gradle`, `app/build.gradle`, the JDK 17 CI workflow, and the unit-test tree show a direct Android Compose build with targeted controller/scheduler tests, but even lightweight Gradle discovery currently needs Java `11+` because the resolved Android Gradle Plugin `8.13.1` cannot configure on the Java `8` lab environment.
- [vgupta98-compose-game](../findings/vgupta98-compose-game.md) - `compose-game/build.gradle`, `app/build.gradle`, `jitpack.yml`, and `ExampleUnitTest.kt` show a JDK 17 Android library/sample setup with publication intent, but only placeholder tests and a missing referenced Jitpack prepare script; even lightweight Gradle discovery still needs a full JDK in this lab.
- [minigdx-minigdx](../findings/minigdx-minigdx.md) - `build.gradle.kts`, `gradle/libs.versions.toml`, `.github/workflows/build.yml`, and the `commonTest` tree show a direct KMP+Android build surface with meaningful engine tests, but even `gradlew help` currently fails in the lab because Gradle cannot find a Java compiler and upstream CI expected JDK 11.
