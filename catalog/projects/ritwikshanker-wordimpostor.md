# Word Impostor

## Basic Info

- Project name: Word Impostor
- Source repository: https://github.com/ritwikshanker/WordImpostor
- Author / organization: `ritwikshanker`
- License: MIT
- Research note: [research/findings/ritwikshanker-wordimpostor.md](../../research/findings/ritwikshanker-wordimpostor.md)
- Investigated commit: `46f8b00e39d5150875907fa7f818f22228968e00`
- Last verified: `2026-07-13`
- Activity / maintenance status: created `2025-11-30`, last pushed `2026-07-12`, not archived, 1 star at selection.

## Short Description

`Word Impostor` is a direct Android pass-the-phone social-deduction word game built with Kotlin, Jetpack Compose, Material 3, Navigation Compose, a `StateFlow`-backed `ViewModel`, Preferences DataStore settings, and Google Play In-App Review integration.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `android`, `ui-hud`, `input`, `save-load`, `testing`
- Engine / framework: Android SDK, Jetpack Compose, Material 3, AndroidX Lifecycle/ViewModel
- Rendering approach: Compose screens and Material components with reveal/summary animations
- Main language(s): Kotlin
- Android target: direct Android app, `compileSdk = 36`, `minSdk = 26`, `targetSdk = 36`
- Build system: Gradle `9.6.1`, AGP `9.2.1`, Kotlin `2.2.10`

## Why It Matters

- It is a compact direct Android reference for local multiplayer party-game flow, especially pass-the-phone privacy and role reveal UX.
- The phase-state model is small enough to study quickly but covers the full loop: setup, role reveal, clue, discussion, voting, elimination, win check, and final summary.
- It demonstrates how a Compose-only small game can keep most gameplay ownership in a `ViewModel` while using screens as phase renderers.

## Reusable Ideas

- Gameplay ideas: civilian/impostor role assignment, clue rounds, configurable voting ties, round history, and simple win-condition checks.
- Architecture patterns: sealed `GamePhase`, one `StateFlow<GameState>` session owner, DataStore-backed settings, and pure review-gate policy separated from Play Core calls.
- Input / UI approaches: pass-the-phone reveal overlay, one-word clue input filtering, separate voter/target selection, Material 3 phase screens.
- Persistence ideas: lightweight Preferences DataStore for settings and review counters without prematurely persisting the whole active match.
- Testing ideas: keep policy gates and content repository invariants pure enough for fast JVM tests.

## Notable Implementations

- `GameViewModel` owns role assignment, clue timers, voting, tie behavior, eliminations, win checks, and reset flow.
- `GamePhase` represents the game loop as explicit sealed states.
- `RoleRevealScreen` separates "tap to reveal role" from "pass the phone" to protect private information.
- `SettingsRepository` persists timer, difficulty, voting, theme, dynamic color, and review prompt counters in DataStore.
- `ReviewGate` keeps in-app review prompting rules pure and testable.

## Android Relevance

- Native Android use: direct single-module Android app with Compose, DataStore, Navigation Compose, Material 3, and Play Review.
- Kotlin relevance: the phase-state and ViewModel flow are Kotlin-first and easy to adapt into other Android party or board games.
- Porting or adaptation notes: add `GameViewModel` unit tests before copying the phase machine into production; clean README/source encoding issues; verify build in a Java `17+` and Android SDK-ready environment.

## Risks / Limitations

- Local lab build discovery is blocked by Java `8`; Gradle `9.6.1` requires Java `17+`.
- README says JDK `11+`, which is stale relative to the checked wrapper.
- README and some source text display mojibake in the Windows terminal.
- The core phase machine is not visibly covered by tests.
- `Player` mixes data-class copying with mutable properties.

## Notes

Best reuse targets are the sealed phase model, pass-the-phone role reveal UX, DataStore settings shell, pure review prompt gate, and the compact Android Compose party-game screen flow.
