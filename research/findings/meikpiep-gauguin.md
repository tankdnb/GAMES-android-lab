# Research Note

## Repository Snapshot

- Repository: `meikpiep/gauguin`
- Source URL: [https://github.com/meikpiep/gauguin](https://github.com/meikpiep/gauguin)
- Owner: `meikpiep`
- Batch ID: [`BATCH-2026-05-11-K`](../batches/BATCH-2026-05-11-K.md)
- Type: `android-game`
- License: `GPL-3.0`
- Selection date: `2026-05-11`
- Last pushed at selection: `2026-05-08`
- Stars at selection: `197`
- Investigated commit: `b6ed9deccaf26f35de87bcbb2e4a8a3f4a395c45`
- Research status: `accepted`
- Build mode: `static-review + gradle-help-failed-java8-needs-java17`
- Catalog card: [catalog/projects/meikpiep-gauguin.md](../../catalog/projects/meikpiep-gauguin.md)

## Why This Repository Was Selected

- The refreshed shortlist had only one strong carry-over Android candidate left, `yamin8000/Dooz`, but that repository looked much narrower in expected architectural yield.
- `gauguin` offered a better balance of direct Android relevance, fresh maintenance, ecosystem signal, and subsystem depth because it is split into a real Android app, a reusable puzzle core, a dedicated human-solver module, a separate merge-based generator, and a micro-benchmark module.
- It also broadens the lab with a stronger arithmetic-puzzle reference instead of another engine experiment or toy Android sample.

## Technical Profile

- Main language(s): Kotlin, plus a small Ruby/Fastlane release surface
- Engine / framework: custom Android SDK puzzle app with Koin, coroutines, custom `View` rendering, and shared JVM puzzle modules
- Rendering stack: custom Android `View` grid rendering with adaptive keypad/layout resources and traditional XML activities/fragments
- Android target: direct Android app
- Build system: multi-module Gradle Kotlin DSL project with Android app, JVM libraries, and Android benchmark module
- Repository layout summary: `gauguin-app` for the Android shell/UI, `gauguin-core` for grid/domain/save logic, `gauguin-human-solver` for strategy-based solving and difficulty, `gauguin-grid-creation-via-merge` for the alternate generator, `micro-benchmark` for Android benchmark tests, plus docs and Fastlane metadata
- Source footprint:
  - total files reviewed in repository: `918`
  - Kotlin/Java files reviewed across the repository: `332`
- Test surface:
  - test files found: `54`
  - screenshot test files found: `6`
  - benchmark files found: `4`
- Key modules reviewed:
  - `README.md`
  - `build.gradle.kts`
  - `settings.gradle.kts`
  - `.github/workflows/build.yml`
  - `docs/calculating-difficulties.md`
  - `gauguin-app/build.gradle.kts`
  - `gauguin-app/src/main/kotlin/org/piepmeyer/gauguin/MainApplication.kt`
  - `gauguin-app/src/main/kotlin/org/piepmeyer/gauguin/AppModule.kt`
  - `gauguin-app/src/main/kotlin/org/piepmeyer/gauguin/ui/main/MainViewModel.kt`
  - `gauguin-app/src/main/kotlin/org/piepmeyer/gauguin/ui/newgame/NewGameViewModel.kt`
  - `gauguin-app/src/main/kotlin/org/piepmeyer/gauguin/ui/grid/GridUI.kt`
  - `gauguin-app/src/main/kotlin/org/piepmeyer/gauguin/ui/grid/GridUiInjectionDefaultStrategy.kt`
  - `gauguin-app/src/main/kotlin/org/piepmeyer/gauguin/ui/main/KeyPadLayoutCalculator.kt`
  - `gauguin-app/src/main/kotlin/org/piepmeyer/gauguin/preferences/StatisticsManagerImpl.kt`
  - `gauguin-core/build.gradle.kts`
  - `gauguin-core/src/main/kotlin/org/piepmeyer/gauguin/CoreModule.kt`
  - `gauguin-core/src/main/kotlin/org/piepmeyer/gauguin/game/Game.kt`
  - `gauguin-core/src/main/kotlin/org/piepmeyer/gauguin/game/GameLifecycle.kt`
  - `gauguin-core/src/main/kotlin/org/piepmeyer/gauguin/calculation/GridCalculationService.kt`
  - `gauguin-core/src/main/kotlin/org/piepmeyer/gauguin/calculation/GridPreviewCalculationService.kt`
  - `gauguin-core/src/main/kotlin/org/piepmeyer/gauguin/calculation/GridPreviewCalculator.kt`
  - `gauguin-core/src/main/kotlin/org/piepmeyer/gauguin/creation/GridCalculatorFactory.kt`
  - `gauguin-core/src/main/kotlin/org/piepmeyer/gauguin/creation/RandomCageGridCalculator.kt`
  - `gauguin-core/src/main/kotlin/org/piepmeyer/gauguin/creation/DifficultyAwareGridCreator.kt`
  - `gauguin-core/src/main/kotlin/org/piepmeyer/gauguin/difficulty/GridDifficultyCalculator.kt`
  - `gauguin-core/src/main/kotlin/org/piepmeyer/gauguin/difficulty/GameDifficultyLoader.kt`
  - `gauguin-core/src/main/kotlin/org/piepmeyer/gauguin/game/save/SaveGame.kt`
  - `gauguin-core/src/main/kotlin/org/piepmeyer/gauguin/game/save/CurrentGameSaver.kt`
  - `gauguin-core/src/main/kotlin/org/piepmeyer/gauguin/game/save/SavedGamesService.kt`
  - `gauguin-core/src/main/kotlin/org/piepmeyer/gauguin/preferences/ApplicationPreferencesMigrations.kt`
  - `gauguin-core/src/main/resources/org/piepmeyer/gauguin/difficulty/difficulty-ratings.yml`
  - `gauguin-human-solver/build.gradle.kts`
  - `gauguin-human-solver/src/main/kotlin/org/piepmeyer/gauguin/difficulty/human/HumanSolver.kt`
  - `gauguin-human-solver/src/main/kotlin/org/piepmeyer/gauguin/difficulty/human/HumanDifficultyCalculatorImpl.kt`
  - `gauguin-human-solver/src/main/kotlin/org/piepmeyer/gauguin/difficulty/human/HumanSolverStrategies.kt`
  - `gauguin-grid-creation-via-merge/build.gradle.kts`
  - `gauguin-grid-creation-via-merge/src/main/kotlin/org/piepmeyer/gauguin/creation/MergingCageGridCalculator.kt`
  - `micro-benchmark/build.gradle.kts`
  - `micro-benchmark/src/androidTest/kotlin/org/piepmeyer/gauguin/benchmark/HumanSolverUnsolved7x7Benchmark.kt`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeds and reports Gradle `9.3.1`, but the launcher JVM on the lab machine is still `1.8.0_321`.
- `cmd /c gradlew.bat help --no-daemon` fails immediately because Gradle `9.3.1` requires JVM `17+`, while the lab environment still exposes Java `8`.
- The checked-in build surface is stricter than that initial failure already suggests:
  - root `build.gradle.kts` bootstraps Android Gradle Plugin `9.1.1`
  - `gauguin-app/build.gradle.kts` targets `compileSdk 36`, `targetSdk 36`, `minSdk 24`, and configures Kotlin plus Java toolchains around `21`
  - `gauguin-core`, `gauguin-human-solver`, and `gauguin-grid-creation-via-merge` all use JVM toolchain `21`
  - `.github/workflows/build.yml` runs `./gradlew build test jacocoTestReport --stacktrace --no-configuration-cache -Pbuildserver` on Temurin `21`
- The repository also contains a serious verification surface beyond ordinary unit tests:
  - Roborazzi screenshot testing is enabled in `gauguin-app/build.gradle.kts`
  - `gauguin-core` and `gauguin-human-solver` both define `integrationTest` suites
  - `micro-benchmark` runs Android benchmark tests against the solver and combinatorics hotspots
- No runtime launch was attempted.
- Known setup limitations:
  - local Gradle/test validation in this lab is blocked first by Java `8`, while the inspected project now expects modern Gradle plus JDK `21`
  - the repository is GPL-licensed, so it is stronger as an ideas/reference source than as a direct code-copy source
  - puzzle generation and difficulty calibration are intentionally CPU-heavy, so casual runtime assumptions should be validated on real target devices before reuse

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `3`
- Implementation depth: `3`
- Code clarity: `2`
- Novelty: `3`
- Overall verdict: `accepted`
- Why:
  - this repository is one of the strongest direct Android puzzle references currently in the lab because it combines a real shipped app shell with deep generation, solving, caching, save/migration, and verification subsystems
  - the most reusable ideas are not puzzle-specific UI polish alone, but the background grid pipeline, generator/difficulty split, and versioned persistence model
  - GPL licensing and specialization to arithmetic-cage puzzles keep it from being a general gameplay baseline, but it is still too rich and too well-structured to leave out of the main catalog

## Interesting Findings

### Engine Architecture And Core Loop

- `gauguin-core/src/main/kotlin/org/piepmeyer/gauguin/game/Game.kt` is the main runtime seam. It keeps mutable puzzle state in one place, exposes `StateFlow`s for grid, fast-finishing mode, and possible-solution checks, and routes edits through `GameMode` rather than letting the UI mutate grid cells directly.
- `gauguin-core/src/main/kotlin/org/piepmeyer/gauguin/game/GameLifecycle.kt` and `.../calculation/GridCalculationService.kt` implement a high-value mobile puzzle pattern: consume an already-prepared next board when available, then immediately start background generation of the next one again. The service even persists the prefetched board as `next-grid.json` so heavy generation work survives process death better than a purely in-memory queue.
- `gauguin-app/src/main/kotlin/org/piepmeyer/gauguin/ui/main/MainViewModel.kt` bridges that runtime to Android UI cleanly. Instead of inventing a large custom engine shell, it projects `GameStateWithGrid`, fast-finishing mode, keep-screen-on state, and possible-solution checks as flows that activities/fragments can observe.

### Rendering And Graphics

- `gauguin-app/src/main/kotlin/org/piepmeyer/gauguin/ui/grid/GridUI.kt` is a strong direct Android rendering reference for dense puzzle boards. It measures adaptive cell sizes, centers the grid with padding, draws cells/cages/text in layered passes, and even overlays a diagonal preview ribbon when the shown board is only a placeholder preview.
- The same file keeps touch mapping, draw ordering, cage-text visibility, and preview-mode rendering localized inside one custom `View` without mixing gameplay rules into drawing code.
- `gauguin-app/src/main/kotlin/org/piepmeyer/gauguin/ui/main/KeyPadLayoutCalculator.kt` shows a practical adaptive-HUD technique for puzzle apps: choose compact portrait, compact landscape, or full keypad layouts from window size classes plus grid size instead of assuming one keypad always fits.
- `gauguin-app/src/main/kotlin/org/piepmeyer/gauguin/ui/grid/GridUiInjectionDefaultStrategy.kt` is a small but reusable seam that keeps the custom grid view renderer/input shell decoupled from the `Game` object and preference-driven UI flags.

### Gameplay Systems

- `gauguin-core/src/main/kotlin/org/piepmeyer/gauguin/creation/GridCalculatorFactory.kt` deliberately keeps two generator families alive: square grids can still use the older random-cage path, while rectangular grids or explicitly enabled new-algorithm runs use the merge-based generator. That kind of algorithm switch is valuable when one approach is faster for common cases but another generalizes better.
- `gauguin-core/src/main/kotlin/org/piepmeyer/gauguin/creation/RandomCageGridCalculator.kt` repeatedly generates candidate boards and uses DLX in `MULTIPLE` mode to stop as soon as it detects more than one solution. This is a compact reference for uniqueness enforcement without solving every branch fully.
- `gauguin-grid-creation-via-merge/src/main/kotlin/org/piepmeyer/gauguin/creation/MergingCageGridCalculator.kt` starts from one-cell cages, merges adjacent cages in several passes, and checks each merge candidate with `MathDokuDLXSolver`. It also derives a minimum cage count from the wanted difficulty, which turns difficulty into a structural generation constraint rather than only a post-hoc label.
- `gauguin-core/src/main/kotlin/org/piepmeyer/gauguin/creation/DifficultyAwareGridCreator.kt` simply retries generation until the resulting board lands inside the configured difficulty set. The implementation is blunt, but it is effective and easy to understand.
- `gauguin-human-solver/src/main/kotlin/org/piepmeyer/gauguin/difficulty/human/HumanSolver.kt`, `.../HumanSolverStrategies.kt`, and `.../HumanDifficultyCalculatorImpl.kt` form one of the strongest puzzle-specific findings in the lab. The solver walks a weighted ladder of human-style tactics, from single-possibles and naked pairs up to X-Wing, Y-Wing, and Nishio, then converts the used tactics into a difficulty number.
- `docs/calculating-difficulties.md` together with `gauguin-core/src/main/resources/org/piepmeyer/gauguin/difficulty/difficulty-ratings.yml` shows that the repository does not rely only on intuition for difficulty labels: thresholds are calibrated from batches of `1,000` generated games per variant and then stored as data.
- `gauguin-core/src/main/kotlin/org/piepmeyer/gauguin/calculation/GridPreviewCalculator.kt` adds another notable puzzle UX trick. If real generation does not finish within `250ms`, it builds a pseudo preview with relaxed difficulty/single-cage constraints, shows that immediately, and later swaps in the real board once background generation completes.

### Input And Controls

- `gauguin-app/src/main/kotlin/org/piepmeyer/gauguin/ui/grid/GridUI.kt` converts `ACTION_DOWN` coordinates into logical cells only after accounting for centered padding and per-axis cell size, which is a clean direct-input mapping pattern for custom puzzle boards.
- `gauguin-core/src/main/kotlin/org/piepmeyer/gauguin/game/Game.kt` keeps input semantics richer than a normal number-entry form: it supports fast-finishing mode, possible-number entry, long-press actions, last-possible copy, duplicate marking, undo capture, and solution-check gating without leaking those concerns into the `View`.
- `KeyPadLayoutCalculator.kt` plus the alternative keypad layouts show a direct Android-native approach to dense puzzle input adaptation that can transfer into Sudoku, Kakuro, KenKen, or other number-entry games.

### Tooling, Android Integration, Or Other Notable Areas

- `gauguin-app/src/main/kotlin/org/piepmeyer/gauguin/MainApplication.kt` is a good example of startup hygiene in a game app: it applies preference migrations before DI startup, wires Koin modules from multiple subprojects, enables dynamic colors only behind a precondition, and launches saved-game migration on an IO coroutine after boot.
- `gauguin-core/src/main/kotlin/org/piepmeyer/gauguin/game/save/SaveGame.kt` plus the `v1` and `v2` model packages show explicit versioned save migration rather than hoping old serialized state keeps decoding forever. `SavedGamesService.migrateOldSavedGameFilesBeforeKoinStartup()` makes that migration a first-class startup task.
- `gauguin-core/src/main/kotlin/org/piepmeyer/gauguin/game/save/CurrentGameSaver.kt` uses a simple but effective pattern: keep one rolling autosave and also duplicate it into incrementing `game_N.yml` snapshots so the user can load named saves without losing the automatic current-state save.
- `gauguin-app/src/main/kotlin/org/piepmeyer/gauguin/preferences/StatisticsManagerImpl.kt` stores rolling solved-difficulty and solved-duration windows, aggregate sums, min/max values, and streak sequences. This is a useful small-game reference for analytics-like player statistics without needing a database.
- The repository also carries a mature Android product surface beyond code:
  - `fastlane/metadata/android/*` shows multi-language store metadata management
  - `README.md` documents F-Droid and Play Store delivery
  - `.github/workflows/build.yml` plus Roborazzi and benchmark modules show that release polish and regression control are treated seriously, not as afterthoughts

## Reusable Takeaways

- For expensive puzzle generation, precompute both the immediate preview and the next playable board; if true generation misses a short UI budget, show a pseudo preview first and swap in the final board later.
- Keep difficulty calibration as a separate subsystem, not just a label on the generator. `gauguin` combines structural difficulty heuristics, human-style solving strategies, and stored per-variant thresholds into a defensible difficulty pipeline.
- Separate custom Android board rendering from puzzle state and input semantics. A `View` can stay leaner and more reusable when it delegates real actions into a game/runtime object through a small injection strategy.
- If save formats are likely to evolve, make migration explicit and automatic early. Versioned serializers plus a startup migration pass are much safer than ad hoc backward-compatibility fixes later.
- Benchmarks, screenshot tests, and integration tests are especially valuable in puzzle projects because regressions often show up as performance cliffs, layout drift, or solver correctness errors rather than as obvious crashes.

## Evidence Summary

- `Game.kt`, `GameLifecycle.kt`, `MainViewModel.kt` - puzzle runtime ownership, flow-projected state, timer handling, and next-grid orchestration
- `GridCalculationService.kt`, `GridPreviewCalculationService.kt`, `GridPreviewCalculator.kt` - background board generation, preview cache, pseudo preview fallback, and persisted prefetched boards
- `GridCalculatorFactory.kt`, `RandomCageGridCalculator.kt`, `DifficultyAwareGridCreator.kt`, `MergingCageGridCalculator.kt` - dual generation algorithms, uniqueness checking, difficulty-aware retries, and merge-based cage construction
- `HumanSolver.kt`, `HumanSolverStrategies.kt`, `HumanDifficultyCalculatorImpl.kt`, `difficulty-ratings.yml`, `docs/calculating-difficulties.md` - weighted human-style solver, threshold-based rating pipeline, and batch-calibrated difficulty data
- `GridUI.kt`, `GridUiInjectionDefaultStrategy.kt`, `KeyPadLayoutCalculator.kt` - custom Android puzzle rendering, input delegation, preview ribbons, and adaptive keypad layouts
- `SaveGame.kt`, `CurrentGameSaver.kt`, `SavedGamesService.kt`, `ApplicationPreferencesMigrations.kt`, `StatisticsManagerImpl.kt`, `MainApplication.kt` - versioned save migration, autosave plus snapshot saves, preference migration, statistics tracking, and startup wiring
- `build.gradle.kts`, `gauguin-app/build.gradle.kts`, `.github/workflows/build.yml`, `micro-benchmark/*`, `gauguin-app/src/test/kotlin/*ScreenshotTest.kt` - modern JDK21 build surface, CI, screenshot testing, and Android benchmark coverage

## Risks Or Limits

- The repository is GPL-3.0, so it is more suitable as an ideas-and-architecture reference than as a direct source for copy-paste reuse.
- The current lab environment cannot validate builds further because Gradle `9.3.1` already requires JVM `17+`, while the project itself targets JDK `21`.
- The most novel systems are specialized to arithmetic cage puzzles; reuse should focus on generation/difficulty/persistence patterns rather than on the domain-specific rule code itself.
- Some important UX/value claims, especially around perceived generation speed and layout behavior on many devices, would still benefit from future device-level verification instead of static reading alone.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `android-game`
- Focus tags: `2d`, `android`, `input`, `ui-hud`, `save-load`, `procedural-generation`, `testing`, `performance`
- Follow-up needed:
  - if the lab revisits this repository later, rerun `build`, screenshot tests, and one targeted benchmark in a real JDK `21` Android environment
  - a narrower follow-up could isolate just the preview/next-grid pipeline, the human-solver difficulty ladder, or the save-migration model instead of reopening the whole repository blindly
