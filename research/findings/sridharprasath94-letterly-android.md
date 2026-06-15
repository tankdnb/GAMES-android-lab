# sridharprasath94/Letterly-Android

- Repository: [sridharprasath94/Letterly-Android](https://github.com/sridharprasath94/Letterly-Android)
- Repository type: `android-game`
- Final status: `accepted`
- Reviewed on: `2026-06-15`
- License: `MIT`
- Stars at review: `1`
- Last pushed at review: `2026-06-12`
- Default branch: `main`
- Investigated commit: `f030ad0443683ca685e22f8d00fe5eacd28be6d1`
- Build mode: `static-review + gradle-help + unit-test-dry-run-failed-missing-android-sdk`

## What This Repository Is

`Letterly-Android` is a Wordle-style Android puzzle game built with Kotlin, Android Views/XML, Fragments, Navigation, Hilt, Room, and a cleanly separated domain-use-case layer.

The checked-in tree is more substantial than a simple screen demo:

- one Android app module with real `data`, `domain`, and `presentation` layering
- multiple word-length modes with mode-specific board sizes and hint limits
- Room-backed local word storage and validation
- resumable per-mode save state
- statistics tracking and streak recording
- AI-powered hint integration through a remote hint worker seam
- a broad set of JVM tests around the domain use cases

## Why It Is Interesting For The Lab

- It is a direct Android reference for a word-puzzle product that preserves stronger boundaries between rules, persistence, and UI than most small casual-game repositories.
- The repository shows a useful alternative to the Compose-heavy part of the lab: a modern single-activity, fragment-based Android Views shell with `StateFlow`, Navigation, and Hilt.
- It is especially valuable as a state-management and puzzle-rules reference because the word-validation, duplicate-check, evaluation, keyboard coloring, and save/load behavior are all split into explicit use cases.

## Architecture Snapshot

### 1. The main strength is the domain-use-case game flow

- `app/src/main/java/com/flash/letterly/presentation/game/GameViewModel.kt` orchestrates the session, but most real game rules are pushed into domain use cases.
- The flow for one guess is intentionally decomposed:
  - `CheckDuplicateGuessUseCase`
  - `CheckWordExistsUseCase`
  - `EvaluateGuessUseCase`
  - `ApplyGuessResultUseCase`
  - `UpdateKeyboardStateUseCase`
  - `CheckGameStatusUseCase`
- This is one of the cleaner small-game examples in the lab for avoiding a giant all-in-one `ViewModel` method even when the product is still compact.

### 2. The game shell supports several difficulty modes without forking the architecture

- `GameMode.kt` maps `CLASSIC`, `ADVANCED`, and `EXPERT` to different word lengths, guess counts, hint counts, and labels.
- `GameFragment` derives its grid span and subtitle from the selected mode, while `createBoard(...)` and the save-state model stay mode-aware.
- The reusable idea is modest but useful: one puzzle shell can scale difficulty by parameters instead of by copy-pasted screens or controllers.

### 3. Guess evaluation logic is local, pure, and covered by tests

- `EvaluateGuessUseCase.kt` uses the standard two-pass Wordle-style algorithm:
  - first mark exact-position matches as `CORRECT`
  - then consume remaining unmatched target letters for `PRESENT`
- `EvaluateGuessUseCaseTest.kt` covers exact matches, absent letters, all-present cases, and duplicate-letter edge cases in guess and target words.
- This is a strong reusable rules-core reference for word puzzles because the logic is both readable and validated.

### 4. Game progress, keyboard state, and resume data are explicitly persisted

- `GameStateRepositoryImpl.kt` stores active game state per `GameMode` via `SharedPreferences` plus Gson serialization.
- `StatsRepositoryImpl.kt` persists aggregate stats separately.
- `GameViewModel.startGame(...)` first tries to load a saved mode-specific session before creating a new one.
- `SaveLoadClearGameStateUseCaseTest.kt` verifies save/load/clear isolation across modes.
- This gives the lab a good Android-native pattern for resumable puzzle sessions without overcomplicating storage.

### 5. The repository keeps UI and controls straightforward but not trivial

- `GameFragment.kt` hosts the board through `RecyclerView` with `GridLayoutManager`, a custom keyboard view/controller, lifecycle-aware state collection, and event-driven dialogs/snackbars.
- `KeyboardController` and the keyboard helper extensions keep the on-screen input seam isolated from the game rules.
- This is a practical direct-Android reference for games that want a typed board plus soft keyboard control model without building a custom rendering engine.

### 6. The data layer is richer than the average small Wordle clone

- `WordRepositoryImpl.kt` fronts a `WordListDao` and Room entities for dictionary lookup and random-word selection by length.
- `UpdateWordTimestampUseCase` indicates the product already tracks word reuse timing rather than always sampling naively.
- `GetHintUseCase` depends on a repository seam rather than wiring network behavior into UI code, which keeps the remote hint path optional and replaceable.

### 7. The repository still stays product-focused rather than engine-like

- There is no reusable rendering/runtime layer here; this is a puzzle product shell, not a game framework.
- That is fine for the lab: its value is in state orchestration, domain rules, and Android app architecture rather than graphics or simulation.

## Reusable Technical Ideas

- use-case-driven guess submission flow instead of one monolithic `ViewModel`
- parameterized puzzle modes sharing one board/session architecture
- tested two-pass Wordle-style duplicate-letter evaluation
- mode-scoped save-state persistence for resumable puzzle sessions
- keyboard-color state derived as a separate use case rather than directly in the fragment
- Room-backed local dictionary with random-word selection by length
- direct Android Views/Fragments shell that still uses modern `StateFlow`, Hilt, and Navigation

## Android Relevance

Android relevance is **direct**.

Why it matters:

- it is a real Android game product with modern app architecture and a current build stack
- it gives the lab a non-Compose reference for puzzle-shell structure, soft-keyboard input, and resumable state
- it preserves several reusable Android-friendly product patterns beyond the narrow word-evaluation algorithm

Why it is still narrower than an engine or large systems repo:

- rendering is standard Android UI, not a custom game runtime
- most novelty is in puzzle-state orchestration rather than in graphics or simulation

## Build And Verification Notes

- `gradlew.bat help --no-daemon` succeeded locally, which is stronger than many recent Android candidates in this lab.
- `gradlew.bat testDebugUnitTest --dry-run --no-daemon` reached Android task resolution and then failed because no Android SDK is configured in the lab, not because of a Java/toolchain problem.
- `app/build.gradle.kts` targets `compileSdk 36`, `targetSdk 36`, `minSdk 24`, Java `11`, Kotlin `2.3.10`, and AGP `9.0.1`.
- The visible verification surface is meaningful:
  - many `domain/usecase/*Test.kt` files cover evaluation, duplicate checking, game status, stats, save/load/clear, keyboard-state updates, and timestamp updates
  - template `ExampleUnitTest` and `ExampleInstrumentedTest` still exist, but they are not the main test story
  - the README explicitly claims CI, and the repository includes `.github/`

## Risks And Caveats

- The repository README still markets the product partly around Compose-era terminology while the checked-in UI stack is Android Views/XML plus fragments; this is not wrong, but it can mislead a quick scanner expecting a Compose-first codebase.
- Hint generation depends on external network configuration (`hint_worker_url`) and supporting docs, so the AI-hint path is harder to validate locally than the pure puzzle core.
- The top-level build applies `ksp` without `apply false`, which is slightly unusual for a root script even though local `help` succeeded.
- Some README characters display with encoding corruption in this environment.

## Verdict

Keep `sridharprasath94/Letterly-Android` as `accepted`.

It is a strong `android-game` reference for the lab because it preserves a direct Android word-puzzle product with clean use-case boundaries, tested domain logic, resumable mode-scoped state, Room-backed dictionary handling, and a real modern Android app shell rather than only a thin Wordle clone.
