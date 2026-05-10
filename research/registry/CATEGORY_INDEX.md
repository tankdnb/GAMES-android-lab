# Category Index

Use this file to group reusable findings across multiple repositories.

This is not the accepted-project catalog. For accepted project cards grouped by normalized catalog categories, use `catalog/CATEGORY_INDEX.md`.

## Engine Architecture And Core Loop

- [antimine-android](../findings/lucasnlm-antimine-android.md) - game flow is isolated in `GameController`, with minefield creation split into pure Kotlin and native-backed generators.
- [korge](../findings/korlibs-korge.md) - `SceneContainer` and `Stage` show a reusable scene-graph runtime with transitions, history, and dependency injection.
- [godot-kotlin-jvm](../findings/utopia-rise-godot-kotlin-jvm.md) - `Bootstrap` and the native bridge show a full Kotlin-to-engine startup and registration chain.

## Rendering And Graphics

- [antimine-android](../findings/lucasnlm-antimine-android.md) - `MinefieldStage` and `AreaActor` show a LibGDX surface embedded into an Android game with custom cell composition.
- [korge](../findings/korlibs-korge.md) - `GameWindow` and Android-specific window implementations show how KorGE abstracts platform rendering surfaces.

## Gameplay Systems

- [antimine-android](../findings/lucasnlm-antimine-android.md) - no-guess generation, solver-backed validation, and board sizing logic are directly reusable gameplay-system patterns.

## Input And Controls

- [korge](../findings/korlibs-korge.md) - input and lifecycle hooks are centralized through `Stage` and `GameWindow`, which is useful for Android host integration.

## UI, HUD, And Menus

- [antimine-android](../findings/lucasnlm-antimine-android.md) - the LibGDX stage and actor layering demonstrate a custom in-game board UI inside a standard Android app shell.
- [ktx](../findings/libktx-ktx.md) - the Scene2D DSL is a strong pattern for reducing UI boilerplate in Kotlin game UIs.

## Physics And Collision

- No high-value physics findings were captured in this batch.

## Audio

- No audio-specific findings were captured in this batch.

## AI And Behavior

- [ktx](../findings/libktx-ktx.md) - the behavior-tree DSL shows a clean Kotlin wrapper for AI task composition.

## Persistence And Data

- [antimine-android](../findings/lucasnlm-antimine-android.md) - `SaveFileSerializer` demonstrates compact explicit binary save/load logic.
- [ktx](../findings/libktx-ktx.md) - `AssetStorage` exposes coroutine-first asset loading with progress and dependency tracking.

## Networking And Multiplayer

- No networking findings were captured in this batch.

## Tooling And Content Pipeline

- [korge](../findings/korlibs-korge.md) - the reload agent is a concrete hot-reload tooling pattern for game iteration.
- [ktx](../findings/libktx-ktx.md) - async asset loading is a reusable asset-pipeline foundation.
- [godot-kotlin-jvm](../findings/utopia-rise-godot-kotlin-jvm.md) - registration-file generation and the Gradle plugin are strong examples of engine-binding tooling.

## Android Platform Integration

- [antimine-android](../findings/lucasnlm-antimine-android.md) - separate `wear` and `auto` modules plus cloud-save wiring show unusually deep Android adaptation.
- [korge](../findings/korlibs-korge.md) - `KorgeAndroidView` and `AndroidGameWindowNoActivity` show host-view embedding without forcing a full activity-owned runtime.
- [godot-kotlin-jvm](../findings/utopia-rise-godot-kotlin-jvm.md) - Android export support includes explicit main-dex generation and plugin wiring.

## Performance And Memory

- [korge](../findings/korlibs-korge.md) - `GameWindowCoroutineDispatcher` budgets queued tasks per frame to protect frame time.
- [ktx](../findings/libktx-ktx.md) - render-thread dispatchers and background asset loading are directly useful for thread-aware Android game code.

## Build, Release, And Testing

- [godot-kotlin-jvm](../findings/utopia-rise-godot-kotlin-jvm.md) - the Gradle plugin, tooling model builder, harness tests, and Android dex task show a mature integration/build surface.
