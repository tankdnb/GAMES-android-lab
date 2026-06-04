# Project Entry

## Basic Info

- Project name: `PltCmd`
- Source repository: [https://github.com/Baret/pltcmd](https://github.com/Baret/pltcmd)
- Author / organization: `Baret`
- License: `MIT`
- Research note: [research/findings/baret-pltcmd.md](../../research/findings/baret-pltcmd.md)
- Investigated commit: `ee6d26b375b3f6929f2d1fdc9616efcdd2506fde`
- Last verified: `2026-06-04`
- Activity / maintenance status: fresh and still moving; the latest inspected commit is `Update kotlin monorepo to v2.4.0 (#374)` from `2026-06-03`, and the checked-in CI workflow still builds the Maven monorepo on JDK `21`.

## Short Description

Kotlin/JVM tactical command game where orders travel over a simulated radio net across a generated world, with terrain-aware radio and vision propagation, structured military-unit blueprints, and a Swing/Zircon tile UI shell.

## Technical Profile

- Primary category: `gameplay-systems`
- Focus tags: `2d`, `input`, `ui-hud`, `procedural-generation`, `save-load`, `testing`
- Engine / framework: custom tactical simulation stack built from Hexworks Amethyst entity systems, Zircon Swing UI, Cobalt databinding, and coroutine-backed communications
- Rendering approach: terminal/tile presentation through Zircon and Swing, with a map view, radio log, command sidebar, and info sidebar rather than a sprite-scene renderer
- Main language(s): Kotlin
- Android target: none in the checked-in build or runtime; best treated as an indirect reference for tactics, control, and simulation architecture
- Build system: Maven multi-module monorepo with Kotlin Maven plugin, Surefire, Enforcer, and JDK `21` CI

## Why It Matters

- `PltCmd` is unusually valuable because communication constraints are not a side effect of the game. They are the interface.
- For Android game work, that makes it a strong reference for tactics/strategy prototypes that want player intent, unit behavior, visibility, and map scale to stay decoupled from the surface UI.

## Reusable Ideas

- Gameplay ideas:
  - radio-only order issuing, terrain-limited communication, line-of-sight detection, and structured platoon/squad composition
- Architecture patterns:
  - `util` / `model` / `game` monorepo split, tick-published simulation ownership, and queued conversations instead of direct command mutation
- Graphics / rendering techniques:
  - the main value is not rendering technology, but the map/log/sidebar shell is a clean reference for tactics-oriented UI composition
- Input / UI approaches:
  - select a unit by callsign, click a destination on the map, and translate that into a domain conversation rather than directly moving the unit
- Performance or optimization ideas:
  - explicit tick pacing, typed entity filtering, and deterministic map-generation stages instead of update logic hidden in view code

## Notable Implementations

- `Ticker.kt` publishes simulated time, days, pause state, and ticks from one scheduler.
- `Game.kt` bridges the tick bus into one Amethyst engine update per tick while guarding against overlap.
- `RadioCommunicator.kt` and `TransmissionDecoding.kt` turn radio phrases into a gameplay protocol with queueing, replies, and missed-response handling.
- `RadioSignalPropagator.kt` and `VisionPropagator.kt` model communication and visibility as terrain-aware signal loss problems.
- `Elements.kt` defines reusable military blueprints for units, squads, platoons, and corps variants.
- `WorldMapGenerator.kt` uses staged intermediate generators for terrain building.
- `MapStorage.kt` and `WorldMapDao` provide a typed persistence seam for generated maps.

## Android Relevance

- Native Android use:
  - no checked-in Android target
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - strongest as a reference for tactics rules, radio/visibility simulation, map generation, and control decomposition; weakest as a direct runtime or UI shell for Android delivery

## Risks / Limitations

- No Android module or mobile host shell is included.
- The UI/runtime shell is desktop Swing/Zircon-specific.
- Local Maven validation could not be reproduced in the lab because the repository ships no wrapper and `mvn` is not installed in the current environment.
- Some behavior paths are still visibly incomplete, including `GoFirm`, FOB-specific order execution, and parts of knowledge learning around overheard transmissions.
- The text-decoding approach is intentionally prototype-like and depends on fixed message templates.

## Notes

`PltCmd` is worth keeping in the main catalog because the radio-command model, signal propagation, unit blueprinting, and modular sim split are unusual and portable ideas. It is not a direct Android sample, but it is exactly the kind of tactics/simulation reference that can sharpen future Kotlin Android strategy work.
