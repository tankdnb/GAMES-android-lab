# Findings: `AjayChandran11/Literature`

## Snapshot

- Repository: `https://github.com/AjayChandran11/Literature`
- Investigated commit: `a64c400bd805ad3ed834bbb3a0f66a1b5337258e`
- License: `MIT`
- Repository type: `android-game`
- Primary language: `Kotlin`
- Build mode: `static-review + gradle-version + gradle-help-failed-no-jdk`
- Research date: `2026-06-12`

## What It Is

`Literature` is a Kotlin Multiplatform card-game product built around one shared rules engine, a Compose Multiplatform client, and a Ktor JVM multiplayer server. The checked-in code targets Android and iOS on the client side while keeping gameplay rules, protocol types, and bot logic in a shared module.

## Why It Matters

This repository is stronger than a typical zero-star Android game sample because it combines several reusable layers in one coherent product:

- a pure shared game-rules engine
- inference-driven bot logic built from public game history
- an authoritative room/server runtime with reconnect handling
- an Android-ready Compose client with a more serious reconnect/session layer than most small-game repos

For the lab, it is valuable less as a rendering reference and more as a product-architecture reference for shared rules, multiplayer session management, and KMP game structure.

## Verified Technical Profile

- Primary category: `android-game`
- Focus tags: `android`, `multiplatform`, `networking`, `ui-hud`, `ai`, `save-load`, `testing`
- Engine / framework: Kotlin Multiplatform + Compose Multiplatform + Ktor + Koin
- Rendering approach: Compose UI on Android/iOS, no separate graphics engine
- Android target: direct Android app target in `composeApp`
- Other targets seen in repo: `iOS`, `JVM server`
- Build system: Gradle Kotlin DSL

## High-Value Reusable Ideas

### 1. Pure shared rules engine with reproducible deals

`shared/.../logic/GameEngine.kt` keeps most turn resolution in a pure state-transition layer that returns updated state plus emitted events.

Reusable patterns:

- `createGame()` and `createMultiplayerGame()` record a `dealSeed` so the same deal can be reconstructed later
- `processAsk()` and `processClaim()` validate first, then emit explicit domain events
- early termination logic awards remaining half-suits when one team can no longer act
- the same rules core can drive local bots and multiplayer server authority

This is a strong reference for Android games that want one authoritative gameplay core outside the UI.

### 2. Bot strategy based on public-event inference, not hidden omniscience

`shared/.../bot/BotStrategy.kt` and `shared/.../logic/CardTracker.kt` show a better-than-usual small-game AI pattern:

- event history is converted into `knownLocations` and `impossibleLocations`
- the bot reasons from transfer history and failed asks
- harder difficulties speculate from partial information instead of cheating with full hidden state
- the tracker can deduce the last unknown card in a half-suit through elimination

That pattern is portable to other turn-based multiplayer games where bots should feel informed but fair.

### 3. Authoritative room runtime with reconnect and bot substitution

`server/.../GameRoom.kt` appears to be the most valuable subsystem in the repo.

Notable patterns:

- room lifecycle from lobby to in-progress to finished
- host and team management in lobby
- mutex-guarded server-side state mutation
- reconnect tokens and reconnect deadlines
- disconnected human players can be replaced by bots
- reconnecting humans can reclaim their seat
- turn timeouts can advance stalled games
- bot turns can auto-run until a human player is active again

This is a strong reusable product-shell reference for async multiplayer Android games with shared rules.

### 4. Client reconnect/session ownership is unusually solid for a small game

`composeApp/.../repository/OnlineGameRepository.kt` is more interesting than a typical sample repository layer.

Reusable patterns:

- one long-lived websocket/session owner
- reconnect token reuse
- network monitor integration
- exponential backoff with jitter
- replay from `lastSeenEventTimestamp`
- separate flows for room state, connection state, game state, player events, and reactions

This is exactly the kind of Android-oriented session code that is often missing from small open-source games.

### 5. Shared protocol keeps hidden game state off the wire

`shared/.../protocol/PlayerGameView.kt` sends each player a filtered view:

- your own hand is preserved
- public players expose counts, team, bot flag, and reconnect state
- recent events are capped
- raw `dealSeed` stays inside authoritative state and is intentionally excluded from the player view

That is a useful pattern for turn-based games that want shared models without leaking hidden information.

## Other Useful Implementations

- `MoveValidator.kt` keeps ask/claim legality checks explicit and readable
- `ClaimEvaluator.kt` cleanly separates claim verification from turn orchestration
- `LocalGameRepository.kt` shows a local bot-driven offline mode reusing the same rules engine
- `GameViewModel.kt` rebuilds UI state and card-tracker state from domain events rather than letting Compose own the rules
- `GameBoardScreen.kt` shows a surprisingly full product shell with adaptive layout, tutorial overlays, sounds, and turn-pressure presentation

## Testing Surface

The repo has a real, not template-only, test surface.

Verified examples:

- `shared/.../GameEngineTest.kt`
- `shared/.../MoveValidatorTest.kt`
- `shared/.../ClaimEvaluatorTest.kt`
- `shared/.../CardTrackerTest.kt`
- `shared/.../BotStrategyTest.kt`
- `server/.../GameRoomTest.kt`

The tests confirm that the repository is not only UI-first; the shared rules and room behaviors are exercised directly.

## Android Relevance

### Direct relevance

High.

Reasons:

- real Android client target
- Compose-based product shell
- Kotlin-first codebase
- shared gameplay core suitable for Android/offline/online reuse

### Indirect relevance

Also high for teams building:

- turn-based online games
- KMP game products with shared rules
- reconnect-aware multiplayer UX
- bot-assisted party/card/board games

## Build And Environment Notes

Verified locally:

- `gradlew.bat --version` succeeded
- `gradlew.bat help --no-daemon` failed with `No Java compiler found`

Interpretation:

- the repository exposes a valid Gradle wrapper and modern module layout
- local validation is blocked by the current lab environment exposing a Java 8 JRE without a full JDK compiler
- this failure should be treated as a lab-environment limitation, not as confirmed repository breakage

## Risks And Limits

- public ecosystem signal is currently minimal: `0` stars at selection
- the checked-in value is strongest in rules/server/session architecture, not in graphics or engine innovation
- local build confirmation is incomplete because the current lab machine does not provide a JDK

## Catalog Verdict

`accepted`

The repository earns acceptance because it preserves a reusable Android-relevant architecture stack: shared rules, fair bot inference, authoritative multiplayer rooms, reconnect-aware client state, and a real Compose/KMP product shell.
