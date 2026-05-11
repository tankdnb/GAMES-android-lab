# Research Note

## Repository Snapshot

- Repository: `SimonSchubert/Braincup`
- Source URL: [https://github.com/SimonSchubert/Braincup](https://github.com/SimonSchubert/Braincup)
- Owner: `SimonSchubert`
- Batch ID: [`BATCH-2026-05-11-O`](../batches/BATCH-2026-05-11-O.md)
- Type: `android-game`
- License: `Apache-2.0`
- Selection date: `2026-05-11`
- Last pushed at selection: `2026-05-08`
- Stars at selection: `173`
- Investigated commit: `27000335bef3e0f8a3d59d19eaf21644d12f166b`
- Research status: `accepted`
- Build mode: `static-review + gradle-help-failed-java8-needs-java17`
- Catalog card: [catalog/projects/simonschubert-braincup.md](../../catalog/projects/simonschubert-braincup.md)

## Why This Repository Was Selected

- After the `jayasuryat/minesweeper-j-compose` batch, the refreshed shortlist still looked thin, but `Braincup` stood out because it is not just another tiny Android sample. It is an actively maintained Kotlin Multiplatform product with a direct Android target and a real collection of mini-games behind one shell.
- It looked stronger than the carry-over `yamin8000/Dooz` backlog candidate because the expected pattern surface is much broader: shared product navigation, per-game UI-state mapping, progression, persistence, session flow, platform `expect`/`actual` seams, screenshot tooling, and release packaging across Android, desktop, iOS, and web.
- The repository is also a useful contrast to the lab's existing LibGDX, custom-view, and single-game Compose references because it shows how a Kotlin/Compose game product can scale into a small multi-game platform without introducing a heavyweight external engine.

## Technical Profile

- Main language(s): Kotlin, with minor Shell, HTML, Ruby, and Swift support files
- Engine / framework: Kotlin Multiplatform + Compose Multiplatform + Android SDK + multiplatform-settings + coroutines
- Rendering stack: Compose UI and navigation shell, with each mini-game projected into immutable UI-state models instead of using a separate GL runtime
- Android target: direct Android app, plus iOS, desktop JVM, and web/WASM targets
- Build system: multi-module Gradle Kotlin DSL KMP project with `androidApp`, shared `composeApp`, and `screenshotTests`
- Repository layout summary:
  - `composeApp` owns most gameplay logic, shared UI, navigation, persistence wrappers, and platform seams
  - `androidApp` is a thin Android shell around the shared app
  - `screenshotTests` provides store-art and UI regression coverage with Paparazzi
- Source footprint:
  - total files reviewed in repository: `540`
  - Kotlin/Java files reviewed across the repository: `97`
- Test surface:
  - test files found: `6`
  - meaningful gameplay/unit test files found: `3`
  - screenshot/regression test files found: `3`
- Key modules reviewed:
  - `README.md`
  - `settings.gradle.kts`
  - `build.gradle.kts`
  - `composeApp/build.gradle.kts`
  - `androidApp/build.gradle.kts`
  - `composeApp/src/commonMain/kotlin/com/inspiredandroid/braincup/App.kt`
  - `composeApp/src/commonMain/kotlin/com/inspiredandroid/braincup/app/GameController.kt`
  - `composeApp/src/commonMain/kotlin/com/inspiredandroid/braincup/app/GameState.kt`
  - `composeApp/src/commonMain/kotlin/com/inspiredandroid/braincup/app/GameUiState.kt`
  - `composeApp/src/commonMain/kotlin/com/inspiredandroid/braincup/api/UserStorage.kt`
  - `composeApp/src/commonMain/kotlin/com/inspiredandroid/braincup/games/Game.kt`
  - `composeApp/src/commonMain/kotlin/com/inspiredandroid/braincup/games/GameType.kt`
  - representative shared mini-games: `MiniSudokuGame.kt`, `SlidingPuzzleGame.kt`, `VisualMemoryGame.kt`, `GhostGridGame.kt`, `OrbitTrackerGame.kt`, `MiniChessGame.kt`
  - `composeApp/src/commonMain/kotlin/com/inspiredandroid/braincup/games/minichess/ChessAi.kt`
  - `composeApp/src/commonMain/kotlin/com/inspiredandroid/braincup/games/minichess/ScenarioGenerator.kt`
  - `composeApp/src/commonTest/kotlin/com/inspiredandroid/braincup/games/minichess/ChessAiTest.kt`
  - `composeApp/src/commonTest/kotlin/com/inspiredandroid/braincup/games/minichess/ChessBoardTest.kt`
  - `composeApp/src/commonTest/kotlin/com/inspiredandroid/braincup/games/minichess/ScenarioGeneratorTest.kt`
  - `composeApp/src/androidMain/kotlin/com/inspiredandroid/braincup/AndroidApp.kt`
  - `composeApp/src/androidMain/kotlin/com/inspiredandroid/braincup/audio/AudioPlayer.android.kt`
  - `composeApp/src/androidMain/kotlin/com/inspiredandroid/braincup/haptic/HapticFeedback.android.kt`
  - `composeApp/src/nonIosMain/kotlin/com/inspiredandroid/braincup/navigation/AppNavHost.nonIos.kt`
  - `androidApp/src/main/kotlin/com/inspiredandroid/braincup/MainActivity.kt`
  - `screenshotTests/src/test/kotlin/com/inspiredandroid/braincup/screenshots/StoreScreenshotTest.kt`
  - `.github/workflows/build-release.yml`
  - `.github/workflows/pages.yml`
  - `.github/workflows/test.yml`
  - `.github/workflows/aur.yml`
  - `.github/workflows/flatpak.yml`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeds and reports Gradle `9.4.1` running on Java `1.8.0_321`.
- `cmd /c gradlew.bat help --no-daemon` fails immediately because the inspected build requires JVM `17+`, while the current lab machine still exposes Java `8`.
- The checked-in build surface confirms an actively maintained modern KMP product:
  - `settings.gradle.kts` includes `:androidApp`, `:composeApp`, and `:screenshotTests`
  - `composeApp/build.gradle.kts` targets Android, iOS, desktop JVM, and `wasmJs`, and sets Android JVM target `17`
  - `androidApp/build.gradle.kts` wraps the shared app and exposes `playStore` plus `foss` flavors
  - `compose.desktop` packaging is configured for DMG, MSI, DEB, RPM, and AppImage
- The workflow surface is unusually rich for a small game product:
  - `build-release.yml` packages Android, desktop, Linux, Flatpak, and Play Store artifacts from tags
  - `pages.yml` deploys the WASM build to GitHub Pages
  - `test.yml` updates screenshots and formatting in CI
  - `aur.yml` and `flatpak.yml` keep downstream packaging metadata in sync
- No runtime launch was attempted.
- Known setup limitations:
  - local Gradle verification is blocked first by the Java `17+` floor
  - Android/desktop/web packaging therefore remain code-verified but not locally executed in the lab
  - automated gameplay testing exists but is still selective and concentrated in the Mini Chess subsystem plus screenshot coverage

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `3`
- Implementation depth: `3`
- Code clarity: `2`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - this is a strong direct Android reference for a multi-game Kotlin product shell, not just for a single puzzle implementation
  - the repository combines reusable patterns in one place: shared controller/navigation shell, immutable per-game UI-state projection, daily-session progression, platform audio/haptic seams, and a meaningful release/test surface
  - the mini-game implementations are varied enough to offer reusable logic examples without turning the codebase into a full custom engine

## Interesting Findings

### Shared Product Shell And Minigame Runtime

- `composeApp/src/commonMain/kotlin/com/inspiredandroid/braincup/App.kt` is the key shell: one shared `NavController`, one `GameController`, platform audio/haptic hooks, and route-level screens for menu, instructions, gameplay, finish, scoreboards, achievements, session interstitials, and session completion.
- `composeApp/src/nonIosMain/kotlin/com/inspiredandroid/braincup/navigation/AppNavHost.nonIos.kt` adds an intentionally product-like transition policy to the shared navigation shell rather than treating the app as a raw activity-to-activity Android flow.
- `composeApp/src/commonMain/kotlin/com/inspiredandroid/braincup/games/Game.kt` keeps the gameplay contract minimal: each game owns round generation, answer checking, solution/hint output, and `toUiState()` projection, which lets the shell treat very different games through one controller API.
- `composeApp/src/commonMain/kotlin/com/inspiredandroid/braincup/app/GameUiState.kt` is a useful pattern on its own: every mini-game projects into a distinct immutable state object, so the shared UI shell does not need engine-specific mutable rendering objects.
- `composeApp/src/commonMain/kotlin/com/inspiredandroid/braincup/games/GameType.kt` centralizes metadata such as IDs, categories, medal thresholds, descriptions, and score direction (`lowerScoreIsBetter`), which is a clean way to drive progression and score presentation across many small modes.

### Progression, Sessions, And Persistence

- `composeApp/src/commonMain/kotlin/com/inspiredandroid/braincup/app/GameController.kt` is effectively the product orchestrator. It owns live `StateFlow`s for current game state, UI snapshot, timers, XP, highscores, achievements, session streaks, and last completed session.
- The same controller also shows a pragmatic hybrid architecture: common game flow is centralized, but special-case games branch into dedicated handlers when they need custom phase logic or non-timer scoring.
- `composeApp/src/commonMain/kotlin/com/inspiredandroid/braincup/api/UserStorage.kt` wraps `com.russhwolf.settings.Settings` into a real progression layer, not just key-value storage:
  - per-game highscores and score histories
  - adaptive last-round persistence
  - total XP and level thresholds
  - medal and streak achievements
  - daily 5-game session state
  - mute flag and mini-chess difficulty
- `GameController.finishCurrentGame()` plus `UserStorage.recordSessionCompleted()` show a reusable mobile-product pattern: chain several short games into one daily session, award both per-game score XP and session-completion XP, then roll streaks and level changes forward without requiring a heavy server-backed progression system.

### Reusable Mini-Game Logic

- `MiniSudokuGame.kt` is one of the stronger pure-logic references in the repository. It generates full `4x4` or `6x6` boards, removes clues while preserving uniqueness, and scales clue count by round.
- `SlidingPuzzleGame.kt` uses move-based shuffling from the solved state and avoids immediate undo moves, which is a compact way to keep generated sliding puzzles solvable without an external solver pass.
- `VisualMemoryGame.kt`, `GhostGridGame.kt`, and `OrbitTrackerGame.kt` show a good pattern for touch/mobile mini-games whose rules depend on timed phases:
  - state lives in the game object
  - coroutine jobs drive countdowns or animation phases
  - `toUiState()` exposes only what the screen needs
- `OrbitTrackerGame.kt` is especially useful because it implements moving targets, simple wall and ball-ball collisions, and a memory-selection phase without introducing a full physics engine dependency.
- `MiniChessGame.kt`, `ChessAi.kt`, and `ScenarioGenerator.kt` are the deepest subsystem in the repository:
  - custom `5x5` chess board and legal-move engine
  - weighted random scenario generation with difficulty-based material balance
  - alpha-beta AI with simple material plus center evaluation
  - difficulty-to-score mapping used directly by progression and medals
- The Mini Chess test surface is unusually strong for a small game product. `ChessBoardTest.kt`, `ChessAiTest.kt`, and `ScenarioGeneratorTest.kt` verify move legality, check/checkmate/stalemate, AI behavior, and generated-scenario quality.

### UI, Feedback, And Platform Seams

- `App.kt` plus the Android actuals for audio and haptics show a clean `expect`/`actual` seam for mobile-friendly feedback features without dragging platform code into shared gameplay logic.
- `composeApp/src/androidMain/kotlin/com/inspiredandroid/braincup/AndroidApp.kt` keeps Android-specific dynamic-color selection outside the shared app root, which is a useful pattern when the shared UI wants optional platform theming.
- `androidApp/src/main/kotlin/com/inspiredandroid/braincup/MainActivity.kt` is intentionally thin: splash screen, edge-to-edge setup, `setContent`, and an app-open counter that occasionally requests in-app review.
- The overall UI approach is useful for Android game products that are closer to app-like game collections than to one realtime scene: menu, achievements, instructions, scoreboards, and game screens all live comfortably in Compose without pretending to be a conventional engine scene graph.

### Tooling, Testing, And Distribution

- `screenshotTests/src/test/kotlin/com/inspiredandroid/braincup/screenshots/StoreScreenshotTest.kt` is a strong product-quality reference. It uses Paparazzi to render localized store screenshots across many locales from composed screen content instead of manually maintaining screenshot assets.
- The repository has broader public-release discipline than most small Kotlin game repos:
  - Android APK and AAB packaging
  - desktop installers for macOS, Windows, and Linux
  - WASM web deployment
  - AUR and Flatpak update workflows
- That makes `Braincup` valuable not only as a gameplay reference but also as a model for how to package a Kotlin/Compose game product for several consumer channels from one shared codebase.

## Reusable Takeaways

- A Kotlin game app with many small modes does not need a heavyweight engine if the shared shell standardizes navigation, scoring, progression, and immutable per-game UI-state snapshots.
- `expect`/`actual` seams for audio, haptics, and navigation let a shared Compose game shell stay mostly platform-agnostic while preserving mobile polish on Android.
- Daily-session loops, streaks, and XP can be implemented locally with a disciplined metadata layer instead of a backend, as long as game IDs, score directions, and thresholds are normalized.
- Small puzzle or memory games benefit from owning their own timed phases and projecting read-only UI snapshots, rather than exposing mutable internals directly to composables.
- Product-quality screenshot automation and multi-channel packaging are worth studying alongside gameplay code, because they are often the missing piece in otherwise promising Android game repos.

## Evidence Summary

- `App.kt`, `AppNavHost.nonIos.kt`, `GameController.kt`, `Game.kt`, and `GameUiState.kt` - shared multi-game shell, route flow, controller-owned state, and immutable UI-state projection
- `GameType.kt` and `UserStorage.kt` - metadata-driven score handling, XP, session flow, achievements, and multiplatform persistence
- `MiniSudokuGame.kt`, `SlidingPuzzleGame.kt`, `VisualMemoryGame.kt`, `GhostGridGame.kt`, and `OrbitTrackerGame.kt` - compact reusable puzzle/memory game logic patterns
- `MiniChessGame.kt`, `ChessAi.kt`, `ScenarioGenerator.kt`, and the `commonTest` chess suites - the deepest reusable subsystem, covering board logic, AI, scenario generation, and real tests
- `AndroidApp.kt`, `MainActivity.kt`, `AudioPlayer.android.kt`, and `HapticFeedback.android.kt` - thin Android shell plus platform feedback seams
- `StoreScreenshotTest.kt` and `.github/workflows/*` - screenshot regression/store-art generation, cross-platform packaging, GitHub Pages deployment, and downstream package maintenance

## Risks Or Limits

- `Braincup` is best treated as a multi-game product-shell reference, not as a general-purpose game engine baseline.
- `GameController.kt` is powerful but branch-heavy. The shared controller approach works well at this scale, but more games would probably justify decomposing special-case handlers into smaller modules.
- The product is broader than the lab's typical direct-game samples, so some value lives in app shell, progression, and packaging patterns rather than in pure rendering/runtime techniques.
- Local Gradle discovery is blocked in the lab because the inspected build now expects JVM `17+` while the machine still exposes Java `8`.
- The automated verification surface is meaningful but narrow: strong Mini Chess tests plus screenshot coverage, not a full test matrix for every mini-game.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `android-game`
- Focus tags: `android`, `multiplatform`, `ui-hud`, `input`, `audio`, `save-load`, `ai`, `testing`
- Follow-up needed:
  - if the lab revisits this repository later, rerun Gradle discovery or targeted tests in a real JDK `17+` environment
  - a narrower revisit could isolate the session/progression layer, the Mini Chess subsystem, or the screenshot/release pipeline instead of reopening the whole repository broadly
