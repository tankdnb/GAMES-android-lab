# Card-Game-Animation

## Basic Info

- Project name: `Card-Game-Animation`
- Source repository: `https://github.com/MohamedRejeb/Card-Game-Animation`
- Author / organization: `MohamedRejeb`
- License: `Apache-2.0`
- Research note: [research/findings/mohamedrejeb-card-game-animation.md](../../research/findings/mohamedrejeb-card-game-animation.md)
- Investigated commit: `99053acdc70e6bc2d5cc3da21311f2097101540d`
- Last verified: `2026-06-15`
- Activity / maintenance status: older code push at selection; last push visible on `2024-01-08`

## Short Description

Compact Android Jetpack Compose card-interaction sample with a fanned hand, tap-to-select cards, drag-to-move behavior, drop-threshold logic, and multi-layer card animations.

## Technical Profile

- Primary category: `reference-only`
- Focus tags: `2d`, `android`, `input`, `ui-hud`, `animation`
- Engine / framework: Android SDK + Jetpack Compose + Material 3
- Rendering approach: Compose image/layout tree with stacked `graphicsLayer` transforms and gesture-driven translation
- Main language(s): `Kotlin`
- Android target: direct Android app only
- Build system: `Gradle` (Kotlin DSL)

## Why It Matters

This project is useful as a small direct-Android Compose interaction reference:

- readable drag-and-drop card motion
- layered per-card animation states
- target-seeking drop animation based on measured layout offsets
- separate gesture channel for changing the card-hand spread

## Reusable Ideas

- Gameplay ideas: card-fan presentation with drag-to-drop stack placement
- Architecture patterns: small local-state Compose interaction prototype without a custom render surface
- Graphics / rendering techniques: stacked `graphicsLayer` transforms with separate active, drag, and dropped rotations/translations
- Input / UI approaches: `detectTapGestures`, `detectDragGestures`, and `draggable` used together without heavy abstraction
- Performance or optimization ideas: preserving per-card interaction state with `key(card.id)` while reordering visual layers

## Notable Implementations

- `CardItem()` separates active-card lift, spread rotation, drop rotation, and drag translations into distinct animation channels
- `onGloballyPositioned` plus `remainingOffset` calculation creates a clear drag-release-to-target pattern
- `PlayerHand()` turns one horizontal drag control into fan-spread adjustment for the whole hand
- `Utils.kt` keeps drag-distance thresholding out of the main gesture callback body

## Android Relevance

- Native Android use: direct Android-only Compose sample
- Kotlin relevance: high for touch interaction and animation prototypes
- Porting or adaptation notes: best reused selectively for card/inventory UI behavior, not as a broader gameplay architecture baseline

## Risks / Limitations

- interaction demo rather than a full game system
- no durable gameplay/domain layer outside UI state
- `droppedCards` uses mutable remembered state
- template-only automated tests
- stale public activity compared with fresher queue alternatives

## Notes

This is best treated as a compact reference for Compose card interaction patterns and animation layering, not as a primary reference for Android game repository structure or long-term gameplay architecture.
