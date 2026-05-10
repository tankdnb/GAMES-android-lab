# Research Note

## Repository Snapshot

- Repository: `yairm210/Unciv`
- Source URL: [https://github.com/yairm210/Unciv](https://github.com/yairm210/Unciv)
- Owner: `yairm210`
- Batch ID: [`BATCH-2026-05-10-C`](../batches/BATCH-2026-05-10-C.md)
- Type: `android-game`
- License: `MPL-2.0`
- Selection date: `2026-05-10`
- Last pushed at selection: `2026-05-10`
- Stars at selection: `10353`
- Investigated commit: `13d9e09006c34eb907c9b8d8964a86b3ebe50701`
- Research status: `accepted`
- Build mode: `static-review + gradle-discovery-attempt-timeout`
- Catalog card: [catalog/projects/yairm210-unciv.md](../../catalog/projects/yairm210-unciv.md)

## Why This Repository Was Selected

- It is one of the highest-signal Kotlin Android game repositories still missing from the lab.
- It combines direct Android relevance with large-scale gameplay, modding, save-state, AI, and multiplayer systems in one codebase.
- Its size made it a good test case for the dedicated heavy-repo batch workflow.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: LibGDX
- Rendering stack: LibGDX Scene2D UI plus custom world-map visualization and overlays
- Android target: explicit Android launcher, save/load bridge, deep links, background multiplayer worker, immersive-mode and cutout handling
- Build system: Gradle Kotlin DSL multi-module repository
- Repository layout summary: large shared-code game repository with `core`, `android`, `desktop`, `server`, `tests`, and `buildSrc`
- Key modules reviewed:
  - `core`
  - `android`
  - `server` integration surfaces via multiplayer client code
  - `tests` and simulation entry points where they explained reuse value

## Build And Runtime Notes

- The repository was investigated primarily through static code review.
- A lightweight Gradle discovery pass was attempted with `.\gradlew.bat help --no-daemon` on `2026-05-10`.
- That discovery attempt timed out after about 124 seconds, so this batch records the repository as a Gradle-discovery timeout rather than a build-validated result.
- No runtime launch was attempted.
- Known setup limitations:
  - large multi-module repository footprint
  - Android module is conditional on SDK availability
  - the main research value was architectural rather than execution validation

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `3`
- Implementation depth: `3`
- Code clarity: `2`
- Novelty: `3`
- Overall verdict: `accepted`
- Why:
  - it is a direct Android game with unusually deep implementation breadth
  - it contains several durable subsystem patterns that transfer to other Kotlin game projects
  - the repository handles scale, moddability, save-state reconstruction, and multiplayer in ways the lab can reuse as reference material

## Interesting Findings

### Engine Architecture And Core Loop

- `core/src/com/unciv/UncivGame.kt` splits startup between background loading of rulesets, translations, tilesets, and skins, and GL-thread-only creation of screens and render resources. The file explicitly documents GL-context recreation and ANR risk, which is a strong Android-aware lifecycle pattern.
- `core/src/com/unciv/ui/screens/worldscreen/WorldScreen.kt` routes heavy `update()` work through a `shouldUpdate` flag and the render loop so world updates happen on the main GL thread instead of arbitrary worker threads.
- `core/src/com/unciv/ui/screens/worldscreen/WorldScreen.kt` disables input during large map updates, then restores it after the screen is consistent again. This is a practical pattern for avoiding ANRs on expensive screen refreshes.
- `core/src/com/unciv/ui/screens/worldscreen/WorldScreen.kt` clones `GameInfo` and calculates `nextTurn()` on a background pool, then swaps in a new `WorldScreen` when the result is ready so the player can still inspect the map while the turn resolves.

### Gameplay Systems, Simulation, And Save State

- `core/src/com/unciv/logic/GameStarter.kt` supports both saved-map import and generated starts, chooses civilizations before generation so placement logic can depend on the roster, and rebuilds transient runtime links before assigning starting units.
- `core/src/com/unciv/logic/GameInfo.kt` clearly separates serializable game state from runtime-only transients. `setTransients()` reconstructs ruleset links, diplomacy, civ caches, tile ownership, victory references, and compatibility migrations after load.
- `core/src/com/unciv/logic/GameInfo.kt` centralizes turn advancement for AI, hotseat, spectators, and online multiplayer, including time-bank recovery for forced-resign rules.
- `core/src/com/unciv/logic/simulation/Simulation.kt` and `core/src/com/unciv/logic/simulation/SimulationStep.kt` provide a threaded simulation harness that can replay many randomized starts and collect win-rate and turn-stat summaries.

### Modding, Rulesets, And Data Validation

- `core/src/com/unciv/models/ruleset/RulesetCache.kt` loads built-in rulesets and installed mods in parallel, keeps the old cache alive until the new one is ready, and assembles base-plus-extension combined rulesets on demand.
- `core/src/com/unciv/models/ruleset/Ruleset.kt` treats the ruleset as a multi-file JSON schema with merge, removal, and fallback behavior rather than a monolithic data blob. It also tracks `originRuleset` for loaded objects.
- `core/src/com/unciv/models/ruleset/validation/RulesetValidator.kt` distinguishes extension-mod invariant checks from full base-ruleset validation, which is a strong pattern for allowing partial mods while still keeping strict validation for complete assembled rulesets.
- `core/src/com/unciv/models/ruleset/unique/Unique.kt` pre-parses the string-based unique DSL once and caches modifiers and stats specifically to avoid repeated regex work and UI ANRs.

### Map, Pathfinding, And Performance

- `core/src/com/unciv/logic/map/PathingMap.kt` centralizes pathing behind reusable caches keyed by movement context, with `AtomicReference`-managed cache reuse and lazy search only when a destination has not been solved yet.
- `core/src/com/unciv/logic/map/PathingMapAStarPathfinder.kt` extends pathfinding with multi-turn movement, road-speed heuristics, occupation handling, end-turn damage, and merging of forked pathfinding results back into shared caches.
- `core/src/com/unciv/logic/GameInfo.kt` explicitly batches expensive visibility and resource recomputation once per civilization and labels that as a major performance saver.

### AI And Automation

- `core/src/com/unciv/logic/automation/unit/WorkerAutomation.kt` uses a two-stage priority system: cheap tile ranking first, then expensive improvement ranking only for shortlisted tiles. It also caches rankings per turn and simulates removal/improvement consequences on cloned tiles before committing.
- `core/src/com/unciv/logic/automation/city/ConstructionAutomation.kt` scores buildings and units against production, war pressure, victory pressure, empire worker ratio, and personality weights, and even clones city state to estimate stat deltas from candidate buildings.
- `core/src/com/unciv/logic/automation/civilization/BarbarianAutomation.kt` encodes a compact priority ladder for barbarians: heal by pillaging, upgrade, attack, pillage, then wander.

### UI, HUD, And Screen Composition

- `core/src/com/unciv/ui/screens/worldscreen/WorldScreen.kt` stages map, notifications, tech/policy/diplomacy, chat, zoom controls, minimap, battle info, and bottom unit/tile panels inside one screen and recomputes geometry during update and resize instead of assuming a static layout.
- `core/src/com/unciv/ui/screens/basescreen/BaseScreen.kt` keeps one shared skin/bootstrap path for fonts and UI drawables while letting each screen own its own stage and SpriteBatch lifecycle.

### Multiplayer And Networking

- `core/src/com/unciv/logic/multiplayer/Multiplayer.kt` mixes local file-backed previews with remote authoritative state and throttles refreshes through atomic timestamps to avoid rate limits and OOM-heavy update fan-out.
- `core/src/com/unciv/logic/multiplayer/storage/MultiplayerServer.kt` uploads zipped `GameInfo` before the preview file to avoid a preview-race bug, and abstracts Dropbox versus custom server backends behind one storage surface.
- `core/src/com/unciv/logic/multiplayer/chat/ChatWebSocket.kt` runs authenticated chat over Ktor WebSockets with exponential backoff reconnects and relay-on-ack behavior instead of optimistic local echo.
- `core/src/com/unciv/logic/multiplayer/apiv2/ApiV2.kt` adds explicit server compatibility checks, reconnectable websocket wrappers, and event channels that can be consumed outside the GL thread for background or headless work.

### Android Integration

- `android/src/com/unciv/app/AndroidLauncher.kt` wires platform display, fonts, save/load, immersive mode, cutout policy, multiplayer notification channels, deep links, and a background turn-check worker before initializing the LibGDX game.
- `android/src/com/unciv/app/AndroidLauncher.kt` copies user-visible external mod folders into the private app directory that LibGDX reads from, which is a pragmatic bridge between Android storage constraints and moddability.
- `android/src/com/unciv/app/AndroidGame.kt` converts visible-window changes into stage-space rectangles and sends them back to the GL thread, which is a strong pattern for keyboard/system-UI-aware game layout.
- `android/src/com/unciv/app/AndroidDisplay.kt` wraps screen modes, immersive system UI, cutout allowance, and orientation as a platform abstraction instead of scattering window calls through gameplay code.
- `android/src/com/unciv/app/AndroidSaverLoader.kt` uses the Android Storage Access Framework through `ACTION_CREATE_DOCUMENT` and `ACTION_OPEN_DOCUMENT`, which is the correct modern save import/export path for user-managed files.

## Reusable Takeaways

- Keep the serialized game state separate from runtime-only transients, then rebuild those links explicitly after load.
- For long turn resolution, clone the authoritative game state and resolve the turn off-thread, but keep screen updates and asset-sensitive work on the GL thread.
- Treat moddability as a validated content pipeline with merge, removal, fallback, and compatibility-repair steps.
- Reuse pathing caches across repeated queries in the same movement context instead of running a fresh search for every destination.
- Hide Android-specific storage, display, and deep-link behavior behind platform abstractions so the core game logic remains portable.

## Evidence Summary

- `core/src/com/unciv/UncivGame.kt` - startup orchestration, GL-thread boundaries, screen lifecycle
- `core/src/com/unciv/logic/GameStarter.kt` - new-game pipeline, map generation and roster setup
- `core/src/com/unciv/logic/GameInfo.kt` - cloned next-turn state, save-state reconstruction, performance-sensitive transients
- `core/src/com/unciv/logic/simulation/Simulation.kt`
- `core/src/com/unciv/logic/simulation/SimulationStep.kt`
- `core/src/com/unciv/logic/files/UncivFiles.kt` - storage abstraction, saves, previews, custom-location bridge
- `core/src/com/unciv/ui/screens/basescreen/BaseScreen.kt`
- `core/src/com/unciv/ui/screens/worldscreen/WorldScreen.kt`
- `core/src/com/unciv/models/ruleset/RulesetCache.kt`
- `core/src/com/unciv/models/ruleset/Ruleset.kt`
- `core/src/com/unciv/models/ruleset/validation/RulesetValidator.kt`
- `core/src/com/unciv/models/ruleset/unique/Unique.kt`
- `core/src/com/unciv/logic/map/PathingMap.kt`
- `core/src/com/unciv/logic/map/PathingMapAStarPathfinder.kt`
- `core/src/com/unciv/logic/automation/unit/WorkerAutomation.kt`
- `core/src/com/unciv/logic/automation/city/ConstructionAutomation.kt`
- `core/src/com/unciv/logic/automation/civilization/BarbarianAutomation.kt`
- `core/src/com/unciv/logic/multiplayer/Multiplayer.kt`
- `core/src/com/unciv/logic/multiplayer/storage/MultiplayerServer.kt`
- `core/src/com/unciv/logic/multiplayer/chat/ChatWebSocket.kt`
- `core/src/com/unciv/logic/multiplayer/apiv2/ApiV2.kt`
- `android/src/com/unciv/app/AndroidLauncher.kt`
- `android/src/com/unciv/app/AndroidGame.kt`
- `android/src/com/unciv/app/AndroidDisplay.kt`
- `android/src/com/unciv/app/AndroidSaverLoader.kt`

## Risks Or Limits

- This is a very large repository, so this pass focused on the highest-value subsystem hotspots rather than exhaustive file coverage.
- The Gradle discovery attempt timed out, so no build-validated conclusion was recorded.
- No runtime execution was attempted.
- The repository is under `MPL-2.0`, so direct code reuse should still be checked carefully at the file level.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `android-game`
- Focus tags: `2d`, `android`, `libgdx`, `save-load`, `ai`, `networking`, `ui-hud`
- Follow-up needed:
  - inspect map-generation internals and server module code later if the lab needs deeper references for procedural map setup or backend implementation
