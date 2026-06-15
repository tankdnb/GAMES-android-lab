# Findings: `MohamedRejeb/Card-Game-Animation`

## Snapshot

- Repository: `https://github.com/MohamedRejeb/Card-Game-Animation`
- Investigated commit: `99053acdc70e6bc2d5cc3da21311f2097101540d`
- License: `Apache-2.0`
- Repository type: `android-game`
- Primary language: `Kotlin`
- Build mode: `static-review + gradle-version + gradle-help-failed-no-jdk`
- Research date: `2026-06-15`

## What It Is

`Card-Game-Animation` is a compact Android Jetpack Compose sample focused on animated card interactions. The inspected tree is a single-app repository with one main screen that fans cards in a hand, lets the user tap to select, drag to move, and fling cards toward a target drop area with layered Compose animations.

This is much closer to an interaction and animation prototype than to a full card-game product or a reusable game engine.

## Why It Matters

This repository is still worth recording as a narrow Android Compose reference:

- it demonstrates a readable drag-and-drop card interaction entirely with Compose primitives
- it combines several animation layers on one object without introducing a custom rendering surface
- it shows one practical pattern for measuring composable positions and converting drag motion into target-seeking animation

The repo is too small, too UI-coupled, and too lightly verified to count as a stronger main-catalog gameplay baseline.

## Verified Technical Profile

- Primary category: `android-game`
- Focus tags: `2d`, `android`, `input`, `ui-hud`, `animation`
- Engine / framework: Android SDK + Jetpack Compose + Material 3
- Rendering approach: Compose image/layout tree with stacked `graphicsLayer` transforms and gesture-driven motion
- Android target: direct Android app only
- Other targets seen in repo: none
- Build system: Gradle Kotlin DSL

## High-Value Reusable Ideas

### 1. Layered Compose transforms make the card interactions easy to reason about

`GameScreen.kt` uses several independent animation layers per card:

- `animateFloatAsState` for active-card lift
- `animateFloatAsState` for hand-spread rotation
- `animateFloatAsState` for dropped-card rotation
- `Animatable` values for live drag translation on both axes

Because those concerns are split instead of merged into one giant transform state object, the interaction remains unusually readable for a pure Compose prototype.

### 2. The drag-to-target drop flow is a useful small interaction pattern

`CardItem()` combines:

- `onGloballyPositioned` to capture the card's original center offset
- `detectDragGestures` to accumulate `cardDragX` and `cardDragY`
- a distance threshold to decide whether a drag counts as a real drop
- a computed `remainingOffset` that animates the card toward a destination stack

This is a practical reference for Android game or toy-app UIs that need drag-release targeting without a heavier physics layer.

### 3. Hand-spread control is decoupled from card dragging

`PlayerHand()` uses `draggable` on a separate hand marker image to control `cardsSpreadDegree`, while each card handles its own pointer input. That separation keeps "layout of the fan" and "motion of one chosen card" as two different interaction channels instead of overloading one gesture path.

For touch-heavy card or inventory UIs, this is a reusable idea even though the exact visuals are sample-sized.

## Other Useful Implementations

- `Data.kt` keeps card assets in a plain typed list, which is trivial but clear for small authored decks.
- `calculateDistanceBetweenTwoPoints()` in `Utils.kt` is used as a tiny threshold helper instead of mixing geometry into gesture callbacks.
- `key(card.id)` in `GameScreen()` helps Compose preserve per-card state while the dropped and non-dropped cards are visually reorganized.

## Testing Surface

The visible automated test surface is template-only.

Verified:

- one default unit test under `app/src/test`
- one default instrumentation test under `app/src/androidTest`
- no visible gesture, animation, or game-state tests

This meaningfully lowers reuse confidence.

## Android Relevance

### Direct relevance

High for Android UI/game interaction prototyping.

This is a direct Android Compose sample with pointer input, animated drag motion, target-drop behavior, and state-driven visual feedback.

### Indirect relevance

Low to moderate beyond interaction design.

The repository is more useful for card interaction patterns than for broader gameplay-core, persistence, AI, or system architecture reuse.

## Build And Environment Notes

Verified locally:

- `cmd /c gradlew.bat --version` succeeded after redirecting `GRADLE_USER_HOME` into `research/cache/gradle-card-game-animation`
- `cmd /c gradlew.bat help --no-daemon` failed with `No Java compiler found, please ensure you are running Gradle with a JDK`

Interpretation:

- the checked-in wrapper is complete and structurally healthy
- the current lab failure is caused by the machine exposing only a Java `8` runtime without JDK compiler tools

Additional build notes:

- root and app build files are modernized into Kotlin DSL
- the app still targets `compileSdk = 33` / `targetSdk = 33`
- no meaningful CI or real verification workflow was visible in the checked-in tree

## Risks And Limits

- there is no real gameplay layer beyond card movement and dropping
- state ownership is local UI state rather than a reusable game-domain model
- `droppedCards` is a remembered mutable list, not a more explicit immutable state flow
- debug `println()` statements remain in `GameScreen.kt`
- the visible test surface is template-only
- the repository is relatively stale compared with the fresher engine-side backlog alternatives

## Catalog Verdict

`reference-only`

The repository is worth keeping as a compact Android Compose reference for drag-driven card interactions, stacked transform animation, and target-drop motion. It is too narrow, UI-centric, and under-tested to count as a stronger main catalog-quality game reference.
