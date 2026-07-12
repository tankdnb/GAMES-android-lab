# joffrey-bion/seven-wonders

## Repository Snapshot

- Repository: `joffrey-bion/seven-wonders`
- Source URL: https://github.com/joffrey-bion/seven-wonders
- Owner: `joffrey-bion`
- Batch ID: `BATCH-2026-07-12-A`
- Type: `gameplay-systems`
- License: `MIT`
- Selection date: `2026-07-12`
- Last pushed at selection: `2026-07-09`
- Stars at selection: `77`
- Investigated commit: `314e92172de0f5bf906e1fb515d56f07e20c21ed`
- Research status: `accepted`
- Build mode: `static-review + gradle-version + gradle-help-failed-java8-needs-java17`
- Catalog card: [card](../../catalog/projects/joffrey-bion-seven-wonders.md)

## Why This Repository Was Selected

- The previous compact shortlist was exhausted, so a new exact-license shortlist was built before this batch.
- `seven-wonders` was selected over more direct Android candidates because it has a stronger public signal, recent activity, permissive licensing, substantial Kotlin code, and a deeper expected yield around board-game rules, online multiplayer, bots, and testable state transitions.
- Android relevance is indirect: the checked-in product is a Kotlin/JVM + Kotlin/JS web app, but the shared Kotlin model/client, authoritative server flow, rule engine, and UI-state patterns are transferable to Android board or strategy games.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: custom 7 Wonders rules engine, Spring Boot server, Kotlin Multiplatform shared model/client, Kotlin/JS React UI
- Rendering stack: Kotlin/JS React with BlueprintJS wrappers and Emotion styling
- Android target: no direct Android module found
- Build system: Gradle Kotlin DSL multi-module build
- Repository layout summary: `sw-common-model` holds serializable DTOs and shared game state, `sw-engine` holds the rules engine, `sw-server` hosts STOMP/WebSocket gameplay, `sw-client` provides a KMP STOMP client, `sw-ui` implements the browser UI, and `sw-bot` drives automated players through the same client API.
- Key modules reviewed: `sw-common-model`, `sw-engine`, `sw-server`, `sw-client`, `sw-ui`, `sw-bot`, root Gradle files, workflows, and `doc/decisions_history.md`.

## Build And Runtime Notes

- The project was primarily inspected statically.
- `cmd /c gradlew.bat --version` succeeded and downloaded/used Gradle `9.6.1`; the launcher JVM in the lab is Java `1.8.0_321`.
- `cmd /c gradlew.bat help --no-daemon` failed because Gradle requires JVM `17+` while the lab currently exposes Java `8`.
- Upstream CI uses JDK `21`, so the local failure is an environment limitation rather than a verified project defect.

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `2`
- Implementation depth: `3`
- Code clarity: `3`
- Novelty: `2`
- Overall verdict: `accepted`
- Why: this is not an Android app, but it preserves a rich Kotlin implementation of rule-heavy board-game state, multiplayer protocol, bot automation, UI affordability feedback, and testing discipline that can inform Android strategy/card/board game architecture.

## Interesting Findings

### Engine Architecture And Core Loop

- `sw-engine/src/main/kotlin/org/luxons/sevenwonders/engine/Game.kt` owns the authoritative turn state machine: it deals hands by age, prepares moves, waits until all active players have submitted actions, places all selected cards before activating effects, rotates hands, resolves military conflicts, handles special discarded-card/guild-copy turns, and emits score-watch turns at endgame.
- `sw-engine/src/main/kotlin/org/luxons/sevenwonders/engine/Player.kt` keeps player context minimal through `Player`, `SimplePlayer`, and `PlayerContext`, which is useful for passing rule evaluation context without exposing server or UI concerns.
- `sw-engine/src/main/kotlin/org/luxons/sevenwonders/engine/data/GameDefinition.kt` loads cards and wonders from JSON-backed definitions, then creates a `Game` from assigned wonders and settings. This is a practical content-data boundary for board games.

