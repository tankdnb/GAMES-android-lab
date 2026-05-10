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

## Rendering And Graphics

- [antimine-android](../findings/lucasnlm-antimine-android.md) - `MinefieldStage` and `AreaActor` show a LibGDX surface embedded into an Android game with custom cell composition.
- [korge](../findings/korlibs-korge.md) - `GameWindow` and Android-specific window implementations show how KorGE abstracts platform rendering surfaces.
- [littlektframework-littlekt](../findings/littlektframework-littlekt.md) - WebGPU backend setup and `MutableTextureAtlas` show a clean render boundary plus runtime atlas generation.
- [pandulapeter-kubriko](../findings/pandulapeter-kubriko.md) - `InternalViewport` and `ActorManagerImpl` tie rendering to Compose sizing, scaling, and visible-actor filtering.
- [retrowars-retrowars](../findings/retrowars-retrowars.md) - `GameViewport` reserves HUD space inside the game viewport instead of assuming full-screen world rendering.

## Gameplay Systems

- [antimine-android](../findings/lucasnlm-antimine-android.md) - no-guess generation, solver-backed validation, and board sizing logic are directly reusable gameplay-system patterns.
- [retrowars-retrowars](../findings/retrowars-retrowars.md) - the minigame registry and compact per-game state holders are useful for multi-mode or multi-game products.
- [unciv](../findings/yairm210-unciv.md) - `GameStarter`, `GameInfo.nextTurn`, and the built-in simulation harness show a full-scale turn-based gameplay pipeline with generation, save-state restoration, and multi-actor turn processing.

## Input And Controls

- [korge](../findings/korlibs-korge.md) - input and lifecycle hooks are centralized through `Stage` and `GameWindow`, which is useful for Android host integration.
- [littlektframework-littlekt](../findings/littlektframework-littlekt.md) - `InputMapController` unifies keyboard, pointer, and gamepad input into custom game signals.
- [pandulapeter-kubriko](../findings/pandulapeter-kubriko.md) - `PointerInputManagerImpl` normalizes embedded viewport coordinates and dispatches drag/zoom/pointer callbacks.
- [retrowars-retrowars](../findings/retrowars-retrowars.md) - `SoftController` shows declarative on-screen controller layouts with optional gesture-only modes.
- [almasb-fxgl](../findings/almasb-fxgl.md) - `Input`, `VirtualInput`, and `InputCapture` provide centralized bindings, touch overlays, and replayable input sequences.

## UI, HUD, And Menus

- [antimine-android](../findings/lucasnlm-antimine-android.md) - the LibGDX stage and actor layering demonstrate a custom in-game board UI inside a standard Android app shell.
- [ktx](../findings/libktx-ktx.md) - the Scene2D DSL is a strong pattern for reducing UI boilerplate in Kotlin game UIs.
- [pandulapeter-kubriko](../findings/pandulapeter-kubriko.md) - `DebugMenuManager` treats debug overlays as a first-class manager instead of gameplay-specific debug code.
- [retrowars-retrowars](../findings/retrowars-retrowars.md) - `MultiplayerLobbyScreen` shows a state-driven Scene2D lobby that safely stages cross-thread UI changes.
- [unciv](../findings/yairm210-unciv.md) - `WorldScreen` is a strong reference for composing a map-heavy HUD around chat, minimap, diplomacy, notifications, and tile/unit panels without a static layout.

## Physics And Collision

- [pandulapeter-kubriko](../findings/pandulapeter-kubriko.md) - separate collision and physics managers show a compact plugin-friendly simulation shape.
- [almasb-fxgl](../findings/almasb-fxgl.md) - `PhysicsWorld` centralizes world stepping, collision handlers, sensors, and body lifecycle.

## Audio

- No audio-specific findings were captured in this batch.

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

## Networking And Multiplayer

