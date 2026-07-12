# gzzrrg/Sudoku

## Repository Snapshot

- Repository: `gzzrrg/Sudoku`
- Source URL: https://github.com/gzzrrg/Sudoku
- Owner: `gzzrrg`
- Batch ID: `BATCH-2026-07-12-B`
- Type: `android-game`
- License: MIT
- Selection date: `2026-07-12`
- Last pushed at selection: `2026-07-02`
- Stars at selection: `1`
- Investigated commit: `4df052231686556932c89f33aa4ca11e9f315946`
- Research status: `accepted`
- Build mode: `static-review + gradle-version + gradle-help-failed-java8-needs-java17`
- Catalog card: [gzzrrg-sudoku](../../catalog/projects/gzzrrg-sudoku.md)

## Why This Repository Was Selected

- `gzzrrg/Sudoku` was the strongest queued explicit-license Kotlin Android game candidate after `BATCH-2026-07-12-A`.
- The repository is small enough for a complete static pass but has real product structure: Compose UI, MVVM, Room autosave, DataStore settings/statistics, Retrofit puzzle fetching, and a local Sudoku generator fallback.
- It gives the lab another direct Android puzzle-game reference, with better state/persistence depth than many tiny Compose examples.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: Android SDK, Jetpack Compose, Material 3, AndroidX Lifecycle/ViewModel
- Rendering stack: Compose layout and drawing, custom board grid lines through `drawWithContent`
- Android target: Android app module only; `compileSdk`, `minSdk`, and `targetSdk` are `36`
- Build system: Gradle `9.4.1`, AGP `9.2.1`, Kotlin `2.2.10`, KSP, Room, DataStore, Retrofit, Navigation Compose
- Repository layout summary: one `:app` module with `domain`, `data`, `di`, `ui`, and Android resource directories
- Key modules reviewed:
  - `app/src/main/java/com/zir/sudoku/domain/engine/`
  - `app/src/main/java/com/zir/sudoku/domain/model/`
  - `app/src/main/java/com/zir/sudoku/data/`
  - `app/src/main/java/com/zir/sudoku/ui/screen/game/`
  - `app/src/main/java/com/zir/sudoku/ui/navigation/`
  - `app/build.gradle.kts`
  - `gradle/libs.versions.toml`

## Build And Runtime Notes

- The repository was reviewed static-first. No runtime launch was attempted.
- `cmd /c gradlew.bat --version` succeeded and reported Gradle `9.4.1`; the lab launcher JVM is Java `1.8.0_321`.
- `cmd /c gradlew.bat help --no-daemon` failed because Gradle requires JVM `17+` while the lab currently exposes Java `8`.
- The project README says Android Studio, Android SDK `36`, and JDK `11+` are needed, but the checked Gradle wrapper itself now requires Java `17+`.
- The repository contains only template local/instrumented tests, so gameplay logic was not validated by upstream tests during this pass.

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `3`
- Implementation depth: `2`
- Code clarity: `3`
- Novelty: `2`
- Overall verdict: `accepted`
- Why: the game is a direct Android Kotlin puzzle app with a clear MVVM/repository shell, reusable Sudoku generation/validation, autosave/history, and adaptive Compose UI. It is not deeply tested and has very high SDK requirements, but the reusable product-state patterns are strong enough for the main catalog.

## Interesting Findings

### Engine Architecture And Core Loop

- `app/src/main/java/com/zir/sudoku/ui/screen/game/GameViewModel.kt:64` owns the full gameplay state instead of scattering mutable board state through Composables. It keeps `puzzle`, `solution`, `currentBoard`, notes, selection, timer, hints, error limit, undo stack, and redo stack behind one `StateFlow<GameUiState>` surface.
- `app/src/main/java/com/zir/sudoku/ui/screen/game/GameViewModel.kt:464` starts the timer lazily on the first meaningful action and updates active UI state every second. This is a practical pattern for puzzle games where elapsed time should not begin while the generated board is merely displayed.
- `app/src/main/java/com/zir/sudoku/ui/screen/game/GameUiState.kt:28` uses a sealed UI-state model (`Loading`, `Active`, `Paused`, `Completed`, `Failed`, `Error`) that makes the Compose screen render lifecycle states explicitly.
- `app/src/main/java/com/zir/sudoku/di/AppContainer.kt:30` uses a small manual dependency container rather than Hilt/Koin. For a small game, this keeps repository/database/API wiring visible and easy to reproduce.

### Rendering And Graphics