### Rendering And Graphics

- The checked-in UI is browser-oriented, not Android rendering. `sw-ui/src/jsMain/kotlin/org/luxons/sevenwonders/ui/components/game/GameScene.kt` composes the board, hand, score overlay, readiness button, neighbour summaries, and prepared-move overlay from server-derived `GameState`.
- `sw-ui/src/jsMain/kotlin/org/luxons/sevenwonders/ui/components/game/Hand.kt` uses card playability and transaction options produced by the rules layer to enable/disable UI actions and open a transaction selector only when several payment options exist.

### Gameplay Systems

- `sw-engine/src/main/kotlin/org/luxons/sevenwonders/engine/cards/Cards.kt` centralizes card playability decisions: duplicate-card prevention, chain builds, special-free play, and resource/gold requirement evaluation all produce a `CardPlayability` DTO that the UI can present directly.
- `sw-engine/src/main/kotlin/org/luxons/sevenwonders/engine/cards/Requirements.kt` separates requirement assessment from payment execution, so the same rules can feed both preview UI and authoritative move validation.
- `sw-engine/src/main/kotlin/org/luxons/sevenwonders/engine/resources/TransactionOptionsCalculator.kt` recursively enumerates resource-purchase options across self, left neighbour, and right neighbour production, then removes dominated options. This is a strong reusable pattern for board-game affordability previews.
- `sw-engine/src/main/kotlin/org/luxons/sevenwonders/engine/boards/Science.kt` computes science points with joker allocation by trying possible symbol placements and taking the maximum score.
- `sw-engine/src/main/kotlin/org/luxons/sevenwonders/engine/boards/Table.kt` resolves neighbour military conflicts and exposes neighbour guild cards, keeping table-level interaction rules out of individual card UI.
- `sw-common-model/src/commonMain/kotlin/org/luxons/sevenwonders/model/score/Score.kt` keeps score categories and rank handling serializable, including tied-rank behavior through sorted `ScoreBoard` entries.

### Input And Controls

- No Android input layer exists in the inspected repository.
- The transferable control idea is interaction gating: the browser hand UI only offers actions allowed by the current `TurnAction` and each card's playability, then sends a typed `PlayerMove` rather than raw UI gestures.

### UI, HUD, And Menus

- `sw-client/src/commonMain/kotlin/org/luxons/sevenwonders/client/GameState.kt` provides derived helpers such as current prepared card, absolute neighbour indices, own board, neighbour boards, and non-neighbour boards. This keeps React components simpler and would transfer well to Android Compose state models.
- `sw-ui/src/jsMain/kotlin/org/luxons/sevenwonders/ui/redux/Reducers.kt` updates `GameState` from typed events such as game entry, prepared card events, player readiness, and new turn info, which mirrors the reducer style useful in multiplayer Android UIs.
- `sw-ui/src/jsMain/kotlin/org/luxons/sevenwonders/ui/components/game/PreparedMove.kt` shows a clear prepared-action overlay that visually distinguishes discard and wonder-upgrade moves before final turn resolution.

### Physics And Collision

- Not applicable. This is a rule-heavy board-game implementation with no physics or collision subsystem.

### Tooling, Android Integration, Or Other Notable Areas

