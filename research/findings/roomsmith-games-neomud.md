# Research Note

## Repository Snapshot

- Repository: `roomsmith-games/NeoMud`
- Source URL: [https://github.com/roomsmith-games/NeoMud](https://github.com/roomsmith-games/NeoMud)
- Owner: `roomsmith-games`
- Batch ID: [`BATCH-2026-06-04-X`](../batches/BATCH-2026-06-04-X.md)
- Type: `android-game`
- License: `MIT`
- Selection date: `2026-06-04`
- Last pushed at selection: `2026-06-03`
- Stars at selection: `9`
- Investigated commit: `7fa5934410ba6c5d063cd65bb4fd3c4179f40fdb`
- Research status: `accepted`
- Build mode: `static-review + gradle-help-failed-java8-needs-java17`
- Catalog card: [catalog/projects/roomsmith-games-neomud.md](../../catalog/projects/roomsmith-games-neomud.md)

## Why This Repository Was Selected

- `roomsmith-games/NeoMud` was the strongest remaining direct-Android candidate in the current exact-license shortlist after `xxxcucus/planes`.
- Compared with the remaining reserve candidates, it offered fresher code activity, a clearer Kotlin-first multiplatform architecture, and a stronger balance between Android relevance and broader reusable networking/runtime ideas.
- The main question for this batch was whether the repository was mostly an AI-built product experiment or whether it still preserved enough reusable architecture to justify a main-catalog slot. The answer is yes: the shared protocol layer, server-authoritative tick loop, reconnect-aware client shell, and validated world-content pipeline make it stronger than a typical low-star hobby repo.

## Technical Profile

- Main language(s): Kotlin primary, with a significant TypeScript maker/editor application
- Engine / framework: Kotlin Multiplatform + Ktor WebSocket server + Jetpack Compose Multiplatform client + React/Express/Prisma maker app
- Rendering stack: Compose-first Android/Desktop/iOS/WASM UI shell with text/HUD-heavy presentation, minimap overlays, and asset-backed room backgrounds rather than a sprite-engine runtime
- Android target: direct; the repository ships a real Android client target in the multiplatform `client` module
- Build system:
  - root multi-module Gradle Kotlin DSL workspace
  - `shared` KMP module with Android, JVM, iOS, and WASM targets
  - `server` JVM Ktor application with toolchain `21`
  - `client` KMP Compose application with Android, desktop JVM, iOS, and WASM targets
  - `maker` React 18 + Express + Prisma + SQLite toolchain for world-authoring workflows
- Repository layout summary: `shared`, `server`, `client`, and `maker` form one product stack, with `docs/`, `scripts/`, and iOS shell files also checked in
- Source footprint:
  - total files counted in repository: `1764`
  - Kotlin files counted in repository: `357`
  - TypeScript / TSX files counted in repository: `116`
- Test surface:
  - `shared` test files found: `16`
  - `server` test files found: `90`
  - `client` test files found: `28`
  - `maker` test files found: `34`
- Key modules reviewed:
  - `README.md`
  - `TODO.md`
  - `build.gradle.kts`
  - `settings.gradle.kts`
  - `shared/build.gradle.kts`
  - `server/build.gradle.kts`
  - `client/build.gradle.kts`
  - `server/src/main/kotlin/com/neomud/server/Application.kt`
  - `server/src/main/kotlin/com/neomud/server/game/GameLoop.kt`
  - `server/src/main/kotlin/com/neomud/server/game/CommandProcessor.kt`
  - `server/src/main/kotlin/com/neomud/server/game/combat/CombatManager.kt`
  - `server/src/main/kotlin/com/neomud/server/game/npc/NpcManager.kt`
  - `server/src/main/kotlin/com/neomud/server/session/SessionManager.kt`
  - `server/src/main/kotlin/com/neomud/server/session/PlayerSession.kt`
  - `server/src/main/kotlin/com/neomud/server/world/WorldGraph.kt`
  - `shared/src/commonMain/kotlin/com/neomud/shared/protocol/ClientMessage.kt`
  - `shared/src/commonMain/kotlin/com/neomud/shared/protocol/ServerMessage.kt`
  - `shared/src/commonMain/kotlin/com/neomud/shared/protocol/MessageSerializer.kt`
  - `shared/src/commonMain/kotlin/com/neomud/shared/NeoMudVersion.kt`
  - `client/src/commonMain/kotlin/com/neomud/client/network/GameConnection.kt`
  - `client/src/commonMain/kotlin/com/neomud/client/network/WebSocketClient.kt`
  - `client/src/commonMain/kotlin/com/neomud/client/network/ReconnectCoordinator.kt`
  - `client/src/commonMain/kotlin/com/neomud/client/network/PlatformApiClient.kt`
  - `client/src/commonMain/kotlin/com/neomud/client/viewmodel/AuthViewModel.kt`
  - `client/src/commonMain/kotlin/com/neomud/client/viewmodel/GameViewModel.kt`
  - `client/src/commonMain/kotlin/com/neomud/client/viewmodel/WorldBrowserViewModel.kt`
  - `client/src/commonMain/kotlin/com/neomud/client/ui/components/MapOverlay.kt`
  - `client/src/commonMain/kotlin/com/neomud/client/ui/components/MapDrawingUtils.kt`
  - `client/src/commonMain/kotlin/com/neomud/client/ui/components/RoomBackground.kt`
  - `client/src/commonMain/kotlin/com/neomud/client/ui/screens/GameScreen.kt`
  - `client/src/androidMain/kotlin/com/neomud/client/MainActivity.kt`
  - `client/src/androidMain/kotlin/com/neomud/client/ui/navigation/NavGraph.kt`
  - `scripts/validate-world.mjs`
  - `server/src/test/kotlin/com/neomud/server/game/party/PartyCommandTest.kt`
  - `server/src/test/kotlin/com/neomud/server/BugFixesTest.kt`
  - `server/src/test/kotlin/com/neomud/server/AdminCommandTest.kt`

## Build And Runtime Notes

- The repository was investigated through static review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeds and reports Gradle `9.2.1` on a Java `8` launcher.
- `cmd /c gradlew.bat help --no-daemon` fails in the lab because Gradle now requires Java `17+`, while the current machine still exposes Java `8`.
- The checked-in build scripts themselves clearly expect newer toolchains:
  - `shared` targets JVM `17`
  - `server` explicitly requests toolchain `21`
  - `client` also sits on modern Android and Compose Multiplatform tooling
- The repository therefore looks more blocked by the lab environment than by a broken upstream build.
- `README.md` openly frames the project as a `"100% vibe-coded with AI"` playground rather than production software, so reuse should be based on verified structure and tests, not on repo positioning.
- No runtime launch was attempted.

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `3`
- Implementation depth: `3`
- Code clarity: `2`
- Novelty: `3`
- Overall verdict: `accepted`
- Why:
  - `NeoMud` is one of the stronger Android-adjacent product-stack references in the lab because it combines a real Android client, a shared typed protocol layer, a server-authoritative multiplayer runtime, and a world-authoring pipeline in one Kotlin-heavy repository.
  - Its value is not in low-level rendering tricks. The strongest reusable ideas are around cross-platform state ownership, reconnect flow, typed messaging, validated content packaging, and test-backed multiplayer game orchestration.
  - Even with the repo's playful "vibe-coded" framing, the codebase shows enough modularity and test depth to justify keeping it in the main catalog.

## Interesting Findings

### Engine Architecture And Core Loop

- `server/src/main/kotlin/com/neomud/server/Application.kt` is the clearest top-level architecture reference in the repo. It loads a packaged world bundle, assembles repositories and services, wires the command and session layers, starts Ktor, and then launches the authoritative game loop.
- `server/src/main/kotlin/com/neomud/server/game/GameLoop.kt` shows a deliberately server-owned simulation cadence built around `delay(GameConfig.Tick.INTERVAL_MS)`. The loop owns respawns, pursuit, NPC behavior, pending skills, combat, room timers, and shutdown countdown instead of letting those systems drift into request handlers.
- `server/src/main/kotlin/com/neomud/server/game/CommandProcessor.kt` is a useful concurrency seam. Authentication and handshake requests are handled outside the global game-state lock, while state-mutating commands go through `GameStateLock.withLock`. That keeps protocol handling and world mutation separate.
- `server/src/main/kotlin/com/neomud/server/session/SessionManager.kt` and `PlayerSession.kt` show one of the more transferable patterns in the repository: a central session layer that owns duplicate-login displacement, discovery state, party/follow state, protocol version info, tutorial state, pending skills, cooldowns, and message-rate limiting.
- The multiplatform split is also instructive. `shared` owns protocol and version contracts, `server` owns authoritative simulation, and `client` owns product-shell state plus presentation. That is a stronger product architecture shape than a repo where networking DTOs are copied separately on both sides.

### Rendering And Graphics

- `client/src/commonMain/kotlin/com/neomud/client/ui/components/MapOverlay.kt` and `MapDrawingUtils.kt` show a useful Compose-native rendering direction for map-heavy games: draw the minimap and zone semantics inside the normal UI stack instead of dropping immediately into a custom GL layer.
- `RoomBackground.kt` is a practical Android-transfer pattern for asset-backed environments. Room visuals are loaded from world-defined URLs and cached into the Compose UI shell, which keeps content ownership outside the compiled client.
- `GameScreen.kt` is also worth keeping as a rendering-shell example. The repository treats the game surface as layered Compose UI with overlays for inventory, tutorial, map, atlas, vendors, crafting, and party state instead of forcing everything into one bespoke renderer.
- `NeoMud` is not a sprite or shader showcase, but it is a good reminder that many game products can keep their visual layer inside the normal app UI stack if the underlying runtime architecture is strong enough.

### Gameplay Systems

- `CombatManager.kt` is the most game-mechanical part of the runtime worth reusing. It uses initiative-sorted combatants, staged action priority, and explicit handling for bash, kick, readied spells, melee, guard retaliation, and hit/miss/parry-like resolution rather than flattening combat into one generic attack function.
- `NpcManager.kt` shows a solid data-driven AI and spawn model: idle, wander, patrol, and pursuit modes; zone timers; room caps; boss phases; and on-spawn room locking all stay centralized in one NPC-oriented service.
- `WorldGraph.kt` demonstrates a mutable world-state layer beyond just room connections. Hidden exits, relock/reveal flows, interactable timers, and local neighborhood helpers all live alongside the room graph, which is useful for quest-heavy or exploration-heavy Android RPG products.
- The gameplay stack is notable because it stays authoritative on the server. Client screens and view models do not decide combat or world outcomes locally.

### UI, HUD, And Menus

- `AuthViewModel.kt` is a strong small-product reference. It coordinates handshake, version gating, platform-token flow, login/register requests, and initial post-login message capture before the main game view model fully takes over.
- `GameViewModel.kt` is large, but it is still a useful pattern for product-shell ownership. Inventory, equipment, party, follow, crafting, tutorial, trainer, map, atlas, reconnect state, and initial hydration all stay under one controller layer rather than scattering across many unrelated screens.
- `WorldBrowserViewModel.kt` is worth keeping because it separates the in-game socket from world-discovery and marketplace-style browsing. That helps the product stay understandable even though the repo blends a client, server, and authoring stack.
- `GameScreen.kt` shows how a text-heavy multiplayer RPG can keep a large amount of feature UI visible and layered without losing the central game flow.

### Persistence And Data

- `shared/protocol/MessageSerializer.kt` and `NeoMudVersion.kt` are the main persistence-like contract seam. The protocol uses one typed serialization layer with a discriminator and unknown-key tolerance, which keeps client/server evolution manageable.
- The world-content pipeline is the deeper reusable data pattern. `server/build.gradle.kts` packages world data into `.nmd`, and `scripts/validate-world.mjs` validates exits, reciprocal links, coordinate consistency, and overlap rules before packaging.
- `maker` broadens the repository's data value: the project does not treat world content as an unstructured pile of JSON files. Instead it has an explicit editor and validation path, which is rare in small Kotlin game repos.

### Networking And Multiplayer

- `shared/src/commonMain/kotlin/com/neomud/shared/protocol/ClientMessage.kt` and `ServerMessage.kt` are one of the strongest direct findings in the batch. They show a fully typed shared message contract for auth, movement, combat, inventory, map/atlas, party/follow, dialogue, trainers, vendors, crafting, and reconnect-state flows.
- `client/src/commonMain/kotlin/com/neomud/client/network/WebSocketClient.kt` and `ReconnectCoordinator.kt` show a practical reconnect strategy: only attempt bounded reconnects after a previously successful connection drops, and keep reconnect state explicit through flows.
- `PlatformApiClient.kt` plus `WorldBrowserViewModel.kt` show a clean split between HTTP product APIs and the live gameplay socket. That is an important architecture pattern for Android multiplayer products with both lobby/browser features and real-time play.
- `SessionManager.kt` adds another reusable network detail: it tracks recent activity to support idle reaping, and it can displace duplicate logins safely instead of letting multiple devices race the same character state.

### Tooling And Content Pipeline

- `maker` is the standout pipeline feature of the repository. A React/Express/Prisma/SQLite world-authoring surface living next to the Kotlin runtime is a good reminder that useful game repos often combine gameplay runtime with separate content tooling.
- `server/build.gradle.kts` includes `packageWorld` and `validateWorld` tasks, which turn content bundling into a first-class build step rather than an undocumented manual process.
- `scripts/validate-world.mjs` is especially worth citing later because it enforces content integrity at the repository level instead of leaving broken exits or coordinates to runtime failures.

### Android Platform Integration

- `client/src/androidMain/kotlin/com/neomud/client/MainActivity.kt` is a direct Android host layer with fullscreen immersive behavior and Android-specific layout preference persistence.
- `client/src/androidMain/kotlin/com/neomud/client/ui/navigation/NavGraph.kt` shows a good platform seam: Android-specific orientation and layout concerns stay in Android source sets while most app logic remains in shared Compose code.
- The Android value of `NeoMud` is real, but it comes from hosting a broader KMP game product rather than from custom Android graphics APIs. That makes it useful as a modern Android client-shell reference for larger shared-code game stacks.

### Build, Release, And Testing

- The verification surface is unusually strong for a low-star repo:
  - `16` shared test files
  - `90` server test files
  - `28` client test files
  - `34` maker tests
- `server/src/test/kotlin/com/neomud/server/AdminCommandTest.kt` uses Ktor `testApplication` and WebSocket flows rather than limiting tests to small pure functions.
- `BugFixesTest.kt` is also a good sign because it records regression intent directly instead of relying only on generic engine tests.
- The build scripts show a coherent modern toolchain with Android, iOS, WASM, and JVM targets plus world packaging and validation tasks, even though local discovery in this lab still stops at the Java `17+` floor.

## Reusable Takeaways

- Shared typed client/server protocols are worth centralizing in one Kotlin module when Android, desktop, and backend code all move together.
- Multiplayer Android products often benefit from splitting lobby/browser HTTP APIs from live gameplay WebSockets instead of forcing one transport to do everything.
- Server-authoritative tick loops are still highly relevant for Kotlin game products, even when the visible client is Compose-first and UI-heavy.
- World-content tooling becomes much more reusable when packaging and validation are explicit Gradle and script-level steps instead of tribal knowledge.

## Evidence Summary

- `Application.kt`, `GameLoop.kt`, `CommandProcessor.kt`, `SessionManager.kt`, `PlayerSession.kt` - authoritative runtime, lock boundary, and session ownership
- `CombatManager.kt`, `NpcManager.kt`, `WorldGraph.kt` - combat, AI, pursuit, mutable room graph, and gameplay-state services
- `ClientMessage.kt`, `ServerMessage.kt`, `MessageSerializer.kt`, `NeoMudVersion.kt` - shared protocol and version gates
- `WebSocketClient.kt`, `ReconnectCoordinator.kt`, `PlatformApiClient.kt`, `AuthViewModel.kt`, `GameViewModel.kt` - reconnect-aware client shell and HTTP-vs-socket split
- `MapOverlay.kt`, `MapDrawingUtils.kt`, `RoomBackground.kt`, `GameScreen.kt`, `MainActivity.kt` - Compose UI/game shell and Android host integration
- `packageWorld`, `validateWorld`, `validate-world.mjs`, and `maker` - validated content pipeline and authoring tooling
- `AdminCommandTest.kt`, `BugFixesTest.kt`, `PartyCommandTest.kt` - deep server-side and regression-oriented test surface

## Risks Or Limits

- The repository is explicitly framed as an AI-built playground, so not every subsystem should be treated as production-ready just because it looks current.
- The codebase is large and product-heavy; it is not a compact engine sample or a quick Android gameplay reference.
- Much of the strongest value lives in shared/server/networking architecture rather than in Android-only APIs.
- Meaningful local build verification still needs at least Java `17+`, and the server path clearly expects JDK `21`.
- The repository still carries an active TODO backlog around polish, assets, stress, and product completeness.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `android-game`
- Focus tags: `android`, `multiplatform`, `networking`, `ui-hud`, `asset-pipeline`, `testing`
- Follow-up needed:
  - if the lab revisits this repository, rerun Gradle discovery and selected server/client tasks in a JDK `17+` or `21` environment
  - good narrow revisit targets would be the shared protocol layer, the reconnect flow, the authoritative server loop, or the world-bundle validation pipeline rather than reopening the whole repo broadly
