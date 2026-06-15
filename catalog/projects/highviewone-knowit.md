# KnowIt

- Project: [HighviewOne/KnowIt](https://github.com/HighviewOne/KnowIt)
- Category: `android-game`
- Status: `accepted`
- License: `MIT`
- Language: `Kotlin`
- Engine / stack: Android SDK + Jetpack Compose + AndroidX Lifecycle/ViewModel + DataStore
- Android relevance: direct Android trivia game with a Compose-only product shell
- Investigated commit: `0baf4af22caecde4ad10a65a6de0659064a2cd71`

## Short Description

`KnowIt` is a compact Android trivia game with fixed question content, mixed multiple-choice and type-in answers, streak scoring, and a small DataStore-backed high-score shell.

## Why It Matters

- Shows a clean direct-Android Compose approach for a small quiz-game product without introducing a custom runtime or heavy module split.
- Preserves reusable session-state, scoring, and lightweight persistence patterns that transfer well to casual knowledge or puzzle products.
- Adds a stronger quiz/trivia reference to the lab than broad but shallow mini-game bundles.

## Key Reusable Ideas

- one `StateFlow`-backed `GameViewModel` owning the full home/play/result session flow
- shared score or streak logic across multiple-choice and free-text answer modes
- phase-based Compose screen switching without extra navigation overhead
- DataStore-backed best-score persistence kept outside gameplay rules
- compact unit-test coverage for answer validation, streak bonuses, and game completion

## Main Caveats

- Windows wrapper validation is limited because `gradlew.bat` is not checked in
- all question content is hardcoded in one `QuestionBank.kt` file
- architecture is intentionally small and centered around one activity and one main `ViewModel`

## Suggested Focus Tags

`2d`, `android`, `input`, `ui-hud`, `save-load`, `testing`
