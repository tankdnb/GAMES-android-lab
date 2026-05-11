# Research Note

## Repository Snapshot

- Repository: `kotcity/kotcity`
- Source URL: [https://github.com/kotcity/kotcity](https://github.com/kotcity/kotcity)
- Owner: `kotcity`
- Batch ID: [`BATCH-2026-05-11-E`](../batches/BATCH-2026-05-11-E.md)
- Type: `gameplay-systems`
- License: `Apache-2.0`
- Selection date: `2026-05-11`
- Last pushed at selection: `2021-08-23`
- Stars at selection: `488`
- Investigated commit: `0ee1cbf4ad345c956f4f2bcfc65bb0b2b423eb3b`
- Research status: `accepted`
- Build mode: `static-review + gradle-help-failed-java8-incompatible-javafx-plugin`
- Catalog card: [catalog/projects/kotcity-kotcity.md](../../catalog/projects/kotcity-kotcity.md)

## Why This Repository Was Selected

- Fresh GitHub `updated` searches were still dominated by near-zero-signal repositories, so the strongest remaining path was a stale but systems-heavy backlog candidate.
- `kotcity/kotcity` offered more likely research yield than `wajahatkarim3/DinoCompose` or weaker fresh experiments because it concentrates economy, zoning, traffic, persistence, and UI-inspection systems inside one Kotlin simulator.
- Even though it is desktop-first and not Android-native, its simulation architecture is directly relevant to Android tycoon, city-builder, and management-game work.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: JavaFX + TornadoFX + custom city-simulation runtime
- Rendering stack: JavaFX `Canvas` rendering, FXML/TornadoFX desktop shell, sprite-based buildings, separate overlay canvases for traffic and alerts, and heatmap-style layer renderers
- Android target: no direct Android target was found in the inspected revision; transfer value is indirect through simulation, pathfinding, persistence, and strategy/management UI patterns
- Build system: single-module Gradle Groovy DSL JVM application with Kotlin/JVM, JavaFX plugin, ShadowJar packaging, Dokka, and Launch4j distribution tasks
- Repository layout summary: the main simulation code lives in `src/main/kotlin/kotcity/{data,automata,pathfinding,ui}`, assets and building definitions live under `assets/`, and the repository keeps a real `src/test/kotlin` surface for pathfinding, serialization, economy, map generation, and automata behavior
- Key modules reviewed:
  - `README.md`
  - `build.gradle`
  - `settings.gradle`
  - `src/main/kotlin/kotcity/data/CityMap.kt`
  - `src/main/kotlin/kotcity/data/Economy.kt`
  - `src/main/kotlin/kotcity/data/CityFileAdapter.kt`
  - `src/main/kotlin/kotcity/data/MapGenerator.kt`
  - `src/main/kotlin/kotcity/data/buildings/Building.kt`
  - `src/main/kotlin/kotcity/automata/ContactFulfiller.kt`
  - `src/main/kotlin/kotcity/automata/ResourceFinder.kt`
  - `src/main/kotlin/kotcity/automata/Constructor.kt`
  - `src/main/kotlin/kotcity/automata/Upgrader.kt`
  - `src/main/kotlin/kotcity/automata/CensusTaker.kt`
  - `src/main/kotlin/kotcity/automata/DesirabilityUpdater.kt`
  - `src/main/kotlin/kotcity/automata/HappinessUpdater.kt`
  - `src/main/kotlin/kotcity/automata/Pollution.kt`
  - `src/main/kotlin/kotcity/automata/PowerCoverageUpdater.kt`
  - `src/main/kotlin/kotcity/automata/PowerCoverageAutomata.kt`
  - `src/main/kotlin/kotcity/automata/TrafficCalculator.kt`
  - `src/main/kotlin/kotcity/automata/Shipper.kt`
  - `src/main/kotlin/kotcity/pathfinding/Pathfinder.kt`
  - `src/main/kotlin/kotcity/ui/GameFrame.kt`
  - `src/main/kotlin/kotcity/ui/map/CityRenderer.kt`
  - `src/test/kotlin/PathfinderTest.kt`
  - `src/test/kotlin/CityFileAdapterTest.kt`
  - `src/test/kotlin/EconomyTest.kt`
  - `src/test/kotlin/AutomataTest.kt`

## Build And Runtime Notes

- The repository was investigated primarily through static code review plus lightweight Gradle discovery.
- `java -version` on the lab machine reports `1.8.0_321`.
- `cmd /c gradlew.bat help --no-daemon` bootstraps Gradle `6.3`, but build configuration fails immediately because `org.openjfx.javafxplugin` is compiled for class-file version `55.0` while the lab machine only supports `52.0` (`Java 8`).
- `build.gradle` confirms that the inspected revision effectively expects `Java 11+`: both `compileKotlin` and `compileTestKotlin` target JVM `11`, JavaFX plugin configuration is set to version `15`, and Launch4j declares `jreMinVersion = 11`.
- The build still depends on `jcenter()` in both the buildscript and main repositories blocks, so reproducibility risk is higher than a modern Gradle build even after the Java version issue is resolved.
- `src/test/kotlin/` contains meaningful unit coverage for pathfinding, automata, economy, caching, spatial queries, map generation, save/load, and asset loading, which raises confidence above a metadata-only sample.
- Known setup limitations:
  - the lab machine still runs only Java `8`
  - the repository is desktop JavaFX/TornadoFX only in the inspected revision
  - no runtime validation was attempted beyond Gradle discovery

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `2`
- Implementation depth: `3`
- Code clarity: `2`
- Novelty: `3`
- Overall verdict: `accepted`
- Why:
  - it is one of the stronger gameplay-systems references in the lab because zoning, desirability, supply-demand balancing, route-based logistics, power coverage, pollution, and save/load all live in one Kotlin codebase
  - it is not an Android runtime reference, but many of the core systems are portable into Android city-builder or management-game projects
  - despite age and rough edges, it offers more reusable simulation architecture than the remaining low-signal backlog alternatives

## Interesting Findings

### Engine Architecture And Simulation Loop

- `src/main/kotlin/kotcity/data/CityMap.kt` is the real heart of the project. It keeps a layered city model for terrain, buildings, zoning, power lines, resources, land value, fire coverage, crime, police presence, pollution, traffic, districts, and desirability, while also owning the simulation automata, time state, and a `NationalTradeEntity` for external trade.
- The same `CityMap.kt` combines a `davidmoten/rtree` spatial index with a memoized `cachedLocationsIn()` wrapper, which is a useful pattern for management games that need many repeated proximity queries without recalculating all overlaps each tick.
- `CityMap.hourlyTick()` and `dailyTick()` define a staged simulation pipeline instead of one opaque update loop. Hourly work handles contracts, manufacturing, shipping, goods consumption, traffic, alerts, pollution, and happiness; less frequent phases handle census, liquidation, contract validation, construction, upgrades, taxes, fire coverage, crime, power, and land value.
- `src/main/kotlin/kotcity/ui/GameFrame.kt` separates rendering from simulation by using `AnimationTimer` for drawing and a `TimerTask` with adjustable `GameSpeed` for `map.tick()`, which keeps the desktop UI responsive while still letting the game speed change independently.

### Economy, Logistics, And Growth

- `src/main/kotlin/kotcity/data/buildings/Building.kt` treats every meaningful building as a simulation unit with inventory, contracts, production/consumption maps, goodwill, level, and power state. That makes later systems work against one common economic interface instead of ad hoc per-building logic.
- `src/main/kotlin/kotcity/data/Economy.kt` models contracts as path-carrying transfers between `TradeEntity` endpoints, with deterministic lock ordering during execution so inventory and money transfers do not deadlock when two parties transact simultaneously.
- `src/main/kotlin/kotcity/automata/ContactFulfiller.kt` uses a retry-throttle cache, timeout-bounded coroutine batches, and separate consume/produce handling to sign contracts between buildings that need labor, goods, raw materials, or wholesale goods. This is a practical pattern for demand-driven route contracting rather than naive nearest-neighbor exchange.
- `src/main/kotlin/kotcity/automata/Shipper.kt` and `TrafficCalculator.kt` turn those contracts into actual movement and derived traffic. Goods contracts execute inventory transfers and money flows, while traffic volume is rebuilt from the contract paths and quantities instead of from a separate vehicle simulation.
- `src/main/kotlin/kotcity/automata/CensusTaker.kt`, `Constructor.kt`, `Upgrader.kt`, and `DesirabilityUpdater.kt` form a coherent city-growth loop: census calculates supply-demand ratios, desirability scores each zone by jobs/goods/labor/traffic/pollution/land-value conditions, constructor places new buildings in top-scoring valid zones, and upgrader promotes high-goodwill locations into higher-level assets.

### Pathfinding, Infrastructure, And Environmental Layers

- `src/main/kotlin/kotcity/pathfinding/Pathfinder.kt` has a reusable shape for management-game logistics. It first finds a short cast from a building footprint to a nearby road, then runs an A*-style search over road, railroad, and station nodes, accounting for one-way roads, rail transitions, and traffic penalties inside the heuristic.
- The same `Pathfinder.kt` can also route to the map border, which lets the economy fall back to national trade and makes outside-world interaction explicit instead of magical.
- `src/main/kotlin/kotcity/automata/ResourceFinder.kt` layers business logic on top of pathfinding by selecting the nearest valid buyer/seller with stock and path access, then falling back to outside trade only when local options fail and a cooldown has expired.
- `src/main/kotlin/kotcity/automata/PowerCoverageUpdater.kt` plus `PowerCoverageAutomata.kt` simulate power spread from multiple plants with mergeable grids and finite available power, which is a strong reference for simple utility-network propagation without introducing a full graph solver.
- `src/main/kotlin/kotcity/automata/Pollution.kt` and `HappinessUpdater.kt` show a lightweight environmental-feedback loop: contract-derived road traffic contributes to pollution, pollution diffuses and evaporates over time, and building happiness/goodwill reacts to jobs, labor satisfaction, traffic, and pollution-based alerts.
- `src/main/kotlin/kotcity/data/MapGenerator.kt` uses layered OpenSimplex noise for terrain plus separate seeded noise fields for resources like oil, coal, gold, and soil. It is not deeply tied into later economy code, but it is still a reusable procedural-generation pattern for map-backed simulation games.

### Rendering, UI, And Persistence

- `src/main/kotlin/kotcity/ui/map/CityRenderer.kt` shows a practical multi-layer city-view approach: base terrain rendering, zoning tint overlays, sprite-based building drawing, district outlines, map-mode heatmaps, and route highlighting for contracts that pass through a selected tile.
- `src/main/kotlin/kotcity/ui/GameFrame.kt` stacks separate canvases for the main city, animated traffic, and `zot` warnings, then exposes direct tools for roads, rails, zoning, districts, power lines, schools, query mode, and route inspection. This is useful reference material for debug-friendly management-game UI.
- `src/main/kotlin/kotcity/data/CityFileAdapter.kt` writes a GZIP-compressed JSON city file containing terrain, zones, resources, buildings, power lines, desirability layers, and contracts. On load it rebuilds the city in stages, recomputes path-backed contracts, refreshes outside connections, and forces power coverage to recalculate instead of blindly trusting serialized transient state.
- `src/main/kotlin/kotcity/data/AssetManager.kt` loads many buildings from JSON asset definitions rather than hard-coding every residential/commercial/industrial variant, which is a simple but valuable content-pipeline pattern for city simulators or management games.

## Reusable Takeaways

- A city-builder can keep most simulation code coherent if the whole world is represented as one layered city object with derived maps for power, desirability, pollution, and traffic.
- Contract-based supply chains are a good middle ground between purely abstract economy numbers and fully simulated vehicles, especially when traffic can be derived from the chosen routes.
- Zoning becomes more interesting when desirability is recomputed from nearby jobs, goods, land value, pollution, and traffic rather than from a single scalar demand meter.
- Structured save files should persist durable state layers and rebuild transient derived state such as routes or power coverage during load.
- Separate overlay canvases and map modes make it much easier to inspect and debug complex simulation state than a single monolithic render pass.

## Evidence Summary

- `src/main/kotlin/kotcity/data/CityMap.kt` - layered world model, spatial index/cache, staged hourly/daily simulation pipeline, build/bulldoze/road/rail/power helpers
- `src/main/kotlin/kotcity/data/buildings/Building.kt` and `data/Economy.kt` - inventory, contracts, trade entities, money flow, building-level production/consumption
- `src/main/kotlin/kotcity/automata/ContactFulfiller.kt`, `ResourceFinder.kt`, `Shipper.kt`, and `TrafficCalculator.kt` - contract signing, source/buyer search, shipment execution, and route-derived traffic
- `src/main/kotlin/kotcity/automata/CensusTaker.kt`, `Constructor.kt`, `Upgrader.kt`, and `DesirabilityUpdater.kt` - demand assessment, desirability scoring, procedural growth, and upgrades
- `src/main/kotlin/kotcity/pathfinding/Pathfinder.kt` - road/rail pathfinding, one-way handling, traffic-aware heuristics, and path-to-outside logic
- `src/main/kotlin/kotcity/automata/PowerCoverageUpdater.kt`, `PowerCoverageAutomata.kt`, `Pollution.kt`, and `HappinessUpdater.kt` - utility propagation and environmental feedback systems
- `src/main/kotlin/kotcity/data/CityFileAdapter.kt`, `MapGenerator.kt`, and `AssetManager.kt` - save/load, procedural terrain/resource generation, and JSON-defined buildings
- `src/main/kotlin/kotcity/ui/GameFrame.kt` and `ui/map/CityRenderer.kt` - multi-canvas rendering, tool-driven map editing, route inspection, and heatmap overlays
- `src/test/kotlin/PathfinderTest.kt`, `CityFileAdapterTest.kt`, `EconomyTest.kt`, and `AutomataTest.kt` - representative verification surface for routing, persistence, economy, and power automata

## Risks Or Limits

- The repository is stale by the lab's standards: last push at selection was `2021-08-23`.
- The inspected revision is clearly desktop-first and JavaFX/TornadoFX-based, with no direct Android launcher or packaging path.
- Local Gradle discovery fails in the lab because the repository effectively needs Java `11+`, while the machine still exposes Java `8`; the build also still references `jcenter()`.
- Several important simulation passes use `GlobalScope` and shared mutable layers, so this should be treated as a strong idea source rather than as a proven production-concurrency baseline.
- The project is still framed as pre-alpha in its own metadata, and some systems remain visibly rough or partially integrated, especially around resource layers and some TODO/FIXME-marked pathfinding/contract code.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `gameplay-systems`
- Focus tags: `2d`, `save-load`, `procedural-generation`, `ui-hud`, `performance`, `testing`
- Follow-up needed:
  - if the lab revisits this repository later, focus on the contract economy, pathfinding/traffic loop, or power-grid propagation instead of reopening the whole codebase broadly
  - if build validation becomes important, rerun `gradlew help` and a small test slice in a real Java `11+` environment