- `sw-client/src/commonMain/kotlin/org/luxons/sevenwonders/client/SevenWondersClient.kt` wraps STOMP/WebSocket communication behind typed Kotlin functions and flows for errors, game lists, lobby events, readiness, and move preparation.
- `sw-server/src/main/kotlin/org/luxons/sevenwonders/server/controllers/GameController.kt` synchronizes move preparation and unpreparation on the `Game` object to avoid inconsistent prepared-card events and to ensure turns execute atomically when all players are ready.
- `sw-server/src/main/kotlin/org/luxons/sevenwonders/server/controllers/LobbyController.kt` handles lobby ownership, player reordering, wonder reassignment, settings updates, bot injection, and readiness-before-first-turn flow.
- `sw-server/src/main/kotlin/org/luxons/sevenwonders/server/config/WebSocketConfig.kt` configures STOMP endpoints, user destinations, heartbeat scheduling, and Kotlin serialization message conversion.
- `sw-bot/src/main/kotlin/org/luxons/sevenwonders/bot/SevenWondersBot.kt` uses the same `SevenWondersClient` API as a real player, making bot automation a protocol-level smoke path rather than a private engine shortcut.
- `sw-engine/src/test/kotlin/org/luxons/sevenwonders/engine/GameTest.kt` simulates full games for multiple player counts, while `TransactionOptionsCalculatorTest.kt` covers tricky payment combinations and `sw-server/src/test/kotlin/org/luxons/sevenwonders/server/lobby/LobbyTest.kt` verifies lobby invariants.
- `.github/workflows/build.yml` runs Gradle build on JDK `21`; deployment workflows package Docker images and deploy to Kubernetes.
- `doc/decisions_history.md` documents long-term technical evolution from Java/Spring/React toward Kotlin Multiplatform shared model/client and Kotlin/React UI.

## Reusable Takeaways

- For Android board games, keep the authoritative rule engine separate from the UI and make it produce UI-ready playability data rather than letting screens duplicate affordability logic.
- Model player actions as typed moves that can be prepared, unprepared, displayed, and finally resolved atomically.
- Use one shared serializable protocol model between server, client, bots, and UI state.
- Let bots exercise the same network/client path as humans to uncover protocol and turn-flow issues.
- For rule-heavy games, test complete simulated games plus narrow combinatorial subsystems such as resource transactions and score/rank calculation.

## Evidence Summary

- `sw-engine/src/main/kotlin/org/luxons/sevenwonders/engine/Game.kt` - authoritative turn state machine.
- `sw-engine/src/main/kotlin/org/luxons/sevenwonders/engine/cards/Cards.kt` - card playability and effect application.
- `sw-engine/src/main/kotlin/org/luxons/sevenwonders/engine/cards/Requirements.kt` - requirement preview and payment validation.
- `sw-engine/src/main/kotlin/org/luxons/sevenwonders/engine/resources/TransactionOptionsCalculator.kt` - trade/payment option enumeration.
- `sw-common-model/src/commonMain/kotlin/org/luxons/sevenwonders/model/api/events/GameEvents.kt` - typed game event protocol.
- `sw-client/src/commonMain/kotlin/org/luxons/sevenwonders/client/SevenWondersClient.kt` - KMP STOMP client API.
- `sw-server/src/main/kotlin/org/luxons/sevenwonders/server/controllers/GameController.kt` - synchronized turn execution.
- `sw-bot/src/main/kotlin/org/luxons/sevenwonders/bot/SevenWondersBot.kt` - protocol-level bot automation.
- `sw-ui/src/jsMain/kotlin/org/luxons/sevenwonders/ui/components/game/Hand.kt` - playability-driven card action UI.
- `sw-engine/src/test/kotlin/org/luxons/sevenwonders/engine/GameTest.kt` - full-game simulation tests.

## Risks Or Limits

- No Android module exists in the inspected repository, so Android value is architectural rather than drop-in.
- The UI stack is Kotlin/JS React, not Compose or Android Views.
- The local lab cannot run Gradle configuration beyond `--version` until Java `17+` or JDK `21` is available.
- Asset and game-rule reuse may be constrained by the original board game IP even though the source code is MIT; use the implementation ideas, not protected content.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `gameplay-systems`
- Focus tags: `multiplatform`, `networking`, `ai`, `ui-hud`, `testing`
- Follow-up needed: optional only; if revisited, focus on the payment-option algorithm, turn synchronization, or bot protocol path rather than reopening the whole web UI.
