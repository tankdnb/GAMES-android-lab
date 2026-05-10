# Project Entry

## Basic Info

- Project name: `Terrarum`
- Source repository: [https://github.com/curioustorvald/Terrarum](https://github.com/curioustorvald/Terrarum)
- Author / organization: `curioustorvald`
- License: `GPL-3.0-or-later`
- Research note: [research/findings/curioustorvald-terrarum.md](../../research/findings/curioustorvald-terrarum.md)
- Investigated commit: `b547914865615ef104b3e3af16ab9fe6880a714d`
- Last verified: `2026-05-10`
- Activity / maintenance status: last push recorded at selection on `2026-04-27`.

## Short Description

Custom libGDX-based Kotlin engine plus side-scrolling tilemap game that combines modular content loading, staged procedural world generation, CPU-side tiled lighting, dynamic weather, and layered 2D rendering.

## Technical Profile

- Primary category: `engine-framework`
- Focus tags: `2d`, `libgdx`, `audio`, `procedural-generation`, `asset-pipeline`, `performance`
- Engine / framework: custom modular libGDX engine with the game living in the same repository
- Rendering approach: multi-pass 2D rendering with Float16 framebuffers, RGB+UV lightmaps, blurred shadow layers, glow/emissive composition, and shader-driven sky/weather
- Main language(s): Kotlin, Java
- Android target: no direct Android target found on the inspected revision
- Build system: IntelliJ IDEA module workspace plus packaging scripts in `buildapp/`

## Why It Matters

- It is a strong reference for how a Kotlin/libGDX project can expose engine ideas inside a shipped game codebase instead of hiding them behind a minimal demo.
- The most valuable parts for the lab are the modular content pipeline, localized world simulation, staged worldgen, and explicit lighting/weather pipeline rather than turnkey Android packaging.

## Reusable Ideas

- Gameplay ideas:
  - staged terrain, cave, aquifer, ore, biome, and tree generation with later spawn-area postprocessing
- Architecture patterns:
  - background module loading with explicit GL-thread object creation, PRTree-backed spatial queries, and fixed-step update governance
- Graphics / rendering techniques:
  - RGB+UV tiled light propagation, layered Float16 FBO composition, weather-driven sky coloring, and skeletal sprite assembly
- Input / UI approaches:
  - zoom-aware wrapped world camera and module-defined IME/key-layout pipeline
- Performance or optimization ideas:
  - region-based world simulation, throttled light recalculation, and deduplicated fluid-region processing

## Notable Implementations

- `CommonResourcePool` coordinates GL-thread-safe resource loading and slow one-per-frame loading.
- `ModMgr` loads metadata, dependencies, jars, retextures, locales, IMEs, fluids, weather, crafting, and other module content through one manager.
- `IngameRenderer`, `LightmapRenderer`, and `WeatherMixer` form a substantial 2D render-and-atmosphere pipeline.
- `WorldSimulator` localizes fluids, wires, fallables, and environmental updates around active regions.
- `Worldgen` and `worldgenerator/*` keep generation staged and versioned.

## Android Relevance

- Native Android use:
  - none verified on the inspected revision
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - best reused as an engine-architecture and subsystem reference for Kotlin/libGDX Android work rather than as a direct mobile runtime

## Risks / Limitations

- Strong copyleft license.
- No verified Android launcher or mobile packaging path.
- Nonstandard build surface compared with a normal Gradle Android repository.
- Engine and game code are interwoven, which raises extraction cost.

## Notes

This repository is especially useful when the lab wants ideas for how game content modules, light/weather systems, world simulation, and procedural generation can coexist in one Kotlin/libGDX workspace.
