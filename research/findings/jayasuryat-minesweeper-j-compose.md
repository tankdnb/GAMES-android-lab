# Research Note

## Repository Snapshot

- Repository: `jayasuryat/minesweeper-j-compose`
- Source URL: [https://github.com/jayasuryat/minesweeper-j-compose](https://github.com/jayasuryat/minesweeper-j-compose)
- Owner: `jayasuryat`
- Batch ID: [`BATCH-2026-05-11-N`](../batches/BATCH-2026-05-11-N.md)
- Type: `android-game`
- License: `Apache-2.0`
- Selection date: `2026-05-11`
- Last pushed at selection: `2024-07-12`
- Stars at selection: `98`
- Investigated commit: `92ef8a0c17172c684af00c143fb72154aec0750c`
- Research status: `accepted`
- Build mode: `static-review + gradle-help-failed-no-jdk`
- Catalog card: [catalog/projects/jayasuryat-minesweeper-j-compose.md](../../catalog/projects/jayasuryat-minesweeper-j-compose.md)

## Why This Repository Was Selected

- The shortlist after `blueUserRed/forty-five` was still thin, but `minesweeper-j-compose` stood out because it is a direct Android Kotlin game with a permissive Apache-2.0 license and a clearly modular codebase instead of a one-screen sample.
- It looked stronger than the carry-over `yamin8000/Dooz` backlog candidate because it splits gameplay engine, reusable grid UI, feature screens, and persistence into separate modules with a larger expected pattern surface.
- The repository also promised a useful contrast to the lab's existing LibGDX and custom-view puzzle references by showing how far a small Android puzzle game can go with Jetpack Compose plus a dedicated pure Kotlin engine layer.

## Technical Profile

- Main language(s): Kotlin, Ruby (minor CocoaPods metadata)
- Engine / framework: Android SDK + Jetpack Compose + custom minesweeper engine + Koin + coroutines
- Rendering stack: Compose-driven UI and grid rendering with custom pinch-zoom/pan transforms applied through `graphicsLayer`
- Android target: direct Android app; the shared `data` module also includes iOS targets, but gameplay/UI remain Android-specific
- Build system: multi-module Gradle Kotlin DSL Android project with a Kotlin Multiplatform `data` module and SQLDelight persistence
- Repository layout summary: `app` owns the Android shell and DI wiring, `ui-game` / `ui-difficulty-selection` / `ui-settings` hold feature screens, `minesweeper-engine` and `minesweeper-ui` separate core puzzle logic from grid rendering, and `data` holds KMM persistence/preferences infrastructure
- Source footprint:
  - total files reviewed in repository: `252`
  - Kotlin/Java files reviewed across the repository: `164`
- Test surface:
  - test files found: `1`
  - meaningful automated gameplay tests found: `0`
- Key modules reviewed:
  - `README.md`
  - `settings.gradle.kts`
  - `build.gradle.kts`
  - `app/build.gradle.kts`
  - `data/build.gradle.kts`
  - `ui-game/build.gradle.kts`
  - `minesweeper-engine/build.gradle.kts`
  - `app/src/main/java/com/jayasuryat/minesweeperjc/MinesweeperApp.kt`
  - `app/src/main/java/com/jayasuryat/minesweeperjc/presentation/MainActivity.kt`
  - `app/src/main/java/com/jayasuryat/minesweeperjc/presentation/Minesweeper.kt`
  - `app/src/main/java/com/jayasuryat/minesweeperjc/presentation/Screen.kt`
  - `ui-game/src/main/java/com/jayasuryat/uigame/GameViewModel.kt`
  - `ui-game/src/main/java/com/jayasuryat/uigame/GameScreen.kt`
  - `ui-game/src/main/java/com/jayasuryat/uigame/logic/interactionlistener/ActionListener.kt`
  - `ui-difficulty-selection/src/main/java/com/jayasuryat/difficultyselection/logic/DifficultySelectionViewModel.kt`
  - `ui-settings/src/main/java/com/jayasuryat/uisettings/logic/SettingsViewModel.kt`
  - `minesweeper-engine/src/main/java/com/jayasuryat/minesweeperengine/gridGenerator/MineGridGenerator.kt`
  - `minesweeper-engine/src/main/java/com/jayasuryat/minesweeperengine/controller/impl/GameController.kt`
  - `minesweeper-engine/src/main/java/com/jayasuryat/minesweeperengine/controller/impl/handler/CellRevealer.kt`
  - `minesweeper-engine/src/main/java/com/jayasuryat/minesweeperengine/controller/impl/handler/ValueCellRevealer.kt`
  - `minesweeper-engine/src/main/java/com/jayasuryat/minesweeperengine/controller/impl/handler/helper/*`
  - `minesweeper-ui/src/main/java/com/jayasuryat/minesweeperui/component/ZoomableContent.kt`
  - `minesweeper-ui/src/main/java/com/jayasuryat/minesweeperui/grid/Minefield.kt`
  - `app/src/main/java/com/jayasuryat/minesweeperjc/data/initialgrid/InitialGridProviderImpl.kt`
  - `app/src/main/java/com/jayasuryat/minesweeperjc/data/source/InProgressGamesProviderImpl.kt`
  - `app/src/main/java/com/jayasuryat/minesweeperjc/data/source/GameDataPersister.kt`
  - `app/src/main/java/com/jayasuryat/minesweeperjc/data/source/GameDataSourceImpl.kt`
  - `app/src/main/java/com/jayasuryat/minesweeperjc/data/mapper/impl/GridWriteMapperImpl.kt`
  - `app/src/main/java/com/jayasuryat/minesweeperjc/data/mapper/impl/GridReadMapperImpl.kt`
  - `data/src/commonMain/kotlin/com/jayasuryat/data/source/impl/GameDataSourceImpl.kt`
  - `data/src/commonMain/kotlin/com/jayasuryat/data/source/impl/UserPreferencesImpl.kt`
  - `data/src/commonMain/kotlin/com/jayasuryat/data/store/DataStore.kt`
  - `app/src/main/java/com/jayasuryat/minesweeperjc/data/SettingsChangeEventListener.kt`
  - `ui-game/src/main/java/com/jayasuryat/uigame/feedback/sound/MusicManager.kt`
  - `ui-game/src/main/java/com/jayasuryat/uigame/feedback/vibration/VibrationManager.kt`
  - `ui-game/src/main/java/com/jayasuryat/uigame/composable/feedback/GameFeedback.kt`
  - `minesweeper-engine-debug/src/main/java/com/jayasuryat/minesweeperenginedebug/test/GridGeneratorTest.kt`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeds and reports Gradle `7.5` running on Java `1.8.0_321`.
- `cmd /c gradlew.bat help --no-daemon` fails at `:buildSrc:compileKotlin` because Kotlin cannot find the required JDK tools; the current lab machine still exposes a Java `8` runtime without a full JDK/compiler.
- The checked-in build surface confirms a moderately modern Android/Kotlin stack for its era:
  - root `build.gradle.kts` pins Android Gradle Plugin `7.4.2`, Kotlin `1.8.10`, SQLDelight `1.5.5`, and Spotless
  - `gradle/wrapper/gradle-wrapper.properties` pins Gradle `7.5`
  - `settings.gradle.kts` shows `app`, `util`, `data`, `ui-game`, `ui-difficulty-selection`, `ui-settings`, `core:minesweeper-engine`, `core:minesweeper-ui`, and `core:minesweeper-engine-debug`
- `data/build.gradle.kts` confirms a real Kotlin Multiplatform persistence layer for Android and iOS rather than an Android-only persistence helper.
- No runtime launch was attempted.
- Known setup limitations:
  - local build validation is blocked first by the missing JDK tools on the lab machine
  - even after that, the Android Gradle stack should be assumed to need a newer JDK than the current Java `8` runtime
  - the verification surface is weak because the only test-like file is a debug-side `main()` helper rather than a normal automated test suite

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `3`
- Implementation depth: `3`
- Code clarity: `2`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - this is one of the clearer direct Android Compose puzzle references in the lab because it keeps the puzzle engine, grid UI, feature screens, and persistence boundaries separate
  - the repository combines several transferable mobile-game patterns in one compact package: deferred safe-first-click generation, zoomable large-board handling, save/resume snapshots, difficulty-aware resume UX, and preference-gated sound/vibration feedback
  - it is not a perfect verification baseline because the automated tests are essentially absent and the build was not confirmed locally, but the code surface is still rich enough to justify catalog inclusion

## Interesting Findings

### Engine Architecture And Core Loop

- `minesweeper-engine/src/main/java/com/jayasuryat/minesweeperengine/controller/impl/GameController.kt` implements a clean action-to-event reducer boundary: UI code sends `MinefieldAction`, and the engine responds with `MinefieldEvent` through dedicated handlers for reveal, flag toggle, and value-cell chord actions.
- `ui-game/src/main/java/com/jayasuryat/uigame/logic/interactionlistener/ActionListener.kt` is the central orchestration seam. It owns the live `StatefulGrid`, translates UI interactions into engine actions, defers real grid generation until the first reveal, updates progress/state, and keeps audio/vibration side effects outside the engine core.
- `ui-game/src/main/java/com/jayasuryat/uigame/GameViewModel.kt` loads the initial grid off the main thread, constructs the interaction listener, and disables per-cell animations when the board size exceeds `300`, which is a pragmatic large-board mobile safeguard.
- `ui-difficulty-selection/src/main/java/com/jayasuryat/difficultyselection/logic/DifficultySelectionViewModel.kt` and `app/src/main/java/com/jayasuryat/minesweeperjc/data/source/InProgressGamesProviderImpl.kt` show a lightweight resume-aware difficulty screen: difficulties are decorated with "in progress" state by checking persisted game IDs instead of duplicating full save metadata in the menu layer.

### Rendering And Graphics

- `minesweeper-ui/src/main/java/com/jayasuryat/minesweeperui/component/ZoomableContent.kt` contains a reusable Compose pinch-zoom/pan container with clamped scale (`1f..3f`), bounded translation, and explicit multi-touch consumption so pinch gestures do not accidentally trigger cell taps or long-presses.
- `minesweeper-ui/src/main/java/com/jayasuryat/minesweeperui/grid/Minefield.kt` persists zoom/pan state with `rememberSaveable` and re-applies it through `graphicsLayer`, which is a useful pattern for grid-heavy puzzle boards that players revisit across configuration changes.
- `app/src/main/java/com/jayasuryat/minesweeperjc/presentation/MainActivity.kt` and `app/src/main/java/com/jayasuryat/minesweeperjc/presentation/Minesweeper.kt` show a single-activity Compose shell with transparent status-bar handling, circular reveal launch, and animated screen transitions rather than a second rendering runtime.

### Gameplay Systems

- `minesweeper-engine/src/main/java/com/jayasuryat/minesweeperengine/gridGenerator/MineGridGenerator.kt` implements safe-first-click generation by excluding the whole `3x3` block around the starting position from mine placement, then backfilling neighbour counts after mine injection.
- `ui-game/src/main/java/com/jayasuryat/uigame/logic/interactionlistener/ActionListener.kt` performs the first move in two steps: generate the real grid around the clicked cell, replace the placeholder empty grid, then re-dispatch the original reveal into the engine. That keeps "safe first click" as a general startup policy rather than as a special case in the reveal handlers.
- `minesweeper-engine/src/main/java/com/jayasuryat/minesweeperengine/controller/impl/handler/helper/ValueNeighbourCalculator.kt` flood-fills connected empty cells while also revealing the bordering numbered cells, skipping already revealed or flagged neighbours.
- `minesweeper-engine/src/main/java/com/jayasuryat/minesweeperengine/controller/impl/handler/ValueCellRevealer.kt` implements chord-click solving for numbered cells: it compares surrounding flag count to surrounding mine count, reveals all hidden neighbours when the flags are correct, and triggers full-game reveal when the flags are wrong.
- `minesweeper-engine/src/main/java/com/jayasuryat/minesweeperengine/controller/impl/handler/helper/GameEndRevealer.kt` plus `RadiallySorter.kt` sort final cell updates radially outward from the triggering position, which gives the UI a stable wave-like reveal order for loss animations.

### Input And Controls

- `ui-game/src/main/java/com/jayasuryat/uigame/logic/interactionlistener/ActionListener.kt` swaps the meaning of tap and long-press based on the live quick-toggle mode, while still preserving number-cell chording and explicit handling for flagged vs unflagged cells. This is a strong touch-puzzle pattern because it lets users bias the UI toward reveal-first or flag-first play without branching the engine rules.
- The same file keeps idle-state behavior safe: in flag-first mode, tapping an unrevealed cell before the first move still reveals rather than flags so the game can initialize from a genuine first click.
- `minesweeper-ui/src/main/java/com/jayasuryat/minesweeperui/component/ZoomableContent.kt` explicitly consumes pointer changes during multi-finger gestures, which is a small but important mobile UX detail for zoomable puzzle boards.

### UI, HUD, And Menus

- `app/src/main/java/com/jayasuryat/minesweeperjc/presentation/Minesweeper.kt` keeps difficulty selection, settings, and the minefield screen as separate animated routes and chooses between resumable-vs-new-grid providers through DI, not by duplicating screen logic.
- `ui-game/src/main/java/com/jayasuryat/uigame/GameScreen.kt` composes the board, top bar, feedback hooks, and optional quick-toggle overlay in one place and saves progress on both `Lifecycle.Event.ON_STOP` and composition disposal.
- `ui-settings/src/main/java/com/jayasuryat/uisettings/logic/SettingsViewModel.kt` updates UI state optimistically, while `app/src/main/java/com/jayasuryat/minesweeperjc/data/SettingsChangeEventListener.kt` persists sound, vibration, show-toggle, and default-toggle settings asynchronously through the shared preferences abstraction.

### Physics And Collision

- No significant physics or collision systems were relevant in this repository; its value is in grid-based puzzle logic and mobile UI patterns rather than in motion-heavy gameplay.

### Tooling, Android Integration, Or Other Notable Areas

- `data/build.gradle.kts` is a useful architectural signal on its own: the repository keeps persistence in a Kotlin Multiplatform module with SQLDelight, Koin, Kotlin serialization, and `com.russhwolf.settings`, even though the actual game/UI shell is Android-only.
- `app/src/main/java/com/jayasuryat/minesweeperjc/data/mapper/impl/GridWriteMapperImpl.kt`, `GridReadMapperImpl.kt`, `GameDataPersister.kt`, and `data/src/commonMain/kotlin/com/jayasuryat/data/source/impl/GameDataSourceImpl.kt` persist whole-grid snapshots as serialized cell matrices. Saves are keyed deterministically by difficulty (`rows x columns ? mines`) so the app can treat each difficulty as one resumable slot.
- `data/src/commonMain/kotlin/com/jayasuryat/data/source/impl/UserPreferencesImpl.kt` and `data/src/commonMain/kotlin/com/jayasuryat/data/store/DataStore.kt` keep sound/vibration/toggle preferences behind a small cross-platform store wrapper instead of scattering direct preference calls across Android UI classes.
- `ui-game/src/main/java/com/jayasuryat/uigame/composable/feedback/GameFeedback.kt`, `feedback/sound/MusicManager.kt`, and `feedback/vibration/VibrationManager.kt` show a neat preference-gated feedback seam: game-end signals stay declarative in UI state, while the actual media/vibration details live behind dedicated managers.

## Reusable Takeaways

- Even a small Android Compose game benefits from a separate pure puzzle engine that speaks in actions/events rather than mutating Compose state directly.
- Deferring actual board generation until the first reveal is a clean way to guarantee a safe opening move without special restart or tutorial logic.
- A zoomable puzzle board can stay inside normal Compose UI if pinch/pan, transform bounds, and accidental multi-touch tap suppression are handled explicitly.
- Save/resume can remain simple when game slots are keyed by difficulty and the persisted payload is just a serialized grid snapshot plus elapsed time.
- Resume-aware difficulty menus and quick-toggle input preferences are small product details, but they materially improve mobile puzzle UX and are worth reusing.

## Evidence Summary

- `ui-game/logic/interactionlistener/ActionListener.kt` - first-click orchestration, reveal/flag mode mapping, progress updates, and per-cell feedback triggering
- `ui-game/GameViewModel.kt` - off-main loading, large-board animation cutoff, and save-on-state-change wiring
- `minesweeper-engine/gridGenerator/MineGridGenerator.kt` - safe-first-click grid generation and neighbour-count filling
- `minesweeper-engine/controller/impl/*` - action-reducer engine, chord-click logic, recursive reveal, success detection, and radial reveal ordering
- `minesweeper-ui/component/ZoomableContent.kt` and `minesweeper-ui/grid/Minefield.kt` - clamped pinch-zoom/pan with saveable transform state
- `app/presentation/Minesweeper.kt` and `MainActivity.kt` - Compose app shell, animated routes, transparent status bar, and DI-switched new/resume entry flow
- `app/data/*` and `data/src/commonMain/*` - KMM persistence/preferences layer, SQLDelight save storage, and deterministic difficulty-based save IDs
- `ui-difficulty-selection/*` and `ui-settings/*` - resume-aware difficulty items and split UI/persistence settings handling
- `minesweeper-engine-debug/test/GridGeneratorTest.kt` - only visible test-like file; useful as a quick debug generator probe, but not real automated coverage

## Risks Or Limits

- The repository is no longer fresh. At selection time it was last pushed on `2024-07-12`, so it should be treated as a strong 2022-2024-era Compose puzzle reference rather than as a state-of-the-art Android stack example.
- The build stack is older and local validation is incomplete: Gradle `7.5`, AGP `7.4.2`, Kotlin `1.8.10`, and the current lab machine still exposes only a Java `8` runtime without JDK tools.
- The verification surface is weak. The only visible test-like file is a debug-side `main()` helper under `minesweeper-engine-debug`, not a normal unit or instrumentation test suite.
- The KMM angle is useful but limited: only the `data` module is multiplatform, while the gameplay/UI flow remains Android-specific.
- The project is a strong small-game reference, but some orchestration layers still couple mutable Compose state, feedback side effects, and gameplay progression more tightly than a larger reusable engine would.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `android-game`
- Focus tags: `2d`, `android`, `input`, `ui-hud`, `save-load`, `procedural-generation`
- Follow-up needed:
  - if the lab revisits this repository later, rerun Gradle discovery or tests in a full JDK `11+` Android environment
  - a narrower revisit could isolate the safe-first-click generator, the zoomable Compose board shell, or the save/resume snapshot pipeline instead of reopening the whole repository broadly