- `app/src/main/java/com/zir/sudoku/ui/screen/game/components/SudokuBoard.kt:58` renders a 9x9 board as Compose rows/cells while `drawWithContent` at line `70` overlays thin inner grid lines and thicker 3x3 box separators. This is a compact Compose-native board-rendering pattern without a custom `View`.
- `app/src/main/java/com/zir/sudoku/ui/screen/game/components/SudokuBoard.kt:116` derives per-cell visual state from `BoardState`: selected cell, related row/column/box, same-value highlights, conflicts, given numbers, user values, and wrong-but-not-conflicted values.
- `app/src/main/java/com/zir/sudoku/ui/screen/game/components/SudokuBoard.kt:188` renders notes as a 3x3 mini-grid inside an empty cell, which is directly reusable for Sudoku-like candidate-note UX.

### Gameplay Systems

- `app/src/main/java/com/zir/sudoku/domain/engine/SudokuGenerator.kt:33` creates a complete Sudoku board through randomized backtracking, then `generatePuzzle()` at line `62` removes cells according to difficulty.
- `app/src/main/java/com/zir/sudoku/domain/engine/SudokuGenerator.kt:95` validates generated puzzles by counting solutions and stopping early at two solutions. This gives a reusable "unique puzzle" safeguard for offline generation.
- `app/src/main/java/com/zir/sudoku/domain/engine/SudokuValidator.kt:22` centralizes row/column/box placement checks; `findConflicts()` at line `43`, `isComplete()` at line `57`, and `findSameValuePositions()` at line `67` reuse that core rule logic for UI feedback.
- `app/src/main/java/com/zir/sudoku/ui/screen/game/GameViewModel.kt:222` supports normal number entry and note-mode toggling from the same input path, clearing cell notes when a final value is entered.
- `app/src/main/java/com/zir/sudoku/ui/screen/game/GameViewModel.kt:370` implements a hint action that prefers the selected wrong/empty cell, falls back to the first unresolved cell, decrements a limited hint counter, and stores the hint as an undoable operation.
- `app/src/main/java/com/zir/sudoku/ui/screen/game/GameViewModel.kt:97` tracks cumulative error cells with a set of encoded coordinates; this intentionally keeps the mistake count from dropping through undo/erase.

### Input And Controls

- `app/src/main/java/com/zir/sudoku/ui/screen/game/components/NumberPad.kt:44` presents number input as a dedicated Compose control that can switch between compact single-row and wide two-row layouts.
- `app/src/main/java/com/zir/sudoku/ui/screen/game/components/GameToolBar.kt:60` groups erase, undo, redo, notes, and hint controls with active/disabled/badged states, giving a clear reusable puzzle-game toolbar shape.
- `app/src/main/java/com/zir/sudoku/ui/screen/game/GameViewModel.kt:324` and line `347` implement undo/redo by moving `Operation` snapshots between two stacks, including both value and note-set changes.

### UI, HUD, And Menus

- `app/src/main/java/com/zir/sudoku/ui/screen/game/GameScreen.kt:117` uses `BoxWithConstraints` to switch at `600.dp` between portrait and wider layouts. The wide layout keeps the board centered, moves status/actions into side panels, and reuses the same board/toolbar/numpad components.
- `app/src/main/java/com/zir/sudoku/ui/screen/game/GameScreen.kt:607` isolates the portrait status bar for difficulty, mistake count, and timer.
- `app/src/main/java/com/zir/sudoku/ui/navigation/NavGraph.kt:24` keeps the navigation graph compact: home, game with difficulty route parameter, settings, and a debug color screen.

### Persistence And Data

- `app/src/main/java/com/zir/sudoku/data/local/entity/GameSession.kt:27` stores the single active game snapshot as Room data: puzzle, solution, current board, notes, difficulty, timer, hint count, undo history, redo stack, and pause state.
- `app/src/main/java/com/zir/sudoku/ui/screen/game/GameViewModel.kt:593` autosaves the whole current session after meaningful user actions. This is a reusable pattern for mobile puzzle games where process death or back navigation should not lose progress.
- `app/src/main/java/com/zir/sudoku/data/local/entity/GameRecord.kt:24` and `GameRecordDao.kt:24` keep completed-game records separate from the active session, enabling history and aggregate queries.
- `app/src/main/java/com/zir/sudoku/data/local/datastore/SettingsDataStore.kt:31` uses Preferences DataStore for settings and per-difficulty statistics, while Room holds heavier game snapshots and records.
- `app/src/main/java/com/zir/sudoku/data/repository/SudokuRepository.kt:171` serializes boards and notes through Gson helper methods so the ViewModel does not need to know Room field formats.

