# Research Note

## Repository Snapshot

- Repository: `Amigoconglomeration918/LinkGame`
- Source URL: [https://github.com/Amigoconglomeration918/LinkGame](https://github.com/Amigoconglomeration918/LinkGame)
- Owner: `Amigoconglomeration918`
- Batch ID: [`BATCH-2026-06-04-Z`](../batches/BATCH-2026-06-04-Z.md)
- Type: `android-game`
- License: `MIT`
- Selection date: `2026-06-04`
- Last pushed at selection: `2026-06-04`
- Stars at selection: `0`
- Default branch at selection: `main`
- Investigated commit: `60b5f85c1b243b99bae9977d5161e0138013354b`
- Research status: `accepted`
- Build mode: `static-review + gradle-help-failed-no-jdk`
- Catalog card: [catalog/projects/amigoconglomeration918-linkgame.md](../../catalog/projects/amigoconglomeration918-linkgame.md)

## Why This Repository Was Selected

- `LinkGame` was the next direct Android candidate in the carry-over explicit-license shortlist after the stronger higher-signal entries were exhausted.
- The main question for this batch was whether the repository is only a small casual-game shell or whether it still contains reusable Android patterns worth keeping in the main catalog.
- The answer is `accepted`: it is narrow and rough around the edges, but it still provides a clean Compose-first Android product shell, solvability-aware board generation, padded-grid pathfinding for tile-link rules, and useful local persistence plus audio-lifecycle patterns.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: Android SDK + Jetpack Compose + Material 3 + AndroidX Lifecycle/ViewModel + DataStore + MediaPlayer
- Rendering stack: Compose layout primitives and Material 3 surfaces, with a custom grid board rendered from `Box` / `Row` cells and overlay path or hint styling
- Android target: direct single-module Android app with `minSdk 24`, `targetSdk 36`, and `compileSdk 36`
- Build system: Gradle `8.13` wrapper + AGP `8.13.0` + Kotlin `2.3.0`
- Repository layout summary:
  - `app/` - the full Android application, including game logic, Compose UI, persistence, and audio
  - `gradle/` - wrapper and version catalog
- Source footprint:
  - total files counted in repository: `76`
  - Kotlin/Java files counted in repository: `31`
- Test surface:
  - files matching `*Test*.kt` or `*Test*.java`: `2`
  - both visible tests are template-level examples rather than gameplay or UI regression coverage
- Key modules reviewed:
  - `README.md`
  - `settings.gradle.kts`
  - `build.gradle.kts`
  - `gradle/libs.versions.toml`
  - `app/build.gradle.kts`
  - `app/src/main/AndroidManifest.xml`
  - `app/src/main/java/com/example/linkgame/LinkGameApplication.kt`
  - `app/src/main/java/com/example/linkgame/MainActivity.kt`
  - `app/src/main/java/com/example/linkgame/audio/AudioManager.kt`
  - `app/src/main/java/com/example/linkgame/game/engine/GameController.kt`
  - `app/src/main/java/com/example/linkgame/game/logic/BoardGenerator.kt`
  - `app/src/main/java/com/example/linkgame/game/logic/ConnectionChecker.kt`
  - `app/src/main/java/com/example/linkgame/game/logic/PathFinder.kt`
  - `app/src/main/java/com/example/linkgame/game/logic/Solver.kt`
  - `app/src/main/java/com/example/linkgame/game/model/Board.kt`
  - `app/src/main/java/com/example/linkgame/game/model/LevelConfig.kt`
  - `app/src/main/java/com/example/linkgame/data/repository/LeaderboardRepository.kt`
  - `app/src/main/java/com/example/linkgame/data/repository/NicknameRepository.kt`
  - `app/src/main/java/com/example/linkgame/data/repository/SettingsRepository.kt`
  - `app/src/main/java/com/example/linkgame/ui/navigation/GameNavHost.kt`
  - `app/src/main/java/com/example/linkgame/ui/screen/StartScreen.kt`
  - `app/src/main/java/com/example/linkgame/ui/screen/GameScreen.kt`
  - `app/src/main/java/com/example/linkgame/ui/screen/LeaderboardScreen.kt`
  - `app/src/main/java/com/example/linkgame/ui/components/GameBoard.kt`
  - `app/src/main/java/com/example/linkgame/ui/components/ScoreBar.kt`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeded and bootstrapped the wrapper, reporting Gradle `8.13` on the current Java `8` runtime.
- `cmd /c gradlew.bat help --no-daemon` failed in the lab with `No Java compiler found`, so even lightweight configuration currently stops because this environment exposes only a JRE without full JDK tools.
- `cmd /c gradlew.bat :app:testDebugUnitTest --dry-run --no-daemon` failed the same way, so no test discovery beyond the static tree was possible.
- The visible build surface suggests the repository expects a more modern local setup than the current lab machine:
  - AGP `8.13.0`
  - Gradle `8.13`
  - Java/Kotlin target `11`
- No checked-in GitHub Actions workflows or other visible CI automation were found.
- The checked-in README is a user-facing download guide rather than a developer-facing project document, and it points to a bundled zip artifact committed inside the source tree.

## Usefulness Assessment

- Reuse potential: `2`
- Android transfer: `3`
- Implementation depth: `2`
- Code clarity: `2`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - `LinkGame` is not deep enough to be a primary architecture reference on its own, but it is still a useful direct Android casual-game sample.
  - The best value is the combination of solvability-aware board generation, padded-grid connection and path reconstruction, Compose rendering that includes off-board path visualization, and simple but reusable DataStore plus audio-lifecycle seams.
  - The low test depth, rough build hygiene, and stray bundled artifacts keep it below the stronger Android references already in the lab.

## Interesting Findings

### Engine Architecture And Core Loop

- `app/src/main/java/com/example/linkgame/ui/navigation/GameNavHost.kt` uses a deliberately small navigation shell: one in-memory screen enum plus a random UUID `gameKey` to force a fresh `GameController` instance for each new run without a heavier Navigation Compose graph.
- `app/src/main/java/com/example/linkgame/game/engine/GameController.kt` keeps the entire active session in one `ViewModel`: board state, selected cells, hint markers, rendered path, timer, score, challenge progression, endless-level count, save prompts, and remaining-pair counts all live in one serializable-style UI state model.
- `app/src/main/java/com/example/linkgame/LinkGameApplication.kt` and `audio/AudioManager.kt` set up one process-level audio service early and bind it to `ProcessLifecycleOwner`, so background music pauses or resumes with app foreground state instead of relying on screen-specific code.

### Rendering And Graphics

- `app/src/main/java/com/example/linkgame/ui/components/GameBoard.kt` is the cleanest rendering takeaway in the repo. It renders not only the playable grid, but also a one-cell padded border around it, which allows the path overlay to visibly travel outside the board when the link rule needs outer-space routing.
- The same `GameBoard.kt` also layers several readable Compose-only states on top of the board:
  - pulsing gold hint borders
  - yellow selection highlight
  - cyan path fill for matched cells
  - dashed outline markers for off-board path segments
- `app/src/main/java/com/example/linkgame/ui/components/ScoreBar.kt` adds a useful micro-pattern for casual games: the last ten seconds pulse visually through animated font size, scale, and progress-bar color instead of relying only on numeric countdown.

### Gameplay Systems

- `app/src/main/java/com/example/linkgame/game/logic/BoardGenerator.kt` keeps board generation honest by looping until `isBoardSolvable` confirms that the shuffled layout can actually be cleared, with a fallback after `5000` failed generation attempts.
- `app/src/main/java/com/example/linkgame/game/logic/Solver.kt` implements that solvability check by repeatedly finding any valid removable pair and randomly clearing it across multiple attempts, which is a pragmatic puzzle-generation heuristic rather than a formal solver.
- `app/src/main/java/com/example/linkgame/game/logic/ConnectionChecker.kt` implements the core Lianliankan-style rule through BFS on a padded board and explicitly limits the route to at most two turns.
- `app/src/main/java/com/example/linkgame/game/logic/PathFinder.kt` reconstructs the actual route, not just the boolean answer, so the UI can render the player's successful link path directly.
- `app/src/main/java/com/example/linkgame/game/engine/GameController.kt` reuses the same board and timer ownership across both challenge and endless modes, with shared hint finding, tile removal, pair counting, and progression rules instead of splitting the app into separate controllers per mode.

### Input And Controls

- `app/src/main/java/com/example/linkgame/ui/components/GameBoard.kt` keeps tile input intentionally small and explicit: only non-empty interior cells are clickable, the same tap deselects the first choice, and all input becomes coordinate pairs before it reaches gameplay logic.
- `app/src/main/java/com/example/linkgame/ui/screen/GameScreen.kt` maps Android back handling into domain-specific exit behavior. Instead of leaving immediately, back closes the active dialog if present or opens the score-save or exit flow, which is a good small-product pattern for Android casual games.
- `app/src/main/java/com/example/linkgame/ui/screen/StartScreen.kt` treats endless-mode difficulty selection as an in-screen expansion and chip filter rather than a second setup screen, which keeps the product shell compact.

### UI, HUD, And Menus

- `app/src/main/java/com/example/linkgame/ui/screen/StartScreen.kt` composes a solid small-game shell: mode cards, persistent nickname strip, settings dialog, endless difficulty expansion, leaderboard entry point, and guarded app-exit dialog all live in one readable screen without a lot of scaffolding.
- `app/src/main/java/com/example/linkgame/ui/screen/LeaderboardScreen.kt` gives the local score history a more product-like shape than many tiny puzzle apps: challenge and endless tabs are split, endless scores can be filtered by difficulty, and entries support both individual deletion and full wipe.
- `app/src/main/java/com/example/linkgame/ui/screen/GameScreen.kt` cleanly separates HUD and board layers: top app bar for hint and exit, `ScoreBar` for session state, and one centered board card for actual play.

### Persistence And Data

- `app/src/main/java/com/example/linkgame/data/repository/LeaderboardRepository.kt` uses a compact pattern that is worth reusing in other small Android games: keep leaderboard state in `DataStore<Preferences>` as one serialized JSON list, sort it by score descending and time ascending on write, and expose it as a `Flow`.
- `app/src/main/java/com/example/linkgame/data/repository/SettingsRepository.kt` splits product settings cleanly into BGM enabled, sound enabled, and BGM type flows instead of hiding them inside the activity or the audio manager itself.
- `app/src/main/java/com/example/linkgame/data/repository/NicknameRepository.kt` keeps player identity as a separate persistence concern from leaderboard data and runtime session state.
- `app/src/main/java/com/example/linkgame/game/engine/GameController.kt` calculates total elapsed run time when saving score and writes the nickname back before storing the entry, which keeps one consistent local profile surface.

### Build, Release, And Testing

- `app/build.gradle.kts` and `gradle/libs.versions.toml` show a current single-module Android Compose build around AGP `8.13.0`, Kotlin `2.3.0`, `compileSdk 36`, and `minSdk 24`.
- The repository is still rough as a build reference:
  - `settings.gradle.kts` depends on several Aliyun mirror repositories in addition to Google and Maven Central
  - `gradle/wrapper/gradle-wrapper.properties` points to a Tencent Gradle mirror
  - the version catalog includes duplicate module declarations and drift, including two `kotlinx-serialization-json` versions and two different lifecycle-process aliases
- The visible automated test surface is effectively template-only:
  - `app/src/test/java/com/example/linkgame/ExampleUnitTest.kt`
  - `app/src/androidTest/java/com/example/linkgame/ExampleInstrumentedTest.kt`
- No CI workflows or real build verification automation were found in the checked-in tree.

## Reusable Takeaways

- For link-style puzzle games, render a padded outer board region so the same rule logic and the same UI can both support routes that leave the visible grid.
- Generate puzzle boards in a loop until a lightweight solver says the layout is actually playable, and keep a simple emergency fallback instead of risking soft-locked boards.
- Small Android casual games benefit from splitting local persistence by concern:
  - leaderboard
  - nickname
  - runtime settings
- Process-lifecycle-aware audio management is a good lightweight alternative to duplicating BGM start or stop logic inside every screen.
- A simple screen enum plus a fresh key can be enough to reset `ViewModel`-owned game sessions in a compact Compose app without introducing a heavier navigation stack too early.

## Evidence Summary

- `GameNavHost.kt`, `GameScreen.kt`, and `GameController.kt` - manual screen routing, session reset strategy, and central game-state ownership
- `BoardGenerator.kt`, `Solver.kt`, `ConnectionChecker.kt`, and `PathFinder.kt` - solvability-checked generation plus padded-grid matching and route reconstruction
- `GameBoard.kt` and `ScoreBar.kt` - Compose board rendering with off-board path visualization and warning-state HUD animation
- `LeaderboardRepository.kt`, `SettingsRepository.kt`, and `NicknameRepository.kt` - compact DataStore-backed local persistence seams
- `AudioManager.kt`, `LinkGameApplication.kt`, and `MainActivity.kt` - process-level audio ownership, foreground/background handling, and the app exit path

## Risks Or Limits

- The repository has zero stars and no visible CI, so confidence comes mostly from static readability rather than public or automated signal.
- The automated test surface is effectively absent beyond template examples.
- `GameController.kt` stores a raw `Context` inside a `ViewModel`, which is a risky ownership pattern for a lifecycle object that may outlive one activity instance.
- `MainActivity.exitApp()` calls `killProcess(...)` after `finishAffinity()`, which is an aggressive exit pattern and not a reusable Android best practice.
- `GameScreen.kt` still contains an apparently orphaned `showSaveDialog` / `totalTimeSeconds` path that is never activated from `GameController.kt`.
- `app/build.gradle.kts` and `gradle/libs.versions.toml` show dependency drift, including duplicate `kotlinx-serialization-json` declarations with different versions.
- The checked-in README and bundled `app/src/main/java/com/example/linkgame/ui/navigation/Game-Link-v3.3.zip` artifact suggest the repository is maintained partly as a downloadable app drop rather than as a clean code-first development workspace.
- UI strings appear to be Chinese-first, which is fine for the product but narrows direct reuse of content or UX copy outside that locale.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `android-game`
- Focus tags: `2d`, `android`, `input`, `ui-hud`, `audio`, `save-load`, `procedural-generation`
- Follow-up needed:
  - if the lab revisits this repository, rerun Gradle discovery or Android tasks in a real JDK-backed SDK-ready environment, or isolate the solvability-aware board generator, the padded-grid pathfinding plus overlay renderer, or the DataStore and audio-lifecycle shell instead of reopening the whole app broadly
