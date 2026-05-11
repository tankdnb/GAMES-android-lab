# Research Note

## Repository Snapshot

- Repository: `AlinaStepanova/SeaBattle`
- Source URL: [https://github.com/AlinaStepanova/SeaBattle](https://github.com/AlinaStepanova/SeaBattle)
- Owner: `AlinaStepanova`
- Batch ID: [`BATCH-2026-05-11-H`](../batches/BATCH-2026-05-11-H.md)
- Type: `android-game`
- License: `none found; GitHub metadata reports null license info`
- Selection date: `2026-05-11`
- Last pushed at selection: `2025-07-20`
- Stars at selection: `12`
- Investigated commit: `acf346188d0a4d39fb667ec6d0d82880153f4ba5`
- Research status: `accepted`
- Build mode: `static-review + gradle-help-failed-java8-needs-java11`
- Catalog card: [catalog/projects/alinastepanova-seabattle.md](../../catalog/projects/alinastepanova-seabattle.md)

## Why This Repository Was Selected

- The refreshed shortlist had become thin on direct Android-native candidates that do not rely on LibGDX, Compose, or a general-purpose engine.
- `SeaBattle` promised a rarer reference shape for the lab: a Kotlin Android game built directly on `Canvas`, `Custom View`, `LiveData`, and coroutines.
- Even though the popularity signal is low and the repository does not expose a clear license, it still fills an important gap in the catalog around lightweight Android board-game rendering and touch-grid architecture.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: custom Android SDK implementation with `ViewModel`, `LiveData`, `DataBinding`, and coroutines
- Rendering stack: Android `Canvas` drawing inside custom `View` subclasses
- Android target: direct Android app
- Build system: single-app Gradle Groovy Android project
- Repository layout summary: root Android app with `main/`, `views/`, `battle_field/`, and `ships/` packages, plus Android resources, one GitHub Actions workflow, and a small test tree
- Source footprint:
  - total files reviewed in repository: `85`
  - Kotlin/Java files reviewed across the repository: `29`
- Test surface:
  - test files found: `8`
- Key modules reviewed:
  - `README.md`
  - `build.gradle`
  - `app/build.gradle`
  - `.github/workflows/android_build.yml`
  - `app/src/main/AndroidManifest.xml`
  - `app/src/main/java/com/avs/sea/battle/Constants.kt`
  - `app/src/main/java/com/avs/sea/battle/main/MainActivity.kt`
  - `app/src/main/java/com/avs/sea/battle/main/MainViewModel.kt`
  - `app/src/main/java/com/avs/sea/battle/main/ShotManager.kt`
  - `app/src/main/java/com/avs/sea/battle/views/SquareView.kt`
  - `app/src/main/java/com/avs/sea/battle/views/ComputerSquareView.kt`
  - `app/src/main/java/com/avs/sea/battle/views/PersonSquareView.kt`
  - `app/src/main/java/com/avs/sea/battle/battle_field/BaseBattleField.kt`
  - `app/src/main/java/com/avs/sea/battle/battle_field/BattleField.kt`
  - `app/src/main/java/com/avs/sea/battle/ships/Ship.kt`
  - `app/src/test/java/com/avs/sea/battle/main/ShotManagerTest.kt`
  - `app/src/test/java/com/avs/sea/battle/battle_field/BaseBattleFieldTest.kt`
  - `app/src/androidTest/java/com/avs/sea/battle/main/MainActivityStartTest.kt`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `java -version` on the lab machine still reports `1.8.0_321`.
- `cmd /c gradlew.bat --version` succeeds and reports Gradle `8.13`, but the launcher JVM is still Java `8`.
- `cmd /c gradlew.bat help --no-daemon` fails during configuration because `com.android.tools.build:gradle:8.11.1` requires at least Java `11`, while the current lab machine remains on Java `8`.
- `cmd /c gradlew.bat :app:testDebugUnitTest --dry-run --no-daemon` fails for the same reason before task graph creation.
- The checked-in build surface and CI explain that failure shape:
  - root `build.gradle` uses Kotlin `2.1.20` and Android Gradle Plugin `8.11.1`
  - `app/build.gradle` targets `compileSdk 36`, `targetSdk 36`, `minSdk 21`, and Java/Kotlin `17`
  - `.github/workflows/android_build.yml` runs unit tests, lint, and assemble on Java `17`
- No runtime launch was attempted.
- Known setup limitations:
  - local Gradle/test verification in this lab is blocked by the machine still exposing Java `8`
  - the repository does not expose an explicit `LICENSE` file or GitHub license metadata
  - external repository code remained static-review-first by design

## Usefulness Assessment

- Reuse potential: `2`
- Android transfer: `3`
- Implementation depth: `2`
- Code clarity: `2`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - the project fills a real gap in the lab as a direct Android `Canvas`/`Custom View` reference instead of another LibGDX or Compose sample
  - the codebase is small but still demonstrates several reusable mobile-native patterns together: touch-grid selection, `ViewModel`-driven turn flow, isolated board logic, and a simple but stateful opponent shot strategy
  - the narrow scope and unclear license keep it from being a top-tier architecture reference, but it is still strong enough to keep in the main catalog as a focused Android-native pattern source

## Interesting Findings

### Engine Architecture And Core Loop

- `app/src/main/java/com/avs/sea/battle/main/MainActivity.kt` and `.../MainViewModel.kt` show a clean single-activity game shell where Android UI controls stay dumb and the `ViewModel` owns game phase, status text, currently active player, selected cell, and the observable shot/ship lists consumed by the custom views.
- `MainViewModel.kt` uses two independent `BattleField` instances plus one `ShotManager`, which keeps board state, opponent targeting state, and UI state separated without inventing a heavier engine layer.
- The opponent turn is intentionally not a frame loop. `MainViewModel.playAsComputer()` uses `viewModelScope.launch` plus `delay(SECOND_IN_MILLIS)` to stage AI shots and progress-bar timing, which is a practical pattern for turn-based mobile games that do not need a continuous simulation loop.

### Rendering And Graphics

- `app/src/main/java/com/avs/sea/battle/views/SquareView.kt` is the main rendering seam. It measures the grid once, computes `squareWidth` from the current view size, draws the board lines, and exposes reusable `Canvas.drawDot`, `Canvas.drawCross`, and `Canvas.drawSquare` helpers. This is a compact reference for Android-native grid rendering without a separate surface engine.
- `ComputerSquareView.kt` and `PersonSquareView.kt` reuse that base renderer and then only add state-specific overlays: ships, miss dots, hit crosses, and the selected target highlight. The split is simple but reusable for any two-board or hidden-vs-visible board game.
- The resource tree also includes `layout/` and `layout-land/` variants plus density-specific size resources, which shows the project was shaped as a real Android app with portrait/landscape handling rather than as a one-size-fits-all demo surface.

### Gameplay Systems

- `app/src/main/java/com/avs/sea/battle/battle_field/BattleField.kt` is the main rules engine. `randomizeShips()` enforces Battleship spacing through explicit start/end/corner/side emptiness checks instead of using a precomputed mask, which keeps the placement logic readable and easy to port into another Kotlin board-game project.
- The same file handles shot resolution, killed-ship detection, neighbor marking, and game-over checks. When a ship dies, the code marks surrounding cells as failed shots so later turns cannot waste selections on impossible targets.
- `app/src/main/java/com/avs/sea/battle/main/ShotManager.kt` is the strongest standalone gameplay finding in the repository. It tracks up to four candidate hit cells, remembers the remaining ship sizes, and switches from random searching to directional finishing logic once hits land. That gives the computer player a compact state machine instead of pure randomness.
- `app/src/main/java/com/avs/sea/battle/ships/Ship.kt` keeps ship orientation, coordinate ranges, and hit/death logic localized inside the ship model, so the battlefield can ask high-level questions like `isDead()` instead of duplicating per-cell kill checks.

### Input And Controls

- `ComputerSquareView.kt` maps raw touch coordinates into board cells with `convertUICoordinates(x, y)`, clamps the last row/column edge case, and sends only logical grid positions to `MainViewModel.handlePCAreaClick()`. This is a straightforward touch-to-grid conversion pattern for Android board games.
- The player does not fire immediately on touch. Instead, the selected cell is highlighted in the board view and the separate fire button becomes visible only when a valid cell is selected. That two-step confirmation flow is useful on touch screens where accidental shots are easy.
- `MainActivity.kt` also wraps several action buttons in a shared pressed-state listener, so the generate/start/fire/new-game controls get consistent tactile feedback without repeated per-button code.

### UI, HUD, And Menus

- `MainActivity.kt` combines `DataBinding`, `LiveData` observers, `WindowCompat.enableEdgeToEdge`, and explicit system-gesture insets handling. For a small game, that is a good reminder that Android-native polish can live directly in the host activity instead of being deferred to a full game engine shell.
- The activity also keeps non-game actions such as share, rate, author email, privacy policy, and in-app review flow beside the game shell. That makes the repository useful not only for board rendering, but also for the lightweight Android product plumbing that surrounds a small mobile game.
- `app/build.gradle` limits packaged locales to `en`, `uk`, and `ru`, which shows a small but practical APK-size and localization-awareness decision.

### Build, Release, And Testing

- `app/build.gradle` enables both `dataBinding` and `viewBinding`, turns on resource shrinking/minification for release, and ships a modern Android target stack for a small game sample.
- `.github/workflows/android_build.yml` is valuable because it proves the repository has a real CI surface: unit tests, lint, and debug assemble all run on Java `17`.
- The test tree is small but meaningful:
  - `ShotManagerTest.kt` covers neighbor selection, edge marking, finishing logic, and remaining-ship bookkeeping for the AI shot state machine
  - `BaseBattleFieldTest.kt` checks board initialization and cell-state transitions
  - `MainActivityStartTest.kt` is a simple Espresso smoke test that confirms the main board views and key buttons render on launch

## Reusable Takeaways

- A turn-based Android game does not need a continuous engine loop if the actual progression is event-driven and short delays can be modeled with lifecycle-aware coroutines.
- Custom `View` subclasses remain a viable option for small 2D board or puzzle games when the rendering primitives are simple and the host app wants full Android UI interoperability.
- Separate logical selection from destructive actions on touch screens; board-cell highlight plus a dedicated confirm button is safer than firing immediately on `ACTION_UP`.
- A lightweight opponent AI can still feel deliberate when it tracks partial hits, remaining ship sizes, and impossible neighbor cells instead of choosing every shot randomly.
- Even tiny game repositories become much more reusable when the rules layer, rendering layer, and touch/UI shell are kept distinct and backed by a small test surface.

## Evidence Summary

- `MainActivity.kt`, `MainViewModel.kt` - single-activity Android shell, observer-driven UI, coroutine-delayed opponent turns
- `SquareView.kt`, `ComputerSquareView.kt`, `PersonSquareView.kt` - reusable `Canvas` grid primitives, board overlays, touch-grid conversion, target highlighting
- `BattleField.kt`, `BaseBattleField.kt`, `Ship.kt` - placement rules, shot handling, killed-ship marking, game-over checks, ship-local hit/death logic
- `ShotManager.kt` - remaining-ship-aware computer targeting state machine
- `app/build.gradle`, `build.gradle`, `.github/workflows/android_build.yml` - modern Android build stack, Java `17` CI, and the lab-local Java `8` incompatibility
- `ShotManagerTest.kt`, `BaseBattleFieldTest.kt`, `MainActivityStartTest.kt` - focused unit/instrumentation coverage over board logic, AI logic, and launch smoke behavior

## Risks Or Limits

- The repository has low popularity signal at selection time, so its value comes from fit and code shape rather than from ecosystem adoption.
- The project scope is intentionally narrow: there is no persistence, networking, audio stack, or large-scale content pipeline to study here.
- The lab could not run real Gradle tasks or tests because the current environment still exposes Java `8`, while the inspected build now requires Java `11+` and CI is pinned to Java `17`.
- No explicit `LICENSE` file was found and GitHub reports `licenseInfo: null`, so the repository should be treated as an ideas/reference source rather than as code intended for direct reuse.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `android-game`
- Focus tags: `2d`, `android`, `input`, `ui-hud`, `testing`
- Follow-up needed:
  - if the lab revisits this repository later, rerun `help` and `testDebugUnitTest` in a Java `17` environment and optionally do a narrower comparison pass against other direct Android `Canvas`/`Custom View` games or `NiklasJohansen/PulseEngine`
