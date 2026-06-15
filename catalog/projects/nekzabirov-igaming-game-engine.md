# IGaming Game Engine

## Basic Info

- Project name: `IGaming-Game-Engine`
- Source repository: `https://github.com/nekzabirov/IGaming-Game-Engine`
- Author / organization: `nekzabirov`
- License: `Apache-2.0`
- Research note: [research/findings/nekzabirov-igaming-game-engine.md](../../research/findings/nekzabirov-igaming-game-engine.md)
- Investigated commit: `bed2edbe89bc1a237e5b72734be0286fcfd902fb`
- Last verified: `2026-06-15`
- Activity / maintenance status: active at selection time; latest visible push was `2026-06-15`

## Short Description

Production-oriented Kotlin iGaming backend that manages game sessions, provider launch flows, betting callbacks, freespins, wallet moves, and event publication through a layered Ktor plus gRPC architecture.

## Technical Profile

- Primary category: `gameplay-systems`
- Focus tags: `networking`, `save-load`, `testing`
- Engine / framework: custom game-backend architecture over Ktor, gRPC, Exposed, RabbitMQ, Redis, and Koin
- Rendering approach: none; server-side game orchestration only
- Main language(s): `Kotlin`
- Android target: no direct Android target
- Build system: Gradle Kotlin DSL

## Why It Matters

- The lab mostly studies client/runtime repositories, but this one is worth keeping because it captures reusable Kotlin patterns for authoritative game-session handling, wallet-backed spin processing, provider adapters, and event-after-commit workflows.
- It is especially relevant for Android game teams that also own live-service, multiplayer, casino, or backend-assisted product layers and need a clean way to keep transport code away from game-domain rules.

## Reusable Ideas

- Gameplay ideas: explicit session, round, spin, and freespin lifecycle ownership with rollback-aware betting rules.
- Architecture patterns: hexagonal layering, CQRS bus contracts, adapter registry for external providers, and transport-agnostic domain services.
- Graphics / rendering techniques: none.
- Input / UI approaches: none in the client sense; the useful analog is the split between gRPC and webhook adapters over one shared core.
- Performance or optimization ideas: async wallet side effects and committed-event publication to keep external failures from invalidating persisted game actions.

## Notable Implementations

- `OpenSessionUsecase` persists the session before asking an external aggregator for a launch URL, explicitly solving immediate callback race conditions.
- `ProcessSpinUsecase` separates affordability checks, limit checks, balance split calculation, persistence, wallet transport, and broker publication.
- `SpinBalanceCalculator` keeps real-vs-bonus rules pure and thoroughly testable.
- `AggregatorRegistry` uses provider discovery instead of central switch logic to add new integrations.
- `PlaceSpinEventConsumer` updates player limits from committed domain events rather than from synchronous request logic.

## Android Relevance

- Native Android use: none.
- Kotlin relevance: high; this is a clean Kotlin example of domain-driven game-service architecture, coroutine-friendly adapters, and explicit DI composition.
- Porting or adaptation notes: best used as a reference for backend-connected Android games, multiplayer/session services, wallet/economy services, or any product where the Android client talks to an authoritative Kotlin game server.

## Risks / Limitations

- No direct Android runtime, rendering, or client input patterns.
- Local build validation in this lab is blocked by Java `8`, while the repository expects Java `17+` / toolchain `21`.
- Some dependencies come from private GitHub Packages, which limits easy outside reproduction.
- Public ecosystem signal is still low despite the repository's architectural depth.

## Notes

This is one of the clearer examples in the lab of treating game-related money and session flow as a domain model first and a transport problem second. It is a good companion reference when future Android game work needs reliable backend session or economy architecture rather than only client-side loop patterns.
