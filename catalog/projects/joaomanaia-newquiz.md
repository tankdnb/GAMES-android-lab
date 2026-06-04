# Project Entry

## Basic Info

- Project name: `NewQuiz`
- Source repository: [https://github.com/joaomanaia/newquiz](https://github.com/joaomanaia/newquiz)
- Author / organization: `joaomanaia`
- License: `Apache-2.0`
- Research note: [research/findings/joaomanaia-newquiz.md](../../research/findings/joaomanaia-newquiz.md)
- Investigated commit: `c6f3748ce80e0318a583f1785da728f7a3fdd0aa`
- Last verified: `2026-06-04`
- Activity / maintenance status: moderately stale at selection; the repository was last pushed on `2025-01-27`, but it still exposes a large modular surface, active CI configuration, and a substantial test tree.

## Short Description

Android-first Jetpack Compose trivia and word-game product with several quiz modes, a generated maze meta-mode, daily challenges, profile/progression tracking, and a `normal` / `foss` build split inside one modular Kotlin codebase.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `android`, `ui-hud`, `save-load`, `procedural-generation`, `testing`
- Engine / framework: Android SDK + Jetpack Compose + Material 3 + Hilt + WorkManager + Room + DataStore + Ktor + Firebase / Remote Config
- Rendering approach: Compose-first game and product UI with type-safe screen routing and per-mode state/controllers instead of a custom GL runtime
- Main language(s): Kotlin
- Android target: direct; Android is the primary target and the repository also distinguishes `normal` and `foss` Android distributions
- Build system: multi-module Gradle Kotlin DSL Android project with included convention plugins under `build-logic`

## Why It Matters

- `NewQuiz` is a strong reference for Android teams building a casual game product, not only a gameplay prototype.
- Its main value is the way multiple quiz modes, generated meta-content, progression, scheduled tasks, and flavor-specific dependencies stay modular and testable in one Compose-first Android app.

## Reusable Ideas

- Gameplay ideas:
  - seeded maze runs built from several quiz modes, remote-config-driven daily challenges, and several Wordle-like rule variants
- Architecture patterns:
  - one app shell above mode-specific controllers, a central user/progression service, worker-based endgame bookkeeping, and explicit `normal` / `foss` dependency routing
- Graphics / rendering techniques:
  - Compose-first game screens and product navigation without introducing a heavier rendering runtime than the product actually needs
- Input / UI approaches:
  - explicit answer, keyboard, skip, and route flows owned by per-mode `ViewModel`s with semantics-aware Compose surfaces
- Performance or optimization ideas:
  - keep persistent meta-state centralized, use workers for deferred bookkeeping, and personalize category lists through stored recents plus offline-aware filtering

## Notable Implementations

- `GenerateMazeQuizWorker` synthesizes a maze meta-mode from multi-choice, Wordle, and comparison-quiz generators.
- `DailyChallengeRepositoryImpl` derives daily tasks from shared `GameEvent` definitions instead of hardcoding them screen by screen.
- `LocalUserServiceImpl` centralizes XP, diamonds, level-up rewards, and game-result persistence.
- `RecentCategoriesRepositoryImpl` personalizes category discovery while respecting offline availability rules.
- `Flavors.kt` and the convention plugins encode a real `normal` / `foss` build split rather than scattering flavor logic across module build files.
- The repository carries a broad gameplay/data/UI test surface for a casual Android game product.

## Android Relevance

- Native Android use:
  - yes; this is a direct Android app rather than a desktop-first engine or a theoretical Android port
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - especially useful for Android quiz, puzzle, word, or mini-game products that need multiple modes, progression, scheduled content, and a polished Compose shell more than they need custom low-level rendering

## Risks / Limitations

- The repository is more valuable for Android product-shell and progression patterns than for low-level engine or rendering architecture.
- Code freshness is moderate rather than current; the last inspected push is `2025-01-27`.
- Local build verification in the lab is still blocked by the missing JDK, and full app builds would need `google-services.json`.
- The `foss` flavor is not yet a fully clean proprietary-free split according to the repository's own README.

## Notes

Treat `NewQuiz` as a strong Android product reference for multi-mode casual games: it is most reusable where game modes, progression, daily tasks, persistence, and distribution variants all need to stay readable in one Kotlin codebase.
