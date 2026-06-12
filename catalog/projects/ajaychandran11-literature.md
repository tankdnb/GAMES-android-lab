# Literature

## Basic Info

- Project name: `Literature`
- Source repository: `https://github.com/AjayChandran11/Literature`
- Author / organization: `AjayChandran11`
- License: `MIT`
- Research note: [research/findings/ajaychandran11-literature.md](../../research/findings/ajaychandran11-literature.md)
- Investigated commit: `a64c400bd805ad3ed834bbb3a0f66a1b5337258e`
- Last verified: `2026-06-12`
- Activity / maintenance status: very fresh at selection; last push visible on `2026-06-12`

## Short Description

Kotlin Multiplatform card-game product with a shared rules engine, Compose Multiplatform Android/iOS client, offline bot play, and a Ktor-based authoritative multiplayer server.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `android`, `multiplatform`, `networking`, `ui-hud`, `ai`, `save-load`, `testing`
- Engine / framework: Kotlin Multiplatform + Compose Multiplatform + Ktor + Koin
- Rendering approach: Compose UI
- Main language(s): `Kotlin`
- Android target: direct Android app target in `composeApp`
- Build system: `Gradle Kotlin DSL`

## Why It Matters

This is a strong reference for Android game teams that want one shared gameplay core across local play, bot play, and online multiplayer. Its most reusable value is not raw rendering but product architecture:

- shared pure rules
- inference-driven bots
- authoritative room management
- reconnect-aware client session ownership

## Reusable Ideas

- Gameplay ideas: turn-based ask/claim card-game flow with team ownership of half-suits and event-driven state transitions
- Architecture patterns: pure shared rules engine, filtered player-view protocol, authoritative room runtime, long-lived websocket repository
- Graphics / rendering techniques: adaptive Compose game shell with turn banners, overlays, and in-game panels rather than a custom engine
- Input / UI approaches: Compose-first gameplay shell with state rebuilt from shared domain events
- Performance or optimization ideas: shared-state projection, bounded recent-event payloads, and replay-based reconnect recovery instead of full-state spam

## Notable Implementations

- `GameEngine` keeps ask/claim resolution and event emission in a reusable pure core
- `CardTracker` and `BotStrategy` derive AI knowledge from public event history instead of hidden-state cheating
- `GameRoom` handles team setup, reconnect windows, bot substitution, timeouts, and room lifecycle on the server
- `OnlineGameRepository` owns websocket sessions, reconnect tokens, backoff, and event replay
- `PlayerGameView` intentionally hides `dealSeed` and other authoritative-only state from clients

## Android Relevance

- Native Android use: yes, through the `composeApp` Android target
- Kotlin relevance: very high; the project is Kotlin-first end to end
- Porting or adaptation notes: strongest reuse is around shared rules, multiplayer session handling, and Compose product-shell structure rather than low-level rendering

## Risks / Limitations

- very low public signal so far
- strongest value is product/runtime architecture, not graphics-engine depth
- local Gradle help could not be validated in the lab because the machine currently exposes only a Java runtime without a JDK compiler

## Notes

This project is a good fit for the lab because it shows how an Android-relevant Kotlin game can stay referenceable at several layers at once: domain rules, AI reasoning, protocol design, server authority, and client reconnect behavior.
