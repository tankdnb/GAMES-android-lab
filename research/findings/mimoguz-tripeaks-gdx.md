# Research Note

## Repository Snapshot

- Repository: `mimoguz/tripeaks-gdx`
- Source URL: [https://github.com/mimoguz/tripeaks-gdx](https://github.com/mimoguz/tripeaks-gdx)
- Owner: `mimoguz`
- Batch ID: [`BATCH-2026-06-04-AF`](../batches/BATCH-2026-06-04-AF.md)
- Type: `android-game`
- License: `GPL-3.0`
- Selection date: `2026-06-04`
- Last pushed at selection: `2025-03-15`
- Stars at selection: `88`
- Default branch at selection: `main`
- Investigated commit: `71d61a14441bd58a1160fd0bea7b1c7cb1e20047`
- Research status: `accepted`
- Build mode: `static-review + gradle-help-failed-java8-needs-java11`
- Catalog card: [catalog/projects/mimoguz-tripeaks-gdx.md](../../catalog/projects/mimoguz-tripeaks-gdx.md)

## Why This Repository Was Selected

- `tripeaks-gdx` came out of the refreshed exact-license shortlist as the best balance of public signal, direct game relevance, and expected code yield.
- The main question for this batch was whether the repository is only a small finished solitaire clone or whether it contains reusable Android and Kotlin patterns around board-state ownership, view synchronization, persistence, layout variants, and product packaging.
- The answer is `accepted`: the game is compact, but it is built as a real shared libGDX product with Android and desktop targets, layout-driven rules, explicit persistence migration, and a cleaner renderer or UI split than most small card-game samples.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: libGDX + LibKTX + Stripe UI + Android SDK + LWJGL3 desktop launcher
- Rendering stack: SpriteBatch-based 2D card renderer with a custom constant-height viewport, pooled view objects, and a framebuffer-backed blur or pixelate pass for paused start or game states
- Android target: direct Android application module with `minSdk 19`, `targetSdk 35`, `compileSdk 35`, immersive mode, and a shared asset directory
- Build system: Gradle `8.8` wrapper + AGP `8.5.2` + Kotlin `2.0.0` + Java target `17`
- Repository layout summary:
  - `core/` - gameplay state, layouts, services, screens, UI, render helpers, and assets wiring
  - `android/` - Android launcher, manifest, and shared-asset Android app packaging
  - `lwjgl3/` - desktop launcher and `construo` packaging flow
  - `assets/` - textures, shaders, fonts, atlases, localization bundles, and generated `assets.txt`
  - `fastlane/metadata/android/` - localized Play or F-Droid style store text and release metadata
- Source footprint:
  - total files counted in repository: `261`
  - Kotlin, Gradle, and Java files counted in repository: `54`
  - test files counted in repository: `0`
- Key modules reviewed:
  - `README.md`
  - `settings.gradle`
  - `build.gradle`
  - `gradle.properties`
  - `android/build.gradle`
  - `android/AndroidManifest.xml`
  - `android/src/main/kotlin/ogz/tripeaks/android/AndroidLauncher.kt`
  - `core/src/main/kotlin/ogz/tripeaks/Main.kt`
  - `core/src/main/kotlin/ogz/tripeaks/screens/LoadingScreen.kt`
  - `core/src/main/kotlin/ogz/tripeaks/screens/StartScreen.kt`
  - `core/src/main/kotlin/ogz/tripeaks/screens/StartScreenState.kt`
  - `core/src/main/kotlin/ogz/tripeaks/screens/GameScreen.kt`
  - `core/src/main/kotlin/ogz/tripeaks/screens/GameScreenState.kt`
  - `core/src/main/kotlin/ogz/tripeaks/screens/GameUi.kt`
  - `core/src/main/kotlin/ogz/tripeaks/models/GameState.kt`
  - `core/src/main/kotlin/ogz/tripeaks/models/GameStatistics.kt`
  - `core/src/main/kotlin/ogz/tripeaks/models/PlayerStatistics.kt`
  - `core/src/main/kotlin/ogz/tripeaks/models/LayoutStatistics.kt`
  - `core/src/main/kotlin/ogz/tripeaks/models/card/Card.kt`
  - `core/src/main/kotlin/ogz/tripeaks/models/layout/Layout.kt`
  - `core/src/main/kotlin/ogz/tripeaks/models/layout/BasicLayout.kt`
  - `core/src/main/kotlin/ogz/tripeaks/models/layout/Socket.kt`
  - `core/src/main/kotlin/ogz/tripeaks/services/PersistenceService.kt`
  - `core/src/main/kotlin/ogz/tripeaks/services/SettingsService.kt`
  - `core/src/main/kotlin/ogz/tripeaks/services/PlayerStatisticsService.kt`
  - `core/src/main/kotlin/ogz/tripeaks/views/GameView.kt`
  - `core/src/main/kotlin/ogz/tripeaks/views/AnimationStrategy.kt`
  - `core/src/main/kotlin/ogz/tripeaks/graphics/Renderer.kt`
  - `core/src/main/kotlin/ogz/tripeaks/graphics/CustomViewport.kt`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeded and reports:
  - Gradle `8.8`
  - launcher JVM `1.8.0_321`
- `cmd /c gradlew.bat help --no-daemon` failed in the lab because the Android Gradle Plugin already requires a newer JVM than the machine provides:
  - `Dependency requires at least JVM runtime version 11. This build uses a Java 8 JVM.`
- The checked-in build files also target a newer compile toolchain than the current lab:
  - Java source and target `17`
  - Android SDK `35`
  - AGP `8.5.2`
- No `src/test` or `src/androidTest` trees were found in the inspected revision.
- No `.github/workflows/` directory was found in the inspected default branch.
- The repository does expose real release or packaging intent despite the missing CI:
  - Play or F-Droid style badges and release links in `README.md`
  - localized `fastlane/metadata/android/`
  - desktop packaging via `io.github.fourlastor.construo`

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `3`
- Implementation depth: `2`
- Code clarity: `3`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - `tripeaks-gdx` is a compact but real product shell rather than a one-file toy. It has a reusable pure rules core, a layout-graph model, view pooling, save migration logic, and a practical Android plus desktop split.
  - The strongest reusable value is not solitaire itself. It is the way the project separates rules, layout geometry, UI anchoring, persistence, and rendering strategies while staying small enough to reread quickly.
  - It is held back by a missing automated test surface, no checked-in CI, and a public roadmap that already points readers toward a new reimplementation repository, but it still clears the bar for the main catalog.

## Interesting Findings

### Engine Architecture And Core Loop

- `core/src/main/kotlin/ogz/tripeaks/Main.kt` assembles the runtime through a small `ktx.inject.Context` rather than through singletons hidden across the codebase. Shared services such as settings, statistics, persistence, viewport, assets, and batch are bound once and then reused across screens.
- `core/src/main/kotlin/ogz/tripeaks/screens/LoadingScreen.kt` keeps startup explicit:
  - load atlases, fonts, bundles, and shader source first
  - initialize services only after assets are ready
  - then bind the normal and blurred renderers
- `core/src/main/kotlin/ogz/tripeaks/screens/GameScreenState.kt` and `StartScreenState.kt` split active and paused rendering behavior into small state objects instead of mixing pause effects into the main screen classes. That makes the blur or transition logic reusable and keeps screen classes closer to orchestration.

### Rendering And Graphics

- `core/src/main/kotlin/ogz/tripeaks/graphics/CustomViewport.kt` uses a constant world height plus a bounded even world width. That is a strong small-game pattern for keeping card proportions stable while still opening more horizontal space on larger screens.
- `core/src/main/kotlin/ogz/tripeaks/graphics/Renderer.kt` provides two very small renderers:
  - `SimpleRenderer` for the normal path
  - `BlurredRenderer` for paused or transitional states, using a framebuffer and shader-backed post-process
- `core/src/main/kotlin/ogz/tripeaks/views/GameView.kt` keeps rendering incremental:
  - card views are pooled
  - animation views are pooled
  - only the touched socket and its dependents are re-synced after a move
  - cards are z-sorted from layout metadata instead of by hand-written draw order

### Gameplay Systems

- `core/src/main/kotlin/ogz/tripeaks/models/GameState.kt` is a clean pure-Kotlin rules core. It owns:
  - tableau sockets
  - stack and discard piles
  - `emptyDiscard` variant logic
  - undo semantics
  - stalled and won detection
  - restart-from-initial-deal behavior through `t0Copy()`
- `core/src/main/kotlin/ogz/tripeaks/models/card/Card.kt` encodes card adjacency as circular consecutive rank logic, which is exactly the sort of tiny domain rule that is better kept in a pure helper than inside the UI or input layer.
- `core/src/main/kotlin/ogz/tripeaks/models/layout/Layout.kt`, `Socket.kt`, and the layout variants such as `BasicLayout.kt` show a reusable layout-graph idea: each tableau position explicitly records who blocks it and whom it blocks, which makes opening logic and view synchronization data-driven instead of positional or hard-coded.

### Input And Controls

- `core/src/main/kotlin/ogz/tripeaks/screens/GameUi.kt` is a good example of keeping HUD controls resolution-independent. Buttons are anchored relative to viewport edges, resized from sprite metrics, and use shared press or release handling instead of screen-specific listeners.
- `core/src/main/kotlin/ogz/tripeaks/screens/GameScreen.kt` resolves tableau input by converting touch coordinates into layout cells and then searching the top-most valid socket. That is a practical approach for layered 2D board input where visible overlap matters.
- The same screen keeps product actions very explicit:
  - deal
  - undo
  - menu
  - statistics
  - options
  - restart or new game

### UI, HUD, And Menus

- `StartScreen.kt`, `GameScreen.kt`, and the `screens/stage/*` dialogs show a well-contained libGDX UI shell built with Stripe `PopTable`, a themed custom skin, and separate menu plus dialog flows.
- `SettingsService.kt` and its `SettingsData` variants demonstrate a nice small-game settings model where visual theme, card-back design, layout family, animation strategy, drawing strategy, and game rule variant are all stored in one serializable settings object and re-expanded into runtime resources later.

### Persistence And Data

- `core/src/main/kotlin/ogz/tripeaks/services/PersistenceService.kt` is one of the stronger parts of the repository. It stores:
  - current game state
  - player statistics
  - settings
  as JSON inside LibGDX preferences, then validates and migrates old formats on load.
- The same service preserves backward compatibility through two migration paths:
  - `SettingsDataV1_1`
  - older raw preference keys from pre-`1.1`
- `PlayerStatisticsService.kt` and the statistics models keep meta progression simple but reusable: layout-specific stats are aggregated, longest chains are tracked, and the list is sorted by most-played layouts.

### Tooling And Content Pipeline

- The repository is more productized than its size suggests:
  - `fastlane/metadata/android/` keeps localized store text checked in
  - `lwjgl3/build.gradle` uses `construo` for desktop packaging
  - root `build.gradle` regenerates `assets/assets.txt` from the shared asset tree on compile
- `README.md` explicitly points readers to F-Droid, Google Play, and a successor reimplementation repository. That is useful context when judging whether the current codebase is still the long-term baseline or mostly a stable shipping branch.

### Android Platform Integration

- `android/AndroidManifest.xml` is intentionally game-oriented:
  - `android:isGame="true"`
  - `android:appCategory="game"`
  - landscape sensor orientation
  - immersive mode through the launcher
- `android/src/main/kotlin/ogz/tripeaks/android/AndroidLauncher.kt` forwards Android system dark-mode state into the shared runtime, which keeps the theme decision inside shared Kotlin code instead of scattering platform-specific theme branches through the app.
- `android/build.gradle` shows the usual but still useful shared-assets Android libGDX pattern:
  - core logic stays in `:core`
  - Android pulls from `../assets`
  - native `.so` files are copied into ABI folders only when needed

## Reusable Takeaways

- Small Android games benefit from a real shared rules core even when the game seems trivial at first glance.
- A layout graph made of sockets and blocker relationships is cleaner than ad hoc visibility rules for card, board, or stacked-object games.
- JSON-in-preferences can be acceptable for small shared game state if the code also validates loads and includes explicit legacy migration paths.
- Separate renderer strategies for normal, paused, and transition states make a small libGDX product easier to evolve than putting all post-processing inside one monolithic screen class.
- Even tiny projects benefit from checked-in release metadata and packaging scripts, because that preserves how the game actually ships, not just how it compiles locally.

## Evidence Summary

- `Main.kt` and `LoadingScreen.kt` - shared runtime assembly, asset bootstrap, and service initialization
- `GameScreen.kt` and `GameScreenState.kt` - screen orchestration, state-specific rendering, touch-to-tableau mapping, and pause/transition flow
- `GameState.kt`, `Card.kt`, and `layout/*` - pure rules core, layout graph, restart semantics, and stalled/win detection
- `GameView.kt`, `Renderer.kt`, and `CustomViewport.kt` - pooled view synchronization, post-process pause rendering, and constant-height viewport logic
- `PersistenceService.kt`, `SettingsService.kt`, and `PlayerStatisticsService.kt` - JSON persistence, settings reconstruction, and statistics aggregation or migration
- `AndroidLauncher.kt` and `AndroidManifest.xml` - immersive Android host shell and dark-mode forwarding
- `lwjgl3/build.gradle` and `fastlane/metadata/android/` - desktop packaging and mobile release metadata workflow

## Risks Or Limits

- The README already points users toward `TriPeaks NEUE`, so the current repository may be stable or maintainable but no longer the main future-facing implementation line.
- No automated tests were found in the inspected revision.
- No checked-in GitHub Actions or equivalent CI workflows were found either.
- Local build verification in the lab stops at the JVM floor because AGP `8.5.2` already needs Java `11+`, while actual compilation targets Java `17`.
- One verified code-quality caveat exists in `GameScreenState.kt`: `GameScreenSwitch.dispose()` iterates map entries instead of state values, so state-owned disposables are likely skipped on shutdown.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `android-game`
- Focus tags: `2d`, `android`, `libgdx`, `input`, `ui-hud`, `save-load`
- Follow-up needed:
  - if the lab revisits this repository, rerun Android tasks in a JDK `17+` plus Android SDK-ready environment, or isolate the layout-graph rules core, the JSON persistence plus migration path, or the renderer or viewport split instead of reopening the whole project broadly
