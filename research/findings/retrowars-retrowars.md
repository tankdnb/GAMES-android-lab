# Research Note

## Repository Snapshot

- Repository: `retrowars/retrowars`
- Source URL: [https://github.com/retrowars/retrowars](https://github.com/retrowars/retrowars)
- Owner: `retrowars`
- Batch ID: [`BATCH-2026-05-10-B`](../batches/BATCH-2026-05-10-B.md)
- Type: `android-game`
- License: `GPL-3.0`
- Selection date: `2026-05-10`
- Last pushed at selection: `2025-10-24`
- Stars at selection: `238`
- Investigated commit: `766e1376b745604d0350344cc194e87642263737`
- Research status: `accepted`
- Build mode: `static-review + gradle-discovery-attempt-timeout`
- Catalog card: [catalog/projects/retrowars-retrowars.md](../../catalog/projects/retrowars-retrowars.md)

## Why This Repository Was Selected

- It is an Android-first Kotlin game instead of another engine/framework, which gives the batch practical product architecture balance.
- The multiplayer "different retro games attacking each other" idea suggested useful networking and shared-game-shell patterns.
- The repository mixes Android integration, libGDX rendering, UI state, and server/client code in one manageable workspace.

## Technical Profile

- Main language(s): Kotlin, Java
- Engine / framework: Android app plus shared libGDX core with Ktor-based networking/server support
- Rendering stack: libGDX screens, cameras, HUD, and Scene2D UI around multiple minigame implementations
- Android target: direct Android application with Android-specific share and local-network support
- Build system: Gradle Groovy multi-module project
- Repository layout summary: shared `core` gameplay module plus `android`, `desktop`, `server`, and supporting tooling modules such as `texture-packer`
- Key modules reviewed:
  - `core`
  - `android`
  - `server`
  - `desktop`
  - `texture-packer`

## Build And Runtime Notes

- The repository was primarily investigated statically.
- A Gradle discovery command was attempted via `.\gradlew.bat help -PexcludeAndroid`, but it timed out before producing a reliable lightweight validation result.
- Known setup limitations:
  - older libGDX/Gradle layout plus multiple modules increases startup cost
  - Android, desktop, and server code are all present in one workspace

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `3`
- Implementation depth: `3`
- Code clarity: `2`
- Novelty: `3`
- Overall verdict: `accepted`
- Why:
  - the repository shows a reusable shared shell for several minigames, not just one game's logic
  - it contains practical Android multiplayer patterns that are rare in small Kotlin game repos
  - the separation between game registry, shared game screen, Android platform hooks, and network protocol is strong enough to transfer elsewhere

## Interesting Findings

### Engine Architecture And Core Loop

- `core/src/com/serwylo/retrowars/RetrowarsGame.kt` centralizes screen transitions and menu music while keeping each actual game implementation behind screen factories.
- `core/src/com/serwylo/retrowars/games/GameScreen.kt` is a strong shared gameplay shell: it owns the camera, viewport, HUD, controller attachment, music, score handling, and multiplayer event wiring so that each minigame does not have to rebuild those concerns.
- `core/src/com/serwylo/retrowars/games/Games.kt` keeps the minigame registry data-driven through `GameDetails`, including controller layout, soundtrack, icon, descriptions, and screen factory.

### Rendering And Graphics

- `core/src/com/serwylo/retrowars/ui/GameViewport.kt` reserves bottom HUD space inside the viewport instead of assuming the game world owns the full screen. That is directly useful for Android games with persistent overlay controls or HUD.

### Gameplay Systems

- `core/src/com/serwylo/retrowars/games/asteroids/AsteroidsGameState.kt` cleanly separates mutable gameplay state from rendering code, with respawn timers and entity collections kept in a compact state holder.
- `core/src/com/serwylo/retrowars/games/Games.kt` makes it easy to add or hide games without rewriting menus and launch flow, which is a good pattern for collections of minigames or modes.

### Input And Controls

- `core/src/com/serwylo/retrowars/input/SoftController.kt` defines on-screen control layouts as serialized grid-like strings, validates that layouts match declared buttons, and supports "no buttons" modes when a game uses gesture-only input.

### UI, HUD, And Menus

- `core/src/com/serwylo/retrowars/core/MultiplayerLobbyScreen.kt` treats the multiplayer lobby as a state-driven Scene2D screen and explicitly queues state transitions that can arrive from networking work on other threads.

### Physics And Collision

- Physics is handled per minigame rather than through one shared engine subsystem, so the reusable value here is mostly in shell architecture, not in a generic physics layer.

### Tooling, Android Integration, Or Other Notable Areas

- `core/src/com/serwylo/retrowars/net/RetrowarsClient.kt` always marshals incoming network messages onto the libGDX main thread via `Gdx.app.postRunnable`, which avoids UI and score-state races.
- `core/src/com/serwylo/retrowars/net/RetrowarsServer.kt` supports several room topologies (`SingleLocalRoom`, private invite rooms, public random rooms) instead of hardcoding one multiplayer shape.
- `core/src/com/serwylo/retrowars/net/Network.kt` uses compact versioned message DTOs with serialized short field names, which is a good pattern for evolving a lightweight custom protocol.
- `core/src/com/serwylo/retrowars/net/ServerDirectory.kt` adds public-server discovery and capability metadata, not just direct host/port connection.
- `android/src/com/serwylo/retrowars/AndroidPlatform.kt` wraps Android-specific share-intent behavior, multicast lock handling, and device IP resolution behind a platform interface.

## Reusable Takeaways

- A shared `GameScreen` base can absorb most product-level concerns across multiple games or modes without forcing every game into the same gameplay model.
- If networking callbacks can arrive off the render thread, convert them explicitly onto the main thread before touching HUD or scene state.
- Data-driven game/mode registries make multi-game products much easier to grow.
- On-screen controller layouts are worth describing declaratively instead of hardcoding every button arrangement in UI code.
- Android LAN play may require platform-specific multicast control and should be isolated behind a platform service.

## Evidence Summary

- `core/src/com/serwylo/retrowars/RetrowarsGame.kt` - top-level screen flow and menu music
- `core/src/com/serwylo/retrowars/games/GameScreen.kt` - shared gameplay shell, HUD, controller, network hooks
- `core/src/com/serwylo/retrowars/games/Games.kt` - data-driven minigame registry
- `core/src/com/serwylo/retrowars/games/asteroids/AsteroidsGameState.kt` - compact gameplay-state holder example
- `core/src/com/serwylo/retrowars/ui/GameViewport.kt` - HUD-aware viewport policy
- `core/src/com/serwylo/retrowars/input/SoftController.kt` - declarative soft-controller layouts
- `core/src/com/serwylo/retrowars/core/MultiplayerLobbyScreen.kt` - lobby state machine and cross-thread UI staging
- `core/src/com/serwylo/retrowars/net/RetrowarsClient.kt` - network-to-main-thread handoff and score breakpoints
- `core/src/com/serwylo/retrowars/net/RetrowarsServer.kt` - room models and server lifecycle
- `core/src/com/serwylo/retrowars/net/Network.kt` - versioned protocol DTOs
- `core/src/com/serwylo/retrowars/net/ServerDirectory.kt` - public server discovery and metadata
- `android/src/com/serwylo/retrowars/AndroidPlatform.kt` - Android multicast/share platform hooks

## Risks Or Limits

- `GPL-3.0` limits direct reuse in proprietary products.
- Some of the most interesting patterns are specifically tied to multiplayer minigame products rather than single-game apps.
- Build validation was inconclusive because the Gradle discovery attempt timed out.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `android-game`
- Focus tags: `2d`, `android`, `libgdx`, `networking`, `input`, `ui-hud`
- Follow-up needed:
  - inspect one or two additional minigame implementations later for more concrete gameplay-system takeaways beyond the shared shell
