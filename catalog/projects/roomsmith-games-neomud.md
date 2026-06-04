# Project Entry

## Basic Info

- Project name: `NeoMud`
- Source repository: [https://github.com/roomsmith-games/NeoMud](https://github.com/roomsmith-games/NeoMud)
- Author / organization: `roomsmith-games`
- License: `MIT`
- Research note: [research/findings/roomsmith-games-neomud.md](../../research/findings/roomsmith-games-neomud.md)
- Investigated commit: `7fa5934410ba6c5d063cd65bb4fd3c4179f40fdb`
- Last verified: `2026-06-04`
- Activity / maintenance status: active at selection; GitHub showed a fresh push on `2026-06-03`, and the inspected default-branch commit was also recent from `2026-06-02` local repository time.

## Short Description

Kotlin multiplatform MUD product stack with a Ktor WebSocket server, shared typed protocol, Compose Android client, and a separate maker/editor pipeline for authored world content.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `android`, `multiplatform`, `networking`, `ui-hud`, `asset-pipeline`, `testing`
- Engine / framework: Kotlin Multiplatform + Ktor WebSockets + Jetpack Compose Multiplatform + React/Express/Prisma maker tooling
- Rendering approach: Compose-first HUD and map shell with text-heavy presentation, minimap overlays, and asset-backed room backgrounds rather than a sprite or shader engine
- Main language(s): Kotlin primary, plus TypeScript in the maker/editor pipeline
- Android target: direct; Android client target is part of the checked-in multiplatform `client` module
- Build system: multi-module Gradle Kotlin DSL workspace plus a separate Node-based maker toolchain

## Why It Matters

- `NeoMud` is a strong catalog entry because it combines real Android client relevance with a broader reusable multiplayer architecture instead of stopping at a small UI demo.
- Its strongest value is the shared-contract and server-authoritative design: one protocol module, one authoritative tick loop, reconnect-aware client state, and a validated content-packaging path.

## Reusable Ideas

- Gameplay ideas:
  - authoritative tick-driven multiplayer MUD flow with pursuit, room timers, combat ordering, and typed world interactions
- Architecture patterns:
  - shared protocol module, server-owned simulation, client-owned presentation, and separate HTTP browser API beside the gameplay socket
- Graphics / rendering techniques:
  - Compose-native map and overlay rendering, plus asset-backed room backgrounds managed through normal UI layers
- Input / UI approaches:
  - product-style auth/game/browser split with one large shared game shell rather than fragmented screens
- Performance or optimization ideas:
  - reconnect gating, session-rate limiting, and broad regression coverage around server logic instead of trusting runtime behavior informally

## Notable Implementations

- `GameLoop.kt` keeps world simulation authoritative and tick-driven.
- `CommandProcessor.kt` separates handshake/auth handling from lock-guarded world mutation.
- `SessionManager.kt` and `PlayerSession.kt` centralize duplicate-login handling, discovery state, cooldowns, and message throttling.
- `ClientMessage.kt` and `ServerMessage.kt` define one shared typed protocol for client and server.
- `WebSocketClient.kt` and `ReconnectCoordinator.kt` show a bounded reconnect strategy after successful sessions.
- `validate-world.mjs` plus `packageWorld` make world validation and bundling explicit build steps.

## Android Relevance

- Native Android use:
  - yes; the checked-in client has a real Android host layer
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - especially useful for Android game products that need a larger shared-code stack around networking, reconnects, content validation, or platform-specific UI hosting rather than only low-level rendering samples

## Risks / Limitations

- The README explicitly frames the repo as an AI-built playground, so code quality should be judged from structure and tests, not branding.
- The repository is large and product-heavy rather than a compact gameplay sample.
- Much of the most reusable value lives in shared/server architecture, not Android-only APIs.
- Meaningful local build validation still needs Java `17+`, and the server path clearly expects JDK `21`.

## Notes

Treat `NeoMud` as a multiplayer product-stack reference. The most reusable value is the combination of a shared protocol layer, a server-authoritative runtime, a reconnect-aware Compose Android client, and a validated world-authoring pipeline.