### Networking And Multiplayer

- `app/src/main/java/com/zir/sudoku/data/remote/SudokuApiService.kt:32` defines a minimal Retrofit API for `GET api/dosuku`.
- `app/src/main/java/com/zir/sudoku/data/repository/SudokuRepository.kt:136` tries the remote dosuku API first and falls back to local generation on missing data or exceptions. This is useful for games that want online content freshness without becoming network-dependent.

### Android Platform Integration

- `app/build.gradle.kts:11` uses Android API `36`, and `app/build.gradle.kts:27` sets both `minSdk` and `targetSdk` to `36`. This is modern but very restrictive for real public Android distribution.
- `app/src/main/AndroidManifest.xml` declares `INTERNET` only, matching the remote-puzzle fetch requirement while keeping the app permission surface narrow.
- `app/src/main/java/com/zir/sudoku/MainActivity.kt` hosts the Compose app and reads settings to choose light/dark/white themes before building the navigation host.

### Build, Release, And Testing

- `gradle/libs.versions.toml:2` and `app/build.gradle.kts:65` show a modern Android stack: AGP `9.2.1`, Kotlin `2.2.10`, Compose BOM `2026.02.01`, Room, DataStore, Retrofit, Navigation Compose, coroutines, and KSP.
- `app/src/test/java/com/zir/sudoku/ExampleUnitTest.kt:12` and `app/src/androidTest/java/com/zir/sudoku/ExampleInstrumentedTest.kt:17` are template tests only. The interesting generator, validator, ViewModel, repository fallback, and persistence behavior currently lack visible automated tests.
- Local Gradle discovery stops before project configuration because Gradle `9.4.1` requires Java `17+`, while this lab exposes Java `8`.

## Reusable Takeaways

- Keep small puzzle-game state in one lifecycle-aware owner and expose a sealed UI state to Compose.
- Store active session snapshots separately from completed-game history.
- Let a repository layer choose between remote content and local deterministic fallback.
- Treat notes, undo/redo, timer, hint counters, and pause state as first-class save data, not as UI-only state.
- Use Compose board components plus `drawWithContent` grid overlays for compact board-game rendering.
- Add real tests around pure generator/validator code early; these files are highly testable and currently under-verified.

## Evidence Summary

- `domain/engine/SudokuGenerator.kt`: randomized backtracking generator and unique-solution check.
- `domain/engine/SudokuValidator.kt`: Sudoku rule validation and UI-feedback helpers.
- `domain/model/BoardState.kt`, `Cell.kt`, `Operation.kt`, `Difficulty.kt`: compact domain state model.
- `data/repository/SudokuRepository.kt`: Room/DataStore/API facade, remote-to-local fallback, JSON serialization helpers.
- `data/local/entity/GameSession.kt`, `GameRecord.kt`: active-session and history persistence schemas.
- `data/local/datastore/SettingsDataStore.kt`: settings and statistics storage.
- `ui/screen/game/GameViewModel.kt`: gameplay session, timer, hints, undo/redo, autosave, completion/failure.
- `ui/screen/game/components/SudokuBoard.kt`, `NumberPad.kt`, `GameToolBar.kt`: Compose board and input controls.
- `ui/screen/game/GameScreen.kt`: adaptive portrait/wide gameplay layout.
- `app/build.gradle.kts`, `gradle/libs.versions.toml`: Android/Compose/Room/DataStore/Retrofit build stack.

## Risks Or Limits

- `minSdk = 36` makes the app unsuitable as-is for broad Android device support.
- Tests are template-only, despite the generator/validator/ViewModel being good candidates for JVM tests.
- README and code comments are partly Chinese and displayed mojibake in the Windows terminal; code identifiers and paths were still inspectable.
- The remote API fallback path is pragmatic but not verified by local tests in the repository.
- Build validation needs Java `17+` and a current Android SDK; this lab only exposed Java `8` during the pass.

## Catalog Decision

- Keep in main catalog: yes
- Primary category: `android-game`
- Focus tags: `2d`, `android`, `ui-hud`, `save-load`, `procedural-generation`
- Follow-up needed: optional. If revisited, focus on extracting unit tests for `SudokuGenerator`, `SudokuValidator`, repository fallback behavior, and `GameViewModel` session persistence rather than reopening the UI broadly.
