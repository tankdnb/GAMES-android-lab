# Research Note

## Repository Snapshot

- Repository: `Baret/pltcmd`
- Source URL: [https://github.com/Baret/pltcmd](https://github.com/Baret/pltcmd)
- Owner: `Baret`
- Batch ID: [`BATCH-2026-06-04-Y`](../batches/BATCH-2026-06-04-Y.md)
- Type: `gameplay-systems`
- License: `MIT`
- Selection date: `2026-06-04`
- Last pushed at selection: `2026-06-03`
- Stars at selection: `4`
- Default branch at selection: `master`
- Investigated commit: `ee6d26b375b3f6929f2d1fdc9616efcdd2506fde`
- Research status: `accepted`
- Build mode: `static-review + maven-unavailable-local`
- Catalog card: [catalog/projects/baret-pltcmd.md](../../catalog/projects/baret-pltcmd.md)

## Why This Repository Was Selected

- `pltcmd` became the strongest remaining candidate in the carry-over explicit-license shortlist after `roomsmith-games/NeoMud`.
- Compared with the zero-star Android fallback candidates still in reserve, it had slightly better public signal, equally fresh activity, and a much more distinctive core question: can a Kotlin tactics project turn radio communication itself into the main control protocol?
- The main question for this batch was whether a desktop-first repository with no Android target still deserves main-catalog status. The answer is `accepted`: the UI shell is not mobile-relevant, but the command, signal, visibility, map-generation, and domain-structure ideas are unusually reusable for future Android tactics or strategy work.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: custom Kotlin/JVM tactical simulation monorepo with Hexworks Amethyst entity systems, Zircon Swing tile UI, Cobalt databinding, and coroutine-backed communication flow
- Rendering stack: Zircon terminal/tile UI on top of Swing, with map fragments, sidebars, and a radio log rather than a sprite-scene renderer
- Android target: none found in the checked-in build or runtime; the repository is valuable indirectly for simulation, command, and UI-architecture patterns
- Build system: Maven multi-module monorepo with Kotlin Maven plugin, Java/Kotlin target `21`, Surefire, Enforcer, and GitHub Actions CI
- Repository layout summary:
  - `util/` - shared helpers for events, geometry, graph work, knowledge tracking, measurements, naming, debug helpers, and test support
  - `model/` - tactical domain for elements, factions, world, pathfinding, communication, map generation, and signal propagation
  - `game/` - application bootstrap, engine/runtime, tick scheduler, UI, options, serialization, and presentation strings
- Source footprint:
  - total files counted in repository: `459`
  - Kotlin/Java files counted in repository: `332`
- Test surface:
  - files matching `*Test.kt` or `*Test.java`: `52`
  - meaningful automated coverage exists across world/model math, map generation, radio/signal logic, engine behaviors, and UI string transforms
- Key modules reviewed:
  - `README.md`
  - `pom.xml`
  - `game/pom.xml`
  - `model/pom.xml`
  - `util/pom.xml`
  - `game/application/pom.xml`
  - `game/engine/pom.xml`
  - `game/ticks/pom.xml`
  - `game/ui/pom.xml`
  - `.github/workflows/build.yml`
  - `game/application/src/main/kotlin/de/gleex/pltcmd/game/application/main.kt`
  - `game/engine/src/main/kotlin/de/gleex/pltcmd/game/engine/Game.kt`
  - `game/engine/src/main/kotlin/de/gleex/pltcmd/game/engine/entities/EntitySet.kt`
  - `game/engine/src/main/kotlin/de/gleex/pltcmd/game/engine/systems/facets/ExecuteOrder.kt`
  - `game/engine/src/main/kotlin/de/gleex/pltcmd/game/engine/systems/facets/Detects.kt`
  - `game/ticks/src/main/kotlin/de/gleex/pltcmd/game/ticks/Ticker.kt`
  - `game/ui/src/main/kotlin/de/gleex/pltcmd/game/ui/views/GameView.kt`
  - `game/ui/src/main/kotlin/de/gleex/pltcmd/game/ui/fragments/ElementCommandFragment.kt`
  - `game/serialization/src/main/kotlin/de/gleex/pltcmd/game/serialization/world/MapStorage.kt`
  - `model/mapgeneration/src/main/kotlin/de/gleex/pltcmd/model/mapgeneration/mapgenerators/WorldMapGenerator.kt`
  - `model/world/src/main/kotlin/de/gleex/pltcmd/model/world/WorldMap.kt`
  - `model/pathfinding/src/main/kotlin/de/gleex/pltcmd/model/pathfinding/Pathfinder.kt`
  - `model/communication/src/main/kotlin/de/gleex/pltcmd/model/radio/RadioSender.kt`
  - `model/communication/src/main/kotlin/de/gleex/pltcmd/model/radio/communication/RadioCommunicator.kt`
  - `model/communication/src/main/kotlin/de/gleex/pltcmd/model/radio/communication/RadioContext.kt`
  - `model/communication/src/main/kotlin/de/gleex/pltcmd/model/radio/communication/transmissions/decoding/TransmissionDecoding.kt`
  - `model/signals/radio/src/main/kotlin/de/gleex/pltcmd/model/signals/radio/RadioSignalPropagator.kt`
  - `model/signals/vision/src/main/kotlin/de/gleex/pltcmd/model/signals/vision/VisionPropagator.kt`
  - `model/elements/src/main/kotlin/de/gleex/pltcmd/model/elements/Elements.kt`

## Build And Runtime Notes

- The repository was investigated through static code review only.
- No Maven wrapper (`mvnw`) was found in the inspected tree.
- `mvn -version` cannot be executed in the lab because Maven is not installed in the current environment.
- The checked-in repository clearly expects a modern local toolchain:
  - root `pom.xml` sets Java and Kotlin JVM target `21`
  - `.github/workflows/build.yml` installs JDK `21`
  - CI runs `mvn -B -U clean install --file pom.xml`
- Because the lab currently lacks a local Maven command, no compile, test, or runtime execution was attempted from the clone.
- No UI launch was attempted.

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `2`
- Implementation depth: `3`
- Code clarity: `3`
- Novelty: `3`
- Overall verdict: `accepted`
- Why:
  - `pltcmd` has a genuinely distinctive gameplay/control model: the player issues orders through radio conversations rather than through direct unit manipulation.
  - The repository is also stronger than many low-star prototypes in structure and verification: `util` / `model` / `game` separation is clean, tests are broad for the repo size, and the signal/visibility/map-generation layers are reusable independently of the desktop shell.
  - Android relevance is indirect, but the tactics-simulation architecture is strong enough to justify keeping it in the main catalog.

## Interesting Findings

### Engine Architecture And Core Loop

- `game/application/.../main.kt` keeps startup surprisingly disciplined for a hobby tactics project: title screen, map select, map generation, game preparation, and view mounting are all staged explicitly instead of being collapsed into one launcher.
- `game/ticks/.../Ticker.kt` is the runtime heartbeat. It owns the current tick, simulated time, day counter, pause state, and the scheduled executor that publishes tick events through a shared event bus.
- `game/engine/.../Game.kt` shows a useful bridge between a global tick source and an entity-system runtime. Each tick starts one Amethyst engine update job with a fresh `GameContext`, and the code explicitly waits if the previous tick update has not finished yet.
- The root monorepo split into `util`, `model`, and `game` is one of the best takeaways by itself. Spatial logic, communication, and tactical composition stay out of the UI and application layers, which makes later Android adaptation much more realistic.

### Gameplay Systems

- `ExecuteOrder.kt` is the most direct reusable pattern in the repository. Radio orders are converted into commander intents and chained goal objects such as `ReachDestination`, `PatrolAreaGoal`, `HaltGoal`, and follow-up `RadioGoal` acknowledgements.
- `RadioCommunicator.kt` treats communications as buffered conversations, not fire-and-forget commands. Conversations can queue behind active traffic, reply with `stand by`, or cancel if nothing is heard back.
- `TransmissionDecoding.kt` is unusually bold and useful as a prototype idea: human-readable radio text is the protocol. Sender, receiver, order, and location are parsed back out of message templates rather than being transported only as structured internal data.
- `Elements.kt` provides a DSL-like catalog of units, fireteams, squads, platoons, corps, and vehicle variants. This is a strong reference for tactics games that need structured composition rules without hardcoding every possible formation in imperative logic.
- `WorldMapGenerator.kt` uses a clear intermediate-generator pipeline with mountain-top mapping, river typing, plains generation, height filling, type filling, and random terrain filling. The result is deterministic, staged terrain generation rather than one opaque world-builder.

### Signals, Detection, And World Simulation

- `RadioSignalPropagator.kt` models radio range as terrain-aware attenuation. Grassland, forest, hills, mountains, air, and ground all affect remaining signal power differently, and maximum range is derived analytically from the loss curve.
- `VisionPropagator.kt` applies the same general idea to line-of-sight: air, terrain, and ground contact all degrade visibility, with ground contact effectively collapsing the view after the first blocked uphill transition.
- `Detects.kt` turns those signal strengths into gameplay-visible detections. It clears the observer's view every pass, rebuilds what can currently be seen, and emits `DetectedEntity` messages only when visibility is non-zero.
- `WorldMap.kt` wraps a coordinate graph, sector decomposition, circle/area queries, and boundary clamping. It is a clean reusable foundation for strategy-scale map logic that does not depend on any particular rendering layer.

### Input And Controls

- `ElementCommandFragment.kt` is the clearest player-control seam in the repository: select a callsign, click a map coordinate, and issue a radio conversation that becomes an order only after passing through the communication layer.
- `GameView.kt` keeps high-level controls compact and explicit: keyboard panning over sectors, radio-signal debug toggling, and pause control sit at the shell level, while actual command semantics stay deeper in the model and engine layers.
- The control model is worth remembering for Android work because it separates destination picking from unit behavior. A touch UI could reuse the same pattern without copying the desktop widgets.

### UI, HUD, And Menus

- `GameView.kt` composes the tactical shell from four distinct surfaces: radio log, command sidebar, map fragment, and info sidebar. That is a cleaner pattern than mixing communications, unit control, and map rendering into one monolithic view.
- The radio log is especially good as a reusable idea: sent and received transmissions are treated as first-class player feedback and timestamped with simulated tick time instead of being buried in debug output.
- `main.kt`, `MenuView`, and `GeneratingView` show a complete but compact title/load/generate/start flow that could be repurposed for small tactics prototypes.

### Persistence And Data

- `MapStorage.kt` and `WorldMapDao` give generated maps a typed save/load boundary rather than coupling procedural generation to one ephemeral runtime session.
- `StorageId` keeps storage names and storage types explicit, which is useful when a tactics game needs several persisted artifact types instead of one undifferentiated save blob.

### Build, Release, And Testing

- The Maven module layout is stronger than expected for a low-star game repo. Root, `util`, `model`, and `game` parent poms keep the domain and application layers intentionally separated.
- The repository also has real CI discipline for its size: `.github/workflows/build.yml` runs full Maven install on JDK `21` for every push.
- `52` test files were found across engine behaviors, world math, map generation, signal propagation, radio send/receive flow, and UI string transformations. That makes `pltcmd` a better reliability reference than many more visible prototype game repos.

## Reusable Takeaways

- Treat communications as gameplay protocol objects instead of only as UI flavor text.
- Model radio and vision with terrain-aware signal propagation so command and detection limits become systemic rather than scripted.
- Keep tactics simulation split into `util`, `model`, and `game` layers so UI and platform shells stay replaceable.
- Let user input build domain messages first, then convert those messages into runtime goals; do not mutate unit state directly from the view layer.
- Small strategy projects benefit from deterministic intermediate-generator pipelines and structured formation blueprints far more than from ad hoc unit or map definitions.

## Evidence Summary

- `main.kt`, `Ticker.kt`, and `Game.kt` - staged bootstrap, tick publication, and Amethyst engine updates driven from a shared simulation heartbeat
- `ExecuteOrder.kt`, `RadioCommunicator.kt`, and `TransmissionDecoding.kt` - radio-conversation protocol, order execution, queued replies, and text-decoded command semantics
- `RadioSignalPropagator.kt`, `VisionPropagator.kt`, `Detects.kt`, and `WorldMap.kt` - terrain-aware signal/visibility simulation and spatial world queries
- `ElementCommandFragment.kt` and `GameView.kt` - map-click destination picking, callsign-targeted order flow, and radio-log-first tactical UI shell
- `Elements.kt` and `WorldMapGenerator.kt` - unit-formation blueprints and staged procedural terrain generation
- `MapStorage.kt` plus the Maven poms and GitHub workflow - typed map persistence, modular monorepo structure, and JDK `21` build discipline

## Risks Or Limits

- No Android target or mobile host shell is checked in.
- The presentation layer is very desktop-specific: Swing plus Zircon tile UI is useful conceptually, but not directly reusable as mobile UI code.
- Local Maven validation could not be reproduced in the lab because no `mvn` command is installed and the repository does not ship a wrapper.
- Some command/behavior paths are visibly incomplete:
  - `GoFirm` in `ExecuteOrder.kt` is still `TODO()`
  - FOB-specific order handling is only a placeholder
  - `RadioCommunicator` still contains TODOs around event-bus removal and richer knowledge learning
- `TransmissionDecoding.kt` depends on rigid message phrasing, which is fine for a prototype but fragile for broader systems.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `gameplay-systems`
- Focus tags: `2d`, `input`, `ui-hud`, `procedural-generation`, `save-load`, `testing`
- Follow-up needed:
  - if the lab revisits this repository, rerun build or selected tests in a Maven plus JDK `21` environment, or isolate the radio-conversation protocol, the signal/visibility propagation layer, or the element-blueprint DSL instead of reopening the whole monorepo broadly
