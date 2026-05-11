# Research Note

## Repository Snapshot

- Repository: `CescFe/numpairs`
- Source URL: [https://github.com/CescFe/numpairs](https://github.com/CescFe/numpairs)
- Owner: `CescFe`
- Batch ID: [`BATCH-2026-05-11-R`](../batches/BATCH-2026-05-11-R.md)
- Type: `android-game`
- License: `MIT`
- Selection date: `2026-05-11`
- Last pushed at selection: `2026-05-10`
- Stars at selection: `0`
- Investigated commit: `8b1b98549aded177db563230e73955cac3ae1b56`
- Research status: `accepted`
- Build mode: `static-review + gradle-help + test-dry-run-failed-missing-android-sdk`
- Catalog card: [catalog/projects/cescfe-numpairs.md](../../catalog/projects/cescfe-numpairs.md)

## Why This Repository Was Selected

- From the current carry-over backlog, `numpairs` offered the best balance of direct Android relevance, fresh maintenance, explicit licensing, and expected research yield.
- The repository stood out because it is unusually documentation-heavy for a small puzzle game: PRDs, UX notes, ADRs, game rules, and ubiquitous-language notes are all checked in beside the code.
- The remaining shortlisted alternatives still looked useful, but `numpairs` promised stronger Android product-architecture and state-modeling value than either the desktop-first `sgalluz/k2d` or the license-unclear `Efimj/GameOfLife`.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: Android SDK + Jetpack Compose + AndroidX Lifecycle/ViewModel
- Rendering stack: Compose UI primitives, Material3, bottom-sheet and popup-based editors, accessibility semantics, and a single-activity Android shell
- Android target: direct Android app
- Build system: single-module Gradle Kotlin DSL Android project with version catalog and explicit Gradle daemon JVM toolchain configuration
- Repository layout summary: `app` contains the runtime, domain, presentation, and UI layers; `docs/` contains product PRDs, UX decisions, ADRs, game rules, and ubiquitous-language notes; `.github/workflows/validate-android.yml` defines CI validation
- Source footprint:
  - total files reviewed in repository: `127`
  - Kotlin/Java files reviewed across the repository: `69`
- Test surface:
  - test files found: `32`
  - meaningful gameplay-specific tests found: `32`
- Key modules reviewed:
  - `README.md`
  - `settings.gradle.kts`
  - `build.gradle.kts`
  - `app/build.gradle.kts`
  - `gradle/libs.versions.toml`
  - `gradle/gradle-daemon-jvm.properties`
  - `.github/workflows/validate-android.yml`
  - `docs/game-rules.md`
  - `docs/ui-behavior.md`
  - `docs/ubiquitous-language.md`
  - `docs/technical/adr/adr-001-choose-native-android-app.md`
  - `docs/technical/adr/adr-002-use-jetpack-compose.md`
  - `docs/technical/adr/adr-003-use-stable-strip-entry-identity.md`
  - `app/src/main/java/org/cescfe/numpairs/MainActivity.kt`
  - `app/src/main/java/org/cescfe/numpairs/ui/navigation/AppNavigation.kt`
  - `app/src/main/java/org/cescfe/numpairs/feature/game/GameRoute.kt`
  - `app/src/main/java/org/cescfe/numpairs/feature/game/presentation/GameViewModel.kt`
  - `app/src/main/java/org/cescfe/numpairs/feature/game/presentation/GamePresentationState.kt`
  - `app/src/main/java/org/cescfe/numpairs/feature/game/presentation/GameUiState.kt`
  - `app/src/main/java/org/cescfe/numpairs/feature/game/presentation/GameUiStateFactory.kt`
  - `app/src/main/java/org/cescfe/numpairs/feature/game/ui/GameScreen.kt`
  - `app/src/main/java/org/cescfe/numpairs/feature/game/ui/GameScreenLayout.kt`
  - `app/src/main/java/org/cescfe/numpairs/feature/game/ui/GameScreenDialogs.kt`
  - `app/src/main/java/org/cescfe/numpairs/feature/game/ui/GameScreenFeedback.kt`
  - `app/src/main/java/org/cescfe/numpairs/feature/game/ui/GameScreenSemantics.kt`
  - `app/src/main/java/org/cescfe/numpairs/feature/game/ui/components/PuzzleTile.kt`
  - `app/src/main/java/org/cescfe/numpairs/domain/puzzle/Puzzle.kt`
  - `app/src/main/java/org/cescfe/numpairs/domain/puzzle/PuzzleValidation.kt`
  - `app/src/main/java/org/cescfe/numpairs/domain/puzzle/Strip.kt`
  - `app/src/main/java/org/cescfe/numpairs/domain/puzzle/OperandSelection.kt`
  - `app/src/main/java/org/cescfe/numpairs/data/puzzle/seed/InitialPuzzle.kt`
  - `app/src/test/java/org/cescfe/numpairs/domain/puzzle/PuzzleCompletionStateTest.kt`
  - `app/src/test/java/org/cescfe/numpairs/feature/game/presentation/GameViewModelStripEntryTest.kt`
  - `app/src/androidTest/java/org/cescfe/numpairs/feature/game/ui/GameScreenAccessibilityTest.kt`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeds and reports Gradle `9.4.1` running from a Java `8` launcher while advertising a daemon JVM compatible with Java `21`.
- `cmd /c gradlew.bat help --no-daemon` also succeeds. The important detail is that the build forks a single-use daemon and honors `gradle/gradle-daemon-jvm.properties`, which pins `toolchainVersion=21`.
- `cmd /c gradlew.bat :app:testDebugUnitTest --dry-run --no-daemon` fails before task graph execution because the lab machine has no configured Android SDK:
  - `SDK location not found. Define a valid SDK location with an ANDROID_HOME environment variable or by setting the sdk.dir path...`
- The checked-in build surface is modern and coherent:
  - `app/build.gradle.kts` targets `compileSdk 36.1`, `targetSdk 36`, `minSdk 26`, and Java `11`
  - `gradle/libs.versions.toml` pins AGP `9.2.1`, Kotlin `2.3.21`, and Compose BOM `2026.05.00`
  - `.github/workflows/validate-android.yml` sets up JDK `21`, Android SDK `36.1`, then runs `spotlessCheck`, `lintDebug`, `testDebugUnitTest`, and `assembleDebug`
- The repository therefore looks better than many earlier batches from a reproducibility perspective: local validation is blocked by missing Android SDK setup rather than by broken metadata, dead repositories, or an unsatisfied Java floor.
- No runtime launch was attempted.

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `3`
- Implementation depth: `3`
- Code clarity: `3`
- Novelty: `3`
- Overall verdict: `accepted`
- Why:
  - `numpairs` is one of the clearest direct Android references in the lab for turning a small puzzle game into a disciplined product repository with ADRs, game rules, UX behavior specs, and a clean Compose implementation.
  - Its strongest value is not raw content breadth, but the way it combines stable domain modeling, presentation-state separation, accessibility-aware UI, and real automated tests inside a still-manageable codebase.
  - It is especially useful as a reference for Android teams building puzzle or logic-heavy games that need correct identity/validation semantics rather than a large engine shell.

## Interesting Findings

### Documentation-First Product Architecture

- `README.md`, `docs/game-rules.md`, `docs/ui-behavior.md`, `docs/ubiquitous-language.md`, and the `docs/product/` tree make the repository unusually explicit about intent. The code is not left to imply the rules; the rules, vocabulary, and UX expectations are written down first.
- `docs/technical/adr/adr-001-choose-native-android-app.md` and `adr-002-use-jetpack-compose.md` show a small but valuable habit: even a narrow Android puzzle game can keep architecture decisions durable and searchable instead of burying them in chat or commit history.
- `adr-003-use-stable-strip-entry-identity.md` is the standout document. It explains why identity must follow the underlying strip entry rather than a numeric value or a visual slot once repeated values and in-run reorder behavior exist.

### Domain Modeling And Validation

- `app/src/main/java/org/cescfe/numpairs/domain/puzzle/Strip.kt` preserves ascending visible order without treating position as identity. `withUpdatedEntry()` only reorders player-entered values inside the affected editable run and keeps known values fixed.
- `OperandSelection.kt` models operand availability per strip entry with operator-specific usage counters plus provisional hidden-operator usage. The three availability states are `AVAILABLE`, `EXHAUSTED`, and `BLOCKED_BY_OPPOSITE_OPERAND`, with a hard cap of `MAX_ASSIGNMENTS_PER_STRIP_ENTRY = 2`.
- `Puzzle.kt` and `PuzzleValidation.kt` define a richer completion model than most small puzzle samples:
  - `INCOMPLETE`
  - `INCORRECT_TILES`
  - `MISSING_STRIP_ENTRY_IDENTITIES`
  - `MISMATCHED_SUM_PRODUCT_PAIRINGS`
  - `INVALID_STRIP_ENTRY_USAGE`
  - `SOLVED`
- `PuzzleValidation.kt` validates sum/product pair consistency by comparing unordered strip-entry pairs instead of only checking tile-local arithmetic. That is a strong reusable idea for logic games where correctness depends on cross-tile pairing semantics rather than one cell at a time.

### Presentation-State Separation And Compose Interaction Flow

- `GameViewModel.kt` keeps the immutable puzzle domain state separate from ephemeral UI flow. `Puzzle` owns rules and values; `GamePresentationState` only tracks modal/overlay concerns; `GameUiState` is derived through `GameUiStateFactory`.
- This separation is more disciplined than many small Compose game samples. The view-model commits domain changes, updates presentation state, and republishes one derived UI snapshot only when something actually changed.
- The UI flow itself is product-minded:
  - strip entry editing uses a dialog
  - operand selection uses a compact bottom sheet
  - operator selection uses an anchored popup
  - invalid tiles remain editable
  - solved state is shown through a dismissible success overlay
- `GameScreenAccessibilityTest.kt` and the wider `androidTest` suite show that the accessibility semantics are not decorative. Core regions and hidden-slot descriptions are asserted directly.

### Strong Test And Validation Surface For A Small Game

- The repository includes `32` test files across domain, presentation, and Compose UI layers. That is significantly stronger than the norm for small Android puzzle samples.
- Unit tests cover domain and controller behavior such as completion-state evaluation, strip-entry updates, operator/operand selection, and presentation-state mapping.
- Instrumented tests cover actual Compose UI behavior such as accessibility descriptions, strip-entry dialogs, operand selector behavior, operator selector behavior, large operands, tile state, and success overlay flows.
- `.github/workflows/validate-android.yml` completes the picture by running formatting, lint, unit tests, and APK assembly in CI.

## Reusable Takeaways

- Small Android games benefit from the same durable artifacts as larger apps: ADRs, ubiquitous language, UI behavior specs, and explicit rules reduce ambiguity when the puzzle logic evolves.
- If repeated visible values can move or reorder, model identity at the domain-element level rather than at the display-slot or raw-value level.
- Compose puzzle UIs are easier to reason about when immutable game state and transient UI/presentation state are kept separate and combined into a derived screen model.
- Accessibility should be treated as a first-class part of a mobile puzzle game's surface, not as a late polish step after the interaction model is already fixed.

## Evidence Summary

- `docs/technical/adr/adr-001-choose-native-android-app.md`, `adr-003-use-stable-strip-entry-identity.md`, `docs/game-rules.md`, `docs/ui-behavior.md`, `docs/ubiquitous-language.md` - durable rules, vocabulary, UX, and modeling decisions
- `Puzzle.kt`, `PuzzleValidation.kt`, `Strip.kt`, `OperandSelection.kt` - stable strip-entry identity, editable-run reorder logic, layered completion states, and operator-specific usage validation
- `GameViewModel.kt`, `GamePresentationState.kt`, `GameUiState.kt`, `GameUiStateFactory.kt` - separated domain/presentation state and derived Compose UI state
- `GameScreen.kt`, `GameScreenDialogs.kt`, `GameScreenFeedback.kt`, `GameScreenSemantics.kt`, `PuzzleTile.kt` - mobile-first editing flows, visual feedback, and accessibility semantics
- `GameViewModelStripEntryTest.kt`, `PuzzleCompletionStateTest.kt`, `GameScreenAccessibilityTest.kt`, `.github/workflows/validate-android.yml` - meaningful verification across domain, UI, and CI

## Risks Or Limits

- The repository still has almost no public ecosystem signal yet; `0` stars means the lab should treat it as a promising low-signal reference rather than as widely validated community practice.
- The current gameplay content is still seed-based through `InitialPuzzle.kt`, so the repository is stronger as a product-architecture and validation reference than as a content-pipeline or progression reference.
- There is no visible persistence, meta-progression, or multi-level puzzle-delivery system yet.
- Local Android task validation in this lab still needs a configured SDK. The current limitation is environmental, but full task execution was not completed here.
- The repository is specific to one arithmetic pairing puzzle, so the reusable value comes mostly from modeling, Compose UX, and verification patterns rather than from broad engine/runtime techniques.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `android-game`
- Focus tags: `2d`, `android`, `input`, `ui-hud`, `testing`
- Follow-up needed:
  - rerun Android tasks in an SDK-ready environment to confirm the checked-in CI path locally
  - if the lab revisits this repository later, isolate the stable identity model, the layered completion-state validator, or the accessibility-tested Compose editing flow instead of reopening the whole codebase broadly
