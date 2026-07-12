# Seven Wonders Online

## Basic Info

- Project name: Seven Wonders Online
- Source repository: https://github.com/joffrey-bion/seven-wonders
- Author / organization: `joffrey-bion`
- License: `MIT`
- Research note: [research/findings/joffrey-bion-seven-wonders.md](../../research/findings/joffrey-bion-seven-wonders.md)
- Investigated commit: `314e92172de0f5bf906e1fb515d56f07e20c21ed`
- Last verified: `2026-07-12`
- Activity / maintenance status: active at selection; GitHub metadata showed `77` stars and last push on `2026-07-09`.

## Short Description

Kotlin-heavy online implementation of the 7 Wonders board game. The repository combines a custom JVM rule engine, KMP shared model/client, Spring Boot STOMP/WebSocket server, Kotlin/JS React UI, and automated bots.

## Technical Profile

- Primary category: `gameplay-systems`
- Focus tags: `multiplatform`, `networking`, `ai`, `ui-hud`, `testing`
- Engine / framework: custom board-game rules engine plus Spring Boot server
- Rendering approach: Kotlin/JS React with BlueprintJS wrappers and Emotion styling
- Main language(s): Kotlin
- Android target: no direct Android module; reusable mainly as shared Kotlin rules, protocol, and multiplayer architecture
- Build system: Gradle Kotlin DSL multi-module build

## Why It Matters

- It demonstrates how to keep a complex board-game state machine independent from UI and transport layers.
- It produces UI-ready playability and transaction data from the rules engine, which avoids duplicating affordability logic in screens.
- It uses a shared serializable model/client across browser UI, server, and bots, a pattern that transfers well to Android multiplayer board games.

## Reusable Ideas

- Gameplay ideas: authoritative turn flow with prepared moves, special follow-up turns, hand rotation, scoring, military conflict, science scoring, and resource trading.
- Architecture patterns: KMP shared protocol model, JVM rules engine, Spring STOMP server, bot automation through the same public client path, and reducer-style UI state updates from typed events.
- Graphics / rendering techniques: not a graphics-focused repo; the useful UI idea is visual feedback driven by server/rules playability.
- Input / UI approaches: card action buttons are enabled from `CardPlayability`, multi-option payments open a transaction selector, and prepared moves are visible before final resolution.
- Performance or optimization ideas: resource transaction enumeration prunes dominated price options, and full-game simulations verify rule progressions across player counts.

## Notable Implementations

- `sw-engine/src/main/kotlin/org/luxons/sevenwonders/engine/Game.kt` owns the turn state machine and atomic turn execution.
- `sw-engine/src/main/kotlin/org/luxons/sevenwonders/engine/resources/TransactionOptionsCalculator.kt` computes neighbour-trading options and sorts/prunes payment choices.
- `sw-engine/src/main/kotlin/org/luxons/sevenwonders/engine/cards/Requirements.kt` separates affordability preview from payment execution.
- `sw-client/src/commonMain/kotlin/org/luxons/sevenwonders/client/SevenWondersClient.kt` wraps STOMP/WebSocket as typed Kotlin session calls and flows.
- `sw-server/src/main/kotlin/org/luxons/sevenwonders/server/controllers/GameController.kt` synchronizes move preparation/unpreparation and turn resolution.
- `sw-bot/src/main/kotlin/org/luxons/sevenwonders/bot/SevenWondersBot.kt` runs bots through the same protocol used by human clients.
- `sw-engine/src/test/kotlin/org/luxons/sevenwonders/engine/GameTest.kt` and transaction/lobby tests provide meaningful rule and flow coverage.

## Android Relevance

- Native Android use: none found in the inspected repository.
- Kotlin relevance: high; most important rules, model, client, server, UI, and bot code is Kotlin.
- Porting or adaptation notes: an Android version could reuse the shared model and rule-engine ideas, replace Kotlin/JS React with Compose, and keep the STOMP/WebSocket protocol shape or adapt it to Ktor/WebSocket.

## Risks / Limitations

- Android relevance is indirect because the checked-in product is web/server-focused.
- Local Gradle discovery beyond `--version` is blocked in this lab by Java `8`; upstream CI expects JDK `21`.
- Original 7 Wonders game rules/assets may raise IP concerns for content reuse; treat this as an implementation-pattern reference, not as reusable game content.

## Notes

If revisited, keep the follow-up narrow around resource-payment search, synchronized turn execution, bot automation, or adapting the shared protocol/state model to an Android Compose client.
