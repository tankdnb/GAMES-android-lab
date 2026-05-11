# Research Note

## Repository Snapshot

- Repository: `yamin8000/Dooz`
- Source URL: [https://github.com/yamin8000/Dooz](https://github.com/yamin8000/Dooz)
- Owner: `yamin8000`
- Batch ID: [`BATCH-2026-05-11-P`](../batches/BATCH-2026-05-11-P.md)
- Type: `android-game`
- License: `GPL-3.0`
- Selection date: `2026-05-11`
- Last pushed at selection: `2026-05-10`
- Stars at selection: `103`
- Investigated commit: `3f73f84f463e7f954e6a9d315571b4032152baa9`
- Research status: `accepted`
- Build mode: `static-review + gradle-help-failed-java8-needs-java17`
- Catalog card: [catalog/projects/yamin8000-dooz.md](../../catalog/projects/yamin8000-dooz.md)

## Why This Repository Was Selected

- After refreshing the shortlist, `Dooz` remained the strongest unresearched carry-over candidate by the current balance of direct Android relevance, freshness, and usable public signal.
- The repository is narrower than heavier multi-system games, but it still looked valuable because it combines a real shipped Android/Compose surface, local persistence, AI difficulty handling, localization work, and a small but readable gameplay loop.
- The alternative backlog at the time was weaker on at least one axis such as license clarity, freshness, or demonstrated Android-ready value.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: Android SDK + Jetpack Compose + Material3 + DataStore
- Rendering stack: Compose UI primitives with `LazyVerticalGrid`, custom shape drawing, animated cards, and Material3 theming
- Android target: direct Android app
- Build system: single-module Gradle Kotlin DSL Android project
- Repository layout summary: `app` contains all runtime, AI, settings, and UI code; `fastlane/metadata` and screenshots document release assets; `.github/workflows/android.yml` provides CI
- Source footprint:
  - total files reviewed in repository: `109`
  - Kotlin/Java files reviewed across the repository: `51`
- Test surface:
  - test files found: `0`
  - meaningful gameplay-specific tests found: `0`
- Key modules reviewed:
  - `README.md`
  - `settings.gradle.kts`
  - `build.gradle.kts`
  - `gradle/libs.versions.toml`
  - `.github/workflows/android.yml`
  - `app/build.gradle.kts`
  - `app/src/main/AndroidManifest.xml`
  - `app/src/main/java/io/github/yamin8000/dooz/core/App.kt`
  - `app/src/main/java/io/github/yamin8000/dooz/core/MainActivity.kt`
  - `app/src/main/java/io/github/yamin8000/dooz/data/DataStoreHelper.kt`
  - `app/src/main/java/io/github/yamin8000/dooz/ui/MainNavigation.kt`
  - `app/src/main/java/io/github/yamin8000/dooz/ui/game/GameState.kt`
  - `app/src/main/java/io/github/yamin8000/dooz/ui/game/GameScreen.kt`
  - `app/src/main/java/io/github/yamin8000/dooz/ui/game/components/GameBoard.kt`
  - `app/src/main/java/io/github/yamin8000/dooz/domain/GameConstants.kt`
  - `app/src/main/java/io/github/yamin8000/dooz/domain/logic/GameLogic.kt`
  - `app/src/main/java/io/github/yamin8000/dooz/domain/logic/SimpleGameLogic.kt`
  - `app/src/main/java/io/github/yamin8000/dooz/domain/ai/GameAi.kt`
  - `app/src/main/java/io/github/yamin8000/dooz/domain/ai/SimpleGameAi.kt`
  - `app/src/main/java/io/github/yamin8000/dooz/ui/settings/SettingsState.kt`
  - `app/src/main/java/io/github/yamin8000/dooz/ui/settings/content/Settings.kt`
  - `app/src/main/java/io/github/yamin8000/dooz/ui/settings/content/GameSettings.kt`
  - `app/src/main/java/io/github/yamin8000/dooz/ui/components/Texts.kt`
  - `app/src/main/java/io/github/yamin8000/dooz/ui/About.kt`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeds and reports Gradle `9.0.0` running on Java `1.8.0_321`.
- `cmd /c gradlew.bat help --no-daemon` fails immediately because Gradle `9.0.0` now requires JVM `17+`, while the lab machine still exposes Java `8`.
- The checked-in build surface confirms the same floor:
  - `app/build.gradle.kts` targets `compileSdk 36`, `targetSdk 36`, `minSdk 24`, JVM target `17`, Kotlin `2.3.21`, and AGP `8.13.0`
  - `.github/workflows/android.yml` sets up JDK `17` and runs `./gradlew build`
- The repository has real release-facing packaging signs:
  - `README.md` links to F-Droid and GitHub Releases
  - `fastlane/metadata/android/en-US/` contains store text and screenshots
  - the manifest disables backups and declares vibration use
- The test surface is empty:
  - no `src/test` or `src/androidTest` files were found in the inspected repository
- No runtime launch was attempted.
- Known setup limitations:
  - local Gradle validation in this lab is blocked by the Java `17` floor
  - the repository is compact and useful, but it is not a strong verification reference because it lacks automated tests
  - the published metadata is slightly inconsistent: `README.md` and `GameConstants.kt` cap board size at `7x7`, while `fastlane/metadata/android/en-US/full_description.txt` still says `9x9`

## Usefulness Assessment

- Reuse potential: `2`
- Android transfer: `3`
- Implementation depth: `2`
- Code clarity: `2`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - `Dooz` is a compact direct Android reference for small Compose-native board or puzzle games that do not need a separate engine layer
  - its strongest value is the combination of controller-like game state ownership, DataStore-backed settings, heuristic AI, and explicit RTL/localization handling in a real shipped mobile surface
  - it is not deep enough to act as a general gameplay-architecture baseline, but it is still worth keeping as a focused Android sample for lightweight turn-based board-game flow and localizable Compose UI

## Interesting Findings

### Engine Architecture And Core Loop

- `app/src/main/java/io/github/yamin8000/dooz/ui/game/GameState.kt` acts as the central controller for the whole game session. Instead of a `ViewModel` or separate engine loop, it owns board cells, current player, players list, rules loaded from storage, result state, dice-roll animation state, and undo history through remembered Compose state holders.
- The same file shows a practical small-game pattern where `prepareGame()` rebuilds the runtime from persisted settings, then `newGame()`, `playCell()`, `undo()`, and AI turns mutate that single owner. For a tiny board game this keeps the flow easy to follow.
- `GameLogic` and `GameAi` are simple abstract seams. They are narrow, but they still separate board-rule evaluation from the UI shell enough to make future variants of tic-tac-toe or other grid games possible without rewriting the whole screen layer.

### Gameplay Systems And AI

- `app/src/main/java/io/github/yamin8000/dooz/domain/logic/SimpleGameLogic.kt` generalizes winner detection beyond classic `3x3` tic-tac-toe. It checks rows, rotated columns, and both diagonals against a configurable board size taken from `GameConstants.gameSizeRange`, which currently allows `3..7`.
- `app/src/main/java/io/github/yamin8000/dooz/domain/ai/SimpleGameAi.kt` is the most reusable gameplay-specific finding. Hard difficulty uses an explicit heuristic stack instead of MinMax: win, block, fork, block fork, center play, and corner play. Medium mixes hard and easy by chance, while easy picks a random empty cell.
- `GameState` also adds a few product-level rules on top of pure board logic: PvP versus PvC mode, first-player selection through either dice rolling or forced human-first policy, adjustable shapes and names, and an undo flow that compensates for AI turns by replaying the undo twice in PvC mode.

### UI, Input, And Localization

- `app/src/main/java/io/github/yamin8000/dooz/ui/game/components/GameBoard.kt` shows a straightforward Compose-only board renderer. It derives square size from screen width, renders the matrix through `LazyVerticalGrid`, blocks interaction when the game is finished or the AI is the current player, and highlights winner cells through theme colors instead of a separate overlay system.
- `app/src/main/java/io/github/yamin8000/dooz/ui/game/GameScreen.kt` and `ui/game/components/PlayerCard.kt` layer in polished but lightweight product behavior: animated visibility for game panels, dice-roll transitions, portrait lock, and a large bottom action bar with new-game and undo affordances.
- `app/src/main/java/io/github/yamin8000/dooz/ui/components/Texts.kt` is a particularly useful Android-specific UI reference. `PersianText` switches layout direction, text direction, and font family automatically when Persian text or locale is detected, and the repository ships parallel `values`, `values-fa`, and `values-ja` string sets plus a bundled Persian font.

### Persistence, Settings, And Product Shell

- `app/src/main/java/io/github/yamin8000/dooz/data/DataStoreHelper.kt`, `core/App.kt`, and `ui/settings/SettingsState.kt` show a compact preference-backed configuration flow. Theme, sound, vibration, board size, AI difficulty, first-player policy, player names, and player shapes all persist through a single `preferencesDataStore`.
- `ui/settings/content/Settings.kt` splits settings into three user-facing tabs: general, game, and players. That makes the repository more useful than a toy sample because it demonstrates how a small game can keep a configurable shell without needing a large settings architecture.
- `ui/About.kt`, the manifest, F-Droid README links, and `fastlane` metadata together show a repository that was prepared for real Android distribution rather than only for a demo video.

## Reusable Takeaways

- A very small Android board game can stay entirely inside a normal Compose app shell if one controller-like state holder owns runtime state, settings hydration, and small async effects.
- Heuristic AI is often enough for casual mobile board games; a readable priority stack can be more reusable than a heavier search algorithm when the goal is product responsiveness and maintainability.
- DataStore-backed settings become more valuable when they are tied directly to gameplay rules such as player type, turn policy, AI difficulty, and board size, not only to generic app preferences.
- Localized game UI sometimes needs more than translated strings. Automatic RTL detection and locale-specific typography are worth capturing explicitly, especially for casual games with custom labels and player names.

## Evidence Summary

- `GameState.kt`, `GameScreen.kt`, `GameLogic.kt`, `GameAi.kt` - controller-owned runtime, Compose-driven session flow, and narrow logic/AI seams
- `SimpleGameLogic.kt`, `SimpleGameAi.kt`, `GameConstants.kt`, `FirstPlayerPolicy.kt` - generalized board-size winner checks, heuristic AI, and small rule-configuration surface
- `GameBoard.kt`, `PlayerCard.kt`, `Texts.kt`, `Settings.kt` - screen-width-based board layout, animated player HUD, Persian/RTL text handling, and tabbed settings UI
- `DataStoreHelper.kt`, `SettingsState.kt`, `App.kt` - single-store persistence for gameplay and product settings
- `MainActivity.kt`, `AndroidManifest.xml`, `.github/workflows/android.yml`, `fastlane/metadata/android/en-US/` - Android entry shell, JDK17 CI, release-facing metadata, and distribution readiness

## Risks Or Limits

- The project is intentionally narrow: it is a polished tic-tac-toe reference, not a broad engine or systems benchmark.
- The test surface is empty, so confidence comes from static reading plus the visible public release surface rather than from automation.
- Local Gradle validation in this lab currently stops at the JVM floor because Gradle `9.0.0` needs Java `17+`.
- `GameState` couples game logic, persistence, haptic feedback, sound triggering, and coroutine timing into one state owner. That keeps the sample simple, but it is not an ideal architecture template for larger games.
- The shipped metadata has at least one stale inconsistency: fastlane still advertises `9x9` boards while the current code and README are aligned on `7x7`.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `android-game`
- Focus tags: `2d`, `android`, `input`, `ui-hud`, `ai`, `save-load`, `audio`
- Follow-up needed:
  - if the lab revisits this repository later, verify the actual runtime feel of the heuristic AI and the Compose board shell on a device or emulator
  - a narrower follow-up could isolate the RTL/localized Compose text pattern, the DataStore-backed rules/settings shell, or the heuristic tic-tac-toe AI instead of reopening the whole repository broadly
