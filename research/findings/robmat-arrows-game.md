# Research Note

## Repository Snapshot

- Repository: `robmat/arrows_game`
- Source URL: [https://github.com/robmat/arrows_game](https://github.com/robmat/arrows_game)
- Owner: `robmat`
- Batch ID: [`BATCH-2026-06-05-B`](../batches/BATCH-2026-06-05-B.md)
- Type: `android-game`
- License: `GPL-3.0`
- Selection date: `2026-06-05`
- Last pushed at selection: `2026-03-05`
- Stars at selection: `9`
- Default branch at selection: `master`
- Investigated commit: `3cfd2718f9d03723d56bd09d85c30e275038922e`
- Research status: `accepted`
- Build mode: `static-review + gradle-version + gradle-help-failed-java8-needs-java17`
- Catalog card: [catalog/projects/robmat-arrows-game.md](../../catalog/projects/robmat-arrows-game.md)

## Why This Repository Was Selected

- `robmat/arrows_game` was the strongest remaining Android-first candidate in the exact-license short backlog after `flyko-lib`.
- It had the best balance of direct platform relevance, manageable repository size, current enough maintenance, and likely subsystem yield for another gameplay-focused batch.
- The main question for this batch was whether it is only a compact puzzle product or whether it also preserves reusable architecture and puzzle-generation ideas worth keeping in the main catalog.
- The answer is `accepted`: the repo is a real Android game product with a reusable solvability-aware generation core, modular Android app structure, a practical save/resume shell, and stronger testing/build discipline than its star count suggests.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: Android SDK + Jetpack Compose + Room + Appyx + Koin
- Rendering stack: Compose UI with custom `Canvas` board rendering and animated game-state overlays
- Android target: direct Android app
- Build system: Gradle `9.4.0` wrapper + AGP `9.1.0` + Kotlin `2.3.10`
- Repository layout summary:
  - `app/` - Android application shell, coverage task, and top-level dependency assembly
  - `feature:*` - game, home, generate, and settings features
  - `domain/` - puzzle generation, solvability, and level progression logic
  - `data/` - Room persistence, preferences, and board-shape providers
  - `navigation/` - Appyx root navigation graph
  - `core:*` - shared models, resources, UI, and testing helpers
- Source footprint:
  - total files counted in repository: `241`
  - Kotlin/Kotlin DSL/Java files counted in repository: `116`
- Test surface:
  - files matching `*Test.kt`: `17`
  - visible tests cover generator rules, shape/fill-board behavior, game-engine behavior, navigation, and feature-level view-model state
- Key modules reviewed:
  - `README.md`
  - `settings.gradle.kts`
  - `build.gradle.kts`
  - `gradle/libs.versions.toml`
  - `app/build.gradle.kts`
  - `feature/game/build.gradle.kts`
  - `data/build.gradle.kts`
  - `domain/src/main/java/com/batodev/arrows/engine/GameGenerator.kt`
  - `domain/src/main/java/com/batodev/arrows/engine/SolvabilityChecker.kt`
  - `feature/game/src/main/java/com/batodev/arrows/engine/GameEngine.kt`
  - `feature/game/src/main/java/com/batodev/arrows/engine/LevelManager.kt`
  - `feature/game/src/main/java/com/batodev/arrows/engine/InputHandler.kt`
  - `feature/game/src/main/java/com/batodev/arrows/ArrowsBoardRenderer.kt`
  - `data/src/main/java/com/batodev/arrows/data/UserPreferencesRepository.kt`
  - `data/src/main/java/com/batodev/arrows/data/AppDatabase.kt`
  - `data/src/main/java/com/batodev/arrows/data/AndroidResourceBoardShapeProvider.kt`
  - `feature/home/src/main/java/com/batodev/arrows/ui/AppViewModel.kt`
  - `navigation/src/main/java/com/batodev/arrows/navigation/RootNode.kt`
  - `ANDROID_IMPROVEMENTS.md`
  - `MODULARIZATION_PLAN.md`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeded after redirecting `GRADLE_USER_HOME` into the workspace:
  - Gradle `9.4.0`
  - Launcher JVM `1.8.0_321`
- `cmd /c gradlew.bat help --no-daemon` then failed for an expected environment reason:
  - `Gradle requires JVM 17 or later to run. Your build is currently configured to use JVM 8.`
- The failure shape is a lab limitation rather than a repository-level break:
  - `app/build.gradle.kts` targets Java `11`
  - the root build uses AGP `9.1.0` and Kotlin `2.3.10`
  - the checked-in Gradle wrapper is current and healthy
- The visible build/test surface is stronger than average for a small Android puzzle repository:
  - Detekt over all subprojects
  - custom JaCoCo report task in `app/`
  - modular `build-logic/` setup already checked in
  - real tests across `domain`, `data`, `feature:game`, `feature:home`, and `navigation`

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `3`
- Implementation depth: `3`
- Code clarity: `3`
- Novelty: `2`
- Overall verdict: `accepted`

## Interesting Findings

### Engine Architecture And Core Loop

- `feature/game/src/main/java/com/batodev/arrows/engine/GameEngine.kt` keeps generated or loaded level state, lives, animations, hint flow, and win/lose progression in one feature-level controller instead of scattering that logic across composables.
- `GameEngine.kt` computes explicit UI states (`Loading`, `Playing`, `Won`, `GameOver`) from internal runtime state instead of making the UI infer product flow from unrelated flags.
- `feature/game/src/main/java/com/batodev/arrows/engine/LevelManager.kt` separates runtime orchestration from the generator itself:
  - load current and initial board snapshots
  - calculate level progression settings
  - choose random or forced board shapes
  - regenerate and persist level state
- `navigation/src/main/java/com/batodev/arrows/navigation/RootNode.kt` shows a practical typed Appyx navigation shell for a small Android game.

### Gameplay Systems

- `domain/src/main/java/com/batodev/arrows/engine/GameGenerator.kt` builds snake placements from frontier candidates, supports shaped boards, can optionally fill the board more aggressively, and reports progress during generation.
- `domain/src/main/java/com/batodev/arrows/engine/SolvabilityChecker.kt` is the strongest reusable subsystem:
  - verifies that a generated board can actually be solved
  - iteratively removes snakes whose line of sight is clear
  - exposes helper logic such as `findRemovableSnake` and `isLineOfSightObstructed`
- Together, `GameGenerator.kt` plus `SolvabilityChecker.kt` form a strong pattern for future Android puzzle work: generation and validation are separate, deterministic, and testable.
- `feature/game/src/main/java/com/batodev/arrows/engine/InputHandler.kt` uses head-biased tap hit areas and prioritizes unobstructed targets, which is a good interaction pattern for dense puzzle boards.

### Rendering And Graphics

- `feature/game/src/main/java/com/batodev/arrows/ArrowsBoardRenderer.kt` is a high-value Compose rendering reference:
  - centered board metrics derived from available canvas size
  - snake bodies rendered as curved paths instead of rigid cell blocks
  - entry and removal animations handled through interpolated path geometry
  - optional guidance lines and debug tap areas
- The renderer also shows a useful visual polish pattern: the tail tip shrinks continuously along the body path during removal instead of snapping cell-by-cell.
- `GameEngine.kt` keeps renderer-facing animation state in explicit maps (`entryProgress`, `removalProgress`) instead of baking animation assumptions into the board model.

### Persistence And Data

- `data/src/main/java/com/batodev/arrows/data/AppDatabase.kt` combines user preferences, saved current board, saved initial board, and snake body point persistence.
- `LevelManager.kt` makes save/resume semantics explicit by storing both `INITIAL` and `CURRENT` board snapshots. That is a reusable pattern for puzzle games where restart and resume need different anchors.
- `UserPreferencesRepository.kt` is intentionally broad but honest: for a single-row preferences entity, it keeps one repository instead of over-abstracting settings state into several tiny classes.

### Android Platform Integration

- `feature/home/src/main/java/com/batodev/arrows/ui/AppViewModel.kt` exposes preferences, save-slot presence, ad-related counters, and debug-generation overrides through `StateFlow` without infecting the pure domain generator.
- `AndroidResourceBoardShapeProvider.kt` is a clean Android-side seam for optional non-rectangular level shapes backed by bitmap resources.
- `app/build.gradle.kts` shows a realistic small-game Android shell with debug coverage, release/debug ad-ID split, and modular feature assembly.

### Build, Release, And Testing

- `gradle/libs.versions.toml`, `build-logic/`, and the root build confirm this is not an improvised one-module sample. The repo already centralizes build conventions, dependency versions, and static analysis.
- `ANDROID_IMPROVEMENTS.md` and `MODULARIZATION_PLAN.md` are useful signals that the author is explicitly comparing the project against stronger Android architecture references and planning further cleanup.
- The checked-in test surface is meaningful for this kind of repository:
  - generator behavior
  - board-shape rules
  - fill-board caps
  - game-engine tap and completion behavior
  - navigation behavior
  - feature-level view-model behavior

## Reusable Takeaways

- Puzzle generation should be separated from solvability validation instead of trusting randomness.
- Saving both the initial board and the current board is a strong restart/resume pattern for deterministic puzzle games.
- Compose `Canvas` can support expressive puzzle rendering when path geometry and animation state stay outside the domain board model.
- A small Android game benefits from real modularization: feature modules, root navigation, shared data/domain layers, and test coverage all improved the long-term research value of this repository.

## Risks Or Limits

- The repository is Android-first and product-specific, so some logic is tightly coupled to this exact puzzle genre.
- GPL-3.0 licensing makes it stronger as an architecture/reference source than as a direct copy-paste implementation source for many downstream teams.
- Local Gradle validation in this lab still stops at the Java `17+` floor because the machine exposes Java `8`.
- The checked-in architecture-improvement docs are useful, but they also confirm the project is still evolving rather than being fully settled.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `android-game`
- Focus tags: `2d`, `android`, `procedural-generation`, `ui-hud`, `input`, `save-load`, `testing`
- Follow-up needed:
  - if the lab revisits this repository, do it in a JDK `17+` plus Android SDK-ready environment and keep the scope narrow: the solvability checker, shaped-board generator, Compose board renderer, or save/resume shell instead of reopening the full project broadly
