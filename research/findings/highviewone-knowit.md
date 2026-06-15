# HighviewOne/KnowIt

- Repository: [HighviewOne/KnowIt](https://github.com/HighviewOne/KnowIt)
- Repository type: `android-game`
- Final status: `accepted`
- Reviewed on: `2026-06-15`
- License: `MIT`
- Stars at review: `0`
- Last pushed at review: `2026-06-12`
- Default branch: `main`
- Investigated commit: `0baf4af22caecde4ad10a65a6de0659064a2cd71`
- Build mode: `static-review + missing-windows-gradlew-bat`

## What This Repository Is

`KnowIt` is a compact Android trivia game built with Kotlin 2.0, Jetpack Compose, a single Android app module, and a small MVVM-style state shell around one fixed 20-question session flow.

The checked-in tree is small but real:

- one Android app module with no external game engine
- three main screens: home, game, and results
- one `GameViewModel` that owns scoring, streaks, phase switches, and answer validation
- a static `QuestionBank` plus a tiny DataStore-backed high-score repository
- a focused JVM unit-test file for core session and scoring behavior

## Why It Is Interesting For The Lab

- It is a direct Android Compose reference for a small knowledge-game shell that still keeps rules, scoring, and progression clearer than most toy single-screen samples.
- The repository shows a useful middle ground between very thin UI demos and heavier modular game products: simple enough to read quickly, but still preserving reusable session-state patterns.
- It complements other accepted Compose Android references in the lab by covering trivia, mixed input modes, streak scoring, and lightweight persistence rather than physics or board logic.

## Architecture Snapshot

### 1. The main reusable seam is a single session-oriented `GameViewModel`

- `app/src/main/kotlin/com/knowit/viewmodel/GameViewModel.kt` owns the entire runtime state through one `MutableStateFlow<GameState>`.
- `GamePhase` switches among `HOME`, `PLAYING`, and `GAME_OVER`, while `GameState` carries question list, index, score, streak, selected answer state, high score, and result metadata.
- This is a useful Android pattern for small games: one explicit state holder is enough when the product flow is linear and the rules surface is compact.

### 2. The gameplay loop is event-driven rather than frame-driven

- There is no custom render loop or tick thread here.
- `startGame()`, `submitMultipleChoiceAnswer(...)`, `submitTypeInAnswer()`, `advanceToNextQuestion()`, and `goHome()` move the session forward by explicit events.
- That makes the repository valuable less as an animation/runtime baseline and more as a reusable pattern for turnless quiz or puzzle-session products where UI reacts to state transitions instead of a continuous simulation clock.

### 3. Mixed answer modes are handled cleanly inside one state machine

- `QuestionType` supports both `MULTIPLE_CHOICE` and `TYPE_IN`.
- `GameViewModel` reuses one scoring and streak model for both input styles while still keeping mode-specific behavior narrow: shuffled options for multiple choice, `typeInText` plus `acceptedAnswers` for free text.
- This is a practical reference for small Android games that need to mix interaction styles without creating completely separate controllers or screen families.

### 4. Scoring and streak logic are readable and testable

- Correct answers award `10` points, and consecutive correct answers after the first add a `5` point streak bonus.
- The logic is visible directly in `submitMultipleChoiceAnswer(...)` and `submitTypeInAnswer()`, where base points, streak bonus, updated streak, and `lastPointsAwarded` are derived before writing the next immutable state snapshot.
- The main reusable value is not novelty but clarity: the reward model is explicit, local, and already covered by tests.

### 5. Persistence is intentionally tiny and separated from the session rules

- `app/src/main/kotlin/com/knowit/data/HighScoreRepository.kt` uses DataStore Preferences to keep only the best score.
- `GameViewModel` loads the high score at init and persists a new score only when the session ends.
- This is a good small-product seam: meta progression is preserved without polluting the gameplay state machine with Android storage details.

### 6. The Compose shell is polished but still straightforward

- `MainActivity.kt` simply hosts the theme, creates the `GameViewModel`, and switches between `HomeScreen`, `GameScreen`, and `ResultScreen` based on `state.phase`.
- `GameScreen.kt` adds a category progress bar, animated score counter, option reveal styling, wrong-answer shake, correct-answer glow, and a compact confetti overlay.
- `HomeScreen.kt` and `ResultScreen.kt` add pulse/bounce entrance effects, high-score display, grade computation, and a small product-shell presentation layer around the quiz flow.
- This gives the lab a readable Compose-first example of polishing a simple game without introducing Navigation Compose, complex feature modules, or an external runtime layer.

### 7. Question content is fixed and intentionally local

- `QuestionBank.kt` holds all 20 questions inline as code.
- That is useful for a tiny sample, but it also marks the architectural ceiling: there is no repository abstraction, localization/content pack pipeline, remote sync, or authoring format yet.
- The repository is therefore strongest as a compact app-shell and session-state reference, not as a content-system baseline.

## Reusable Technical Ideas

- one `StateFlow`-backed session state holder for a full small-game product flow
- shared scoring or streak logic across mixed multiple-choice and free-text answer modes
- DataStore-backed high-score persistence kept outside the gameplay state machine
- phase-based screen switching from one activity without extra navigation machinery
- lightweight Compose polish effects layered on top of straightforward event-driven state updates
- focused JVM tests for score, streak, answer validation, and session completion behavior

## Android Relevance

Android relevance is **direct**.

Why it matters:

- it is a real Android game built entirely with Kotlin and Jetpack Compose
- it preserves reusable product-shell and state-management ideas for compact quiz or casual knowledge games
- it gives the lab another clean Compose-native reference that is neither a pure animation demo nor an oversized multiproduct shell

Why it is still a compact reference:

- all question content is static and in-code
- the whole product lives in one app module with one main `ViewModel`
- there is no deeper engine/runtime layer or content-authoring system

## Build And Verification Notes

- The repository checks in `gradlew` but does not include `gradlew.bat`, so the normal Windows wrapper-based Gradle discovery path cannot run in this lab.
- `README.md` explicitly says Android Studio sync is expected to generate the wrapper jar; this is a real reproducibility caveat for clean Windows CLI validation.
- `app/build.gradle.kts` targets `compileSdk 35`, `minSdk 26`, `targetSdk 35`, Kotlin `2.0.21`, AGP `8.6.1`, and Java/Kotlin `17`.
- The visible automated verification surface is small but real:
  - `GameViewModelTest.kt` covers start state, score progression, streak bonus, duplicate-submission guards, case-insensitive answers, alternate accepted answers, blank-input handling, session completion, and high-score persistence calls
  - `.github/workflows/build.yml` builds a debug APK on push and pull request with JDK `17`

## Risks And Caveats

- The build/release story is weaker on Windows because `gradlew.bat` is missing and the checked-in wrapper is incomplete until Android Studio sync fills in missing pieces.
- Content is hardcoded in `QuestionBank.kt`, so the repository does not yet show scalable question-authoring, localization, or category-expansion patterns.
- `GameViewModel` duplicates some scoring logic between multiple-choice and type-in handlers; this is readable at current scale but not ideal if the game grows more answer modes.
- Some README text and emoji display with visible encoding corruption in this environment.

## Verdict

Keep `HighviewOne/KnowIt` as `accepted`.

It is a good `android-game` reference for the lab because it preserves a direct Android Compose product shell, a clear session-state architecture, reusable streak and answer-validation logic, lightweight persistence, and a real if compact test surface rather than only a thin UI demo.