- [retrowars-retrowars](../findings/retrowars-retrowars.md) - client/server rooms, versioned DTOs, and public-server discovery are all first-class parts of the product shell.
- [almasb-fxgl](../findings/almasb-fxgl.md) - `NetService` exposes reusable typed TCP/UDP helpers and download tasks as engine services.
- [unciv](../findings/yairm210-unciv.md) - `Multiplayer`, `MultiplayerServer`, `ChatWebSocket`, and `ApiV2` show a hybrid local-preview plus remote-authority multiplayer stack with throttled refresh and reconnecting WebSockets.

## Tooling And Content Pipeline

- [korge](../findings/korlibs-korge.md) - the reload agent is a concrete hot-reload tooling pattern for game iteration.
- [ktx](../findings/libktx-ktx.md) - async asset loading is a reusable asset-pipeline foundation.
- [godot-kotlin-jvm](../findings/utopia-rise-godot-kotlin-jvm.md) - registration-file generation and the Gradle plugin are strong examples of engine-binding tooling.
- [littlektframework-littlekt](../findings/littlektframework-littlekt.md) - runtime atlas generation is a useful content-pipeline fallback when a prebuilt atlas is not enough.
- [pandulapeter-kubriko](../findings/pandulapeter-kubriko.md) - the debug-menu manager is a strong example of keeping live inspection tooling separate from gameplay logic.
- [unciv](../findings/yairm210-unciv.md) - `RulesetCache`, `Ruleset`, and `RulesetValidator` treat mods as a validated JSON content pipeline with base rulesets, extension merges, removals, and fallback fills.

## Android Platform Integration

- [antimine-android](../findings/lucasnlm-antimine-android.md) - separate `wear` and `auto` modules plus cloud-save wiring show unusually deep Android adaptation.
- [korge](../findings/korlibs-korge.md) - `KorgeAndroidView` and `AndroidGameWindowNoActivity` show host-view embedding without forcing a full activity-owned runtime.
- [godot-kotlin-jvm](../findings/utopia-rise-godot-kotlin-jvm.md) - Android export support includes explicit main-dex generation and plugin wiring.
- [pandulapeter-kubriko](../findings/pandulapeter-kubriko.md) - `KubrikoViewport` and `InternalViewport` show how to embed a game runtime directly inside Compose-based Android UI.
- [retrowars-retrowars](../findings/retrowars-retrowars.md) - `AndroidPlatform` isolates share intents, multicast locks, and IP handling behind a platform boundary.
- [unciv](../findings/yairm210-unciv.md) - `AndroidLauncher`, `AndroidGame`, `AndroidDisplay`, and `AndroidSaverLoader` show deep-link handling, SAF saves, background multiplayer workers, immersive-mode control, and external-mod bridging.

## Performance And Memory

- [korge](../findings/korlibs-korge.md) - `GameWindowCoroutineDispatcher` budgets queued tasks per frame to protect frame time.
- [ktx](../findings/libktx-ktx.md) - render-thread dispatchers and background asset loading are directly useful for thread-aware Android game code.
- [littlektframework-littlekt](../findings/littlektframework-littlekt.md) - `LwjglContext` explicitly works with available frame time and deferred main-dispatcher work.
- [pandulapeter-kubriko](../findings/pandulapeter-kubriko.md) - `ActorManagerImpl` can avoid updating far-away actors and re-evaluates visibility through flows.
- [almasb-fxgl](../findings/almasb-fxgl.md) - `Entity` supports reusable entities and explicit update disabling for lower overhead.
- [unciv](../findings/yairm210-unciv.md) - `WorldScreen`, `Unique`, `GameInfo.updateCivilizationState`, and `PathingMap` show GL-thread deferral, regex-result caching, once-per-civ recomputation, and reusable multi-turn path caches.

## Build, Release, And Testing

- [godot-kotlin-jvm](../findings/utopia-rise-godot-kotlin-jvm.md) - the Gradle plugin, tooling model builder, harness tests, and Android dex task show a mature integration/build surface.
- [almasb-fxgl](../findings/almasb-fxgl.md) - the split Maven module layout keeps core runtime, IO, and sample applications separated for publication and maintenance.
