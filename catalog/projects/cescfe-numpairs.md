# Project Entry

## Basic Info

- Project name: `NumPairs`
- Source repository: [https://github.com/CescFe/numpairs](https://github.com/CescFe/numpairs)
- Author / organization: `CescFe`
- License: `MIT`
- Research note: [research/findings/cescfe-numpairs.md](../../research/findings/cescfe-numpairs.md)
- Investigated commit: `8b1b98549aded177db563230e73955cac3ae1b56`
- Last verified: `2026-05-11`
- Activity / maintenance status: active at selection; the repository was pushed on `2026-05-10`, carries live CI plus recent product/ADR documentation, and currently looks like an actively iterated Android puzzle prototype.

## Short Description

Native Android arithmetic puzzle game built in Kotlin and Jetpack Compose, with a domain-driven rules model, stable strip-entry identity, explicit UI behavior documentation, and meaningful unit plus instrumented UI tests.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `2d`, `android`, `input`, `ui-hud`, `testing`
- Engine / framework: Android SDK + Jetpack Compose + AndroidX Lifecycle/ViewModel
- Rendering approach: Compose UI primitives, Material3, modal and popup editors, and accessibility semantics around a single-activity Android shell
- Main language(s): Kotlin
- Android target: direct Android app
- Build system: single-module Gradle Kotlin DSL Android project with version catalog and Gradle daemon JVM toolchain config

## Why It Matters

- `NumPairs` is a strong lab reference for Android puzzle-game teams that need rigorous rules, validation, and UX behavior without introducing a heavier engine architecture.
- Its biggest value is the combination of durable product docs, ADR-backed modeling decisions, clean presentation-state separation, and a real verification surface.

## Reusable Ideas

- Gameplay ideas:
  - arithmetic pairing puzzle where each strip entry participates once in addition and once in multiplication, with cross-tile pairing validation
- Architecture patterns:
  - immutable puzzle domain plus separate transient presentation state and derived UI state
- Graphics / rendering techniques:
  - Compose-first board, strip, bottom-sheet, and anchored-popup editing flows without a custom rendering surface
- Input / UI approaches:
  - mobile-first tap interactions, editable-run strip entry dialogs, accessibility semantics, and invalid-but-still-editable tile feedback
- Performance or optimization ideas:
  - keep state transitions explicit and derived UI updates narrow instead of mutating a broad shared UI model

## Notable Implementations

- `adr-003-use-stable-strip-entry-identity.md` explains and justifies why operand identity must survive strip reordering.
- `Strip.withUpdatedEntry()` preserves ascending order within editable runs while keeping strip-entry identity stable.
- `PuzzleValidation.kt` distinguishes incorrect arithmetic, missing identities, mismatched sum/product pairings, and invalid strip-entry usage.
- `GameViewModel`, `GamePresentationState`, and `GameUiStateFactory` form a clean domain-to-presentation pipeline.
- The repository includes strong domain, presentation, accessibility, and interaction tests for its size.

## Android Relevance

- Native Android use:
  - yes; this is a direct Android app with a `ComponentActivity`, Compose UI, Material3, AndroidX lifecycle/view-model usage, and a CI workflow that installs Android SDK `36.1`
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - especially useful for Android puzzle, logic, or educational games that need careful identity/validation rules and Compose-first UI flows rather than a custom engine stack

## Risks / Limitations

- The repository currently has very low public signal despite promising code and docs.
- It is still a narrow prototype with static seed puzzle content and no broader persistence or progression surface yet.
- Local Android task validation in the lab still stops at missing Android SDK configuration.
- The reusable value is strongest in modeling, UX, and testing patterns rather than in rendering or engine depth.

## Notes

This is one of the better small Android references in the lab for writing down puzzle rules and UX behavior explicitly, then carrying those decisions through domain models, Compose interactions, and automated tests.
