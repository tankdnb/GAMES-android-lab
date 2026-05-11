# Project Entry

## Basic Info

- Project name: `KotCity`
- Source repository: [https://github.com/kotcity/kotcity](https://github.com/kotcity/kotcity)
- Author / organization: `kotcity`
- License: `Apache-2.0`
- Research note: [research/findings/kotcity-kotcity.md](../../research/findings/kotcity-kotcity.md)
- Investigated commit: `0ee1cbf4ad345c956f4f2bcfc65bb0b2b423eb3b`
- Last verified: `2026-05-11`
- Activity / maintenance status: last push recorded at selection was `2021-08-23`, and the repository still describes itself as a pre-alpha city simulator.

## Short Description

Pre-alpha Kotlin city simulator with layered city-state maps, path-aware trade contracts, zoning/desirability growth rules, power and pollution simulation, save/load support, and JavaFX-based map inspection tools.

## Technical Profile

- Primary category: `gameplay-systems`
- Focus tags: `2d`, `save-load`, `procedural-generation`, `ui-hud`, `performance`, `testing`
- Engine / framework: JavaFX + TornadoFX + custom simulation/runtime code
- Rendering approach: JavaFX `Canvas` terrain/building rendering with stacked overlay canvases for traffic and alerts, heatmap-style map modes, and sprite-based building cards
- Main language(s): Kotlin
- Android target: no direct Android target in the inspected revision; strongest value is in portable simulator/gameplay systems rather than runtime reuse
- Build system: single-module Gradle Groovy DSL JVM application with Kotlin/JVM, JavaFX plugin, ShadowJar, Dokka, and Launch4j packaging tasks

## Why It Matters

- This repository is useful to the lab because it collects several city-builder subsystems in one place: inventory-backed production/consumption, route-based trade contracts, desirability-driven zoning, staged simulation ticks, power propagation, pollution, and save/load.
- For Android game development, its value is indirect but still strong when building tycoon, management, or strategy games where the runtime may be different but the simulation architecture is reusable.

## Reusable Ideas

- Gameplay ideas:
  - zoning that grows from desirability rather than from a single global demand value
  - contract-based economy where routes themselves later feed traffic and environmental systems
- Architecture patterns:
  - one central layered `CityMap` model with derived simulation layers and spatial indexing
  - separate hourly and daily automata passes instead of one monolithic update function
- Graphics / rendering techniques:
  - multi-canvas overlay rendering for base map, traffic, alerts, and diagnostic map modes
  - route inspection by highlighting contract paths through the world
- Input / UI approaches:
  - tool-based city editing shell with direct map querying and heatmap toggles
  - live economy inspection through supply/demand charts and per-tile query windows
- Performance or optimization ideas:
  - `RTree` spatial lookup plus memoized location cache
  - path-derived traffic rather than heavier agent simulation

## Notable Implementations

- `CityMap` as a layered world model with terrain, buildings, zoning, traffic, pollution, crime, power, districts, and desirability.
- `ContactFulfiller`, `ResourceFinder`, and `Shipper` as a route-aware contract economy.
- `Pathfinder` with road-first access, one-way road support, rail/station transitions, and traffic-aware heuristic scoring.
- `Constructor`, `DesirabilityUpdater`, and `Upgrader` as the city-growth loop.
- `PowerCoverageUpdater` and `PowerCoverageAutomata` as a simple utility-network propagation model.
- `CityFileAdapter` as GZIP-compressed JSON persistence with rebuild of transient power/path state on load.

## Android Relevance

- Native Android use:
  - none verified; the inspected revision is desktop JavaFX-only
- Kotlin relevance:
  - high, because the simulation, contracts, pathfinding, persistence, and growth logic are Kotlin-first
- Porting or adaptation notes:
  - strongest reuse value is in simulation and data-model design, not in UI/runtime code
  - the route-aware economy, layered city state, and save/load structure can be ported to Android regardless of rendering stack

## Risks / Limitations

- Low maintenance activity in the inspected revision.
- Desktop JavaFX/TornadoFX orientation with no direct Android target.
- Build requires Java `11+` and still depends on `jcenter()`.
- Pre-alpha status and some rough concurrency/implementation edges.

## Notes

This repository is accepted as a `gameplay-systems` reference rather than an `android-game` or engine baseline. It is especially useful when the lab wants to study how Kotlin can structure city-simulator state, path-aware logistics, zoning growth, and debug-friendly management-game UI in one stack.
