# Sudoku

## Basic Info

- Project name: Sudoku
- Source repository: https://github.com/gzzrrg/Sudoku
- Author / organization: `gzzrrg`
- License: MIT
- Research note: [research/findings/gzzrrg-sudoku.md](../../research/findings/gzzrrg-sudoku.md)
- Investigated commit: `4df052231686556932c89f33aa4ca11e9f315946`
- Last verified: `2026-07-12`
- Activity / maintenance status: created `2026-07-01`, last pushed `2026-07-02`, not archived, 1 star at selection.

## Short Description

`Sudoku` is a direct Android Sudoku game written in Kotlin with Jetpack Compose, Material 3, MVVM-style `ViewModel` state, Room autosave, DataStore settings/statistics, Retrofit puzzle fetching, and a local backtracking generator fallback.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `2d`, `android`, `ui-hud`, `save-load`, `procedural-generation`
- Engine / framework: Android SDK, Jetpack Compose, AndroidX Lifecycle/ViewModel
- Rendering approach: Compose board cells plus `drawWithContent` grid overlays
- Main language(s): Kotlin
- Android target: direct Android app, `compileSdk` / `minSdk` / `targetSdk` `36`
- Build system: Gradle `9.4.1`, AGP `9.2.1`, Kotlin `2.2.10`, KSP

## Why It Matters

- It is a compact but product-shaped Android puzzle game, not just a one-screen demo.
- The project preserves a reusable session-state model for puzzle games: board snapshot, notes, undo/redo, hints, cumulative errors, timer, pause state, autosave, and completion records.
- It shows a practical content fallback pattern: try a remote puzzle API first, then generate a valid local puzzle when network/API access fails.

## Reusable Ideas

- Gameplay ideas: randomized Sudoku generation, uniqueness checking, mistake cap, limited hints, candidate-note mode, undo/redo over both values and notes.
- Architecture patterns: one game `ViewModel` owns the mutable session and exposes sealed UI states; repository hides Room/DataStore/Retrofit sources.
- Graphics / rendering techniques: Compose board grid with thick 3x3 separators drawn over regular cells.
- Input / UI approaches: separate board, toolbar, and number-pad Composables with portrait/wide layout switching.
- Performance or optimization ideas: pure 9x9 arrays for rule checks and generator logic; early-stop solution counting at two solutions.

## Notable Implementations

- `SudokuGenerator` creates complete boards with randomized backtracking, then removes cells while preserving unique solutions.
- `SudokuValidator` centralizes placement, conflict, completion, and same-value-highlight logic.
- `GameViewModel` owns timer, notes, undo/redo, hints, cumulative errors, pause/resume, completion/failure, and autosave.
- `GameSession` stores a full active-game snapshot in Room; `GameRecord` stores completed-game history separately.
- `SettingsDataStore` stores preferences and per-difficulty statistics.
- `SudokuRepository` chooses between dosuku API data and local generator fallback.

## Android Relevance

- Native Android use: direct Android app with Compose, Room, DataStore, Retrofit, Navigation Compose, and lifecycle-aware state.
- Kotlin relevance: the generator, validator, repository facade, sealed UI state, and ViewModel flow are Kotlin-first and easy to transplant.
- Porting or adaptation notes: lower `minSdk` before using the app as a real distribution baseline; add JVM tests for generator/validator and ViewModel tests for session persistence before copying the architecture into a production game.

## Risks / Limitations

- Very high `minSdk = 36` sharply limits device compatibility.
- Only template tests are visible.
- Local lab build discovery is blocked by Java `8`; Gradle `9.4.1` requires Java `17+`.
- The remote API fallback path and persistence recovery path are useful but not visibly covered by tests.

## Notes

Best reuse targets are the pure Sudoku generator/validator, the active-session Room snapshot model, the repository API-to-local fallback, and the Compose board/input component split.
