# Research Note

## Repository Snapshot

- Repository: `mshdabiola/Naijaludo`
- Source URL: [https://github.com/mshdabiola/Naijaludo](https://github.com/mshdabiola/Naijaludo)
- Owner: `mshdabiola`
- Batch ID: [`BATCH-2026-06-04-AJ`](../batches/BATCH-2026-06-04-AJ.md)
- Type: `android-game`
- License: `GPL-3.0`
- Selection date: `2026-06-04`
- Last pushed at selection: `2025-10-27`
- Stars at selection: `15`
- Default branch at selection: `develop`
- Investigated commit: `013e99dca4a65709d5cf81995ba8c384e6a48ba9`
- Research status: `accepted`
- Build mode: `static-review + gradle-help-failed-no-jdk-compiler`
- Catalog card: [catalog/projects/mshdabiola-naijaludo.md](../../catalog/projects/mshdabiola-naijaludo.md)

## Why This Repository Was Selected

- `Naijaludo` was selected after the shortlist refresh because it had the strongest balance of direct Android relevance, explicit license metadata, visible public signal, and expected code-reading yield among the remaining exact-license candidates.
- The main question for this batch was whether the repository is just another casual Android board game, or whether it contains reusable architecture and product-shell ideas worth preserving in the main catalog.
- The answer is `accepted`: it is a real Android-first Kotlin Multiplatform game product with a reusable board-game core, save-and-resume seams, modular feature boundaries, and stronger productization discipline than its star count suggests.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: Kotlin Multiplatform + Jetpack Compose + Compose Desktop + WASM + Koin + DataStore + screenshot/baseline-profile tooling
- Rendering stack: Compose UI on Android/Desktop/WASM with custom board drawing and feature-level Compose screens
- Android target: direct Android app with `GooglePlay` and `FossReliant` variants
- Build system: Gradle `8.13` wrapper + AGP `8.8.1` + Kotlin `2.1.10` + Compose plugin `1.8.0`
- Repository layout summary:
  - `app/` - multiplatform application packaging for Android, JVM desktop, and WASM
  - `features/` - feature-level UI and orchestration modules such as `main`, `game`, `market`, and `setting`
  - `modules/naijaludo/` - board-game rules engine and gameplay model
  - `modules/data/` - sound, multiplayer bindings, and app-facing data services
  - `modules/datastore/` - persistent user, settings, and save-slot storage
  - `modules/model/` - shared data models including achievements and log state
  - `benchmarks/` - baseline-profile and benchmark support
- Source footprint:
  - total files counted in repository: `623`
  - Kotlin/Kotlin DSL/Java files counted in repository: `374`
- Test surface:
  - files matching `*Test.kt`: `34`
  - visible test surface is broader than average for the lab, with JVM tests, screenshot tasks, baseline-profile workflows, and benchmark infrastructure
- Key modules reviewed:
  - `README.md`
  - `FULLGRAPH.md`
  - `settings.gradle.kts`
  - `build.gradle.kts`
  - `gradle/libs.versions.toml`
  - `app/build.gradle.kts`
  - `modules/naijaludo/src/commonMain/kotlin/com/mshdabiola/naijaludo/LudoGame.kt`
  - `modules/naijaludo/src/commonMain/kotlin/com/mshdabiola/naijaludo/model/Board.kt`
  - `modules/naijaludo/src/commonMain/kotlin/com/mshdabiola/naijaludo/RandomComputerPlayer.kt`
  - `features/game/src/commonMain/kotlin/com/mshdabiola/game/GameScreen.kt`
  - `features/game/src/commonMain/kotlin/com/mshdabiola/game/GameViewModel.kt`
  - `features/game/src/commonMain/kotlin/com/mshdabiola/game/LogLudo.kt`
  - `modules/datastore/src/nonJsMain/kotlin/com/mshdabiola/datastore/StoreImpl.kt`
  - `modules/data/src/main/java/com/mshdabiola/data/di/DataModule.android.kt`
  - `modules/data/src/main/java/com/mshdabiola/data/P2pManager.android.kt`
  - `modules/data/src/main/java/com/mshdabiola/data/util/multiplayer/P2pManager.kt`
  - `.github/workflows/Build.yaml`
  - `features/game/src/jvmTest/kotlin/com/mshdabiola/game/GameViewModelTest.kt`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeded and reported Gradle `8.13`.
- `cmd /c gradlew.bat help --no-daemon` failed in the lab because the current machine exposes only a Java `8` runtime without compiler tools:
  - `No Java compiler found, please ensure you are running Gradle with a JDK`
- `cmd /c gradlew.bat :features:game:jvmTest --dry-run --no-daemon` failed for the same reason.
- The failure shape is an environment limitation, not an upstream build-definition break:
  - `.github/workflows/Build.yaml` explicitly sets up `JDK 21` for the main build job
  - the Android instrumentation job uses `JDK 17`
  - the repository also applies `org.gradle.toolchains.foojay-resolver`, confirming that a real JDK is expected
- The visible build and verification surface is notably mature for a small public game:
  - KMP app packaging for Android/Desktop/WASM
  - screenshot verification and update tasks
  - baseline-profile generation
  - coverage publication
  - emulator Android tests
  - dependency-guard automation

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `3`
- Implementation depth: `3`
- Code clarity: `2`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - `Naijaludo` is a direct Android board-game product with a reusable rules core and several product-shell patterns that map cleanly into future Android game work.
  - Its strongest value comes from the combination of a standalone game engine module, pragmatic save/resume orchestration, a layered achievement/logging seam, and a wider-than-usual build/test discipline.
  - It is not a pristine reference: multiplayer wiring looks inconsistent, some AI logic is visibly rough, and the README has documentation drift, but the repository still clears the main-catalog bar.

## Interesting Findings

### Engine Architecture And Core Loop

- `modules/naijaludo/src/commonMain/kotlin/com/mshdabiola/naijaludo/LudoGame.kt` is the main architectural takeaway: the board-game rules live in a standalone state machine around `MutableStateFlow<LudoGameState>` rather than being embedded in a screen or activity.
- The same `LudoGame.kt` separates staged actions such as counter selection, pawn selection, move resolution, kill handling, and turn advancement, which is a good reference for turn-based mobile games that need readable state transitions.
- `features/game/src/commonMain/kotlin/com/mshdabiola/game/GameViewModel.kt` keeps product orchestration outside the rules core: dialogs, persistence, mode setup, sound hooks, and remote-command handling stay in the feature layer.
- `features/game/src/commonMain/kotlin/com/mshdabiola/game/LogLudo.kt` is a useful pattern for layering product telemetry and achievements on top of the gameplay core through subclassing instead of contaminating every rules method with meta-game bookkeeping.

### Rendering And Graphics

- `features/game/src/commonMain/kotlin/com/mshdabiola/game/GameScreen.kt` shows a practical Compose board-game shell where one rules core is rendered through device-form-factor-specific layouts instead of forking separate gameplay implementations.
- The same screen uses `CompositionLocalProvider(LocalBoard provides uBoard)` to inject board skins/layout variants, which is a reusable pattern for theming or rules-adjacent visual configuration in Compose games.

### Gameplay Systems

- `modules/naijaludo/src/commonMain/kotlin/com/mshdabiola/naijaludo/model/Board.kt` encodes path, safe cells, home/out zones, and color-to-board transforms in a way that is reusable for any circular race game or indexed board-game implementation.
- `LudoGame.kt` uses a staged counter-then-pawn interaction model and can auto-resolve turns where only one move is legal, which is a good reference for reducing board-game input friction without hiding the turn structure.
- `RandomComputerPlayer.kt` is a compact but meaningful heuristic AI example:
  - immediate kills are prioritized
  - sixes are favored for move-out
  - board coordinates are normalized through `specificToGeneral`
  - pawn choices mix threat and distance reasoning instead of pure randomness
- `RandomComputerPlayer.kt` is also a caveat-rich reference rather than a perfect one: the active code still contains inline `bug` / `Todo` markers in move-selection logic.

### Input And Controls

- `GameScreen.kt` and its dialog/pause flow show a good small-product pattern where turn input, start/restart dialogs, permission gates, and lifecycle pause/resume handling are kept separate from the board-game core.
- The repository uses simple protocol strings such as `setting,...`, `client_name,...`, `dice,...`, `pawn,...`, and `counter,...` for remote turn flow, which is a useful compact pattern for small asynchronous multiplayer games.

### Persistence And Data

- `modules/datastore/src/nonJsMain/kotlin/com/mshdabiola/datastore/StoreImpl.kt` and `CurrentState.kt` show a pragmatic monolithic save shell where user settings, current mode, purchased items, cosmetics, save slots, and meta-game logs are serialized together.
- `GameViewModel.kt` uses that store in a clean way: save/resume is explicit and mode-aware rather than an afterthought bolted onto UI state.
- `LogLudoData` and `StoreImpl` together show a small but reusable pattern for persisting analytics-adjacent achievement progress independently from the visible game board.

### Networking And Multiplayer

- The repository exposes a meaningful multiplayer seam through `IP2pManager` and the command-string protocol in `GameViewModel.kt`.
- The important caveat is architectural inconsistency on Android:
  - `modules/data/src/main/java/com/mshdabiola/data/di/DataModule.android.kt` binds `singleOf(::P2pManager) bind IP2pManager::class`
  - `modules/data/src/main/java/com/mshdabiola/data/P2pManager.android.kt` is a complete stub with no-op methods and `MutableStateFlow(null)`
  - yet `modules/data/src/main/java/com/mshdabiola/data/util/multiplayer/P2pManager.kt` contains a real Wi-Fi P2P implementation
- That means the checked-in Android DI binding currently points at the stubbed implementation, not the richer Wi-Fi P2P manager. This is a real caution and should not be glossed over as “multiplayer complete.”

### Android Platform Integration

- `.github/workflows/Build.yaml` and `app/build.gradle.kts` together show a fairly complete Android product workflow:
  - flavor split between `GooglePlay` and `FossReliant`
  - screenshot testing
  - lint
  - baseline profiles
  - connected Android tests
  - APK artifact publication
- The game is also useful as a direct Android architecture sample because it combines Compose UI, DataStore, background product state, sound, and permissions without collapsing everything into one giant activity.

### Build, Release, And Testing

- `Build.yaml` is one of the stronger signals in this repository: it validates wrapper integrity, `build-logic`, ktlint, dependency baselines, screenshot regressions, JVM tests, APK assembly, lint, badging, coverage, and emulator Android tests.
- `features/game/src/jvmTest/kotlin/com/mshdabiola/game/GameViewModelTest.kt` is small, but it confirms there is at least real feature-level test intent beyond template files.
- The repository also includes screenshot and benchmark infrastructure, which pushes it above the usual hobby-game baseline in this lab.
- The README still has a documentation inconsistency around licensing:
  - the repo metadata reports `GPL-3.0`
  - the README license section still says `GNU License (Version 2.0)`

## Reusable Takeaways

- For mobile board games, keep the rules engine in a standalone shared module and let screens or view-models own only setup, dialogs, persistence, and product behavior.
- Layer meta-game progression and telemetry on top of the gameplay engine through an explicit seam like `LogLudo` instead of spreading counters and achievement checks throughout the rules logic.
- Compact remote turn protocols do not need heavy serialization when the game is low-throughput and deterministic enough to model through small message strings.
- A small public Android game can still benefit from serious workflow discipline: screenshot tests, baseline profiles, dependency guards, and explicit flavor splits are all reusable process ideas here.

## Evidence Summary

- `LudoGame.kt`, `Board.kt`, and `RandomComputerPlayer.kt` - reusable board-game core, board indexing, and heuristic AI
- `GameViewModel.kt` and `GameScreen.kt` - product-shell orchestration, save/resume, dialogs, and Compose layout routing
- `LogLudo.kt`, `StoreImpl.kt`, and `CurrentState.kt` - achievements/meta logging and persistent state ownership
- `DataModule.android.kt`, `P2pManager.android.kt`, and `util/multiplayer/P2pManager.kt` - verified Android multiplayer seam inconsistency
- `.github/workflows/Build.yaml` - modern CI/build/release discipline and confirmed JDK expectations

## Risks Or Limits

- The Android multiplayer seam is not trustworthy as checked in: Koin currently binds a stub `P2pManager` instead of the fuller Wi-Fi P2P implementation under `util/multiplayer`.
- `RandomComputerPlayer.kt` still contains visible bug/TODO comments, so the AI should be treated as a useful heuristic reference rather than a polished baseline.
- The README drifts from the actual repository state in at least one important place: the license section still says GNU v2 while GitHub metadata reports GPL-3.0.
- The repository is broader and noisier than the smallest lab samples, so follow-up work should stay scoped to one subsystem instead of reopening the whole tree casually.
- Local Gradle validation in this lab is blocked by missing JDK/compiler tools even though upstream CI clearly expects JDK `17+` and `21`.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `android-game`
- Focus tags: `2d`, `android`, `multiplatform`, `ui-hud`, `input`, `ai`, `networking`, `save-load`, `testing`
- Follow-up needed:
  - if the lab revisits this repository, do it in a JDK `17+` or `21` plus Android SDK-ready environment and focus narrowly on the board-game core, the save/resume seam, the multiplayer wiring mismatch, or the screenshot/baseline workflow instead of reopening the entire repository broadly
