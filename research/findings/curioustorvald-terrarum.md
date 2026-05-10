# Research Note

## Repository Snapshot

- Repository: `curioustorvald/Terrarum`
- Source URL: [https://github.com/curioustorvald/Terrarum](https://github.com/curioustorvald/Terrarum)
- Owner: `curioustorvald`
- Batch ID: [`BATCH-2026-05-10-G`](../batches/BATCH-2026-05-10-G.md)
- Type: `engine-framework`
- License: `GPL-3.0-or-later` (`COPYING.md`; GitHub metadata reports `Other`)
- Selection date: `2026-05-10`
- Last pushed at selection: `2026-04-27`
- Stars at selection: `15`
- Investigated commit: `b547914865615ef104b3e3af16ab9fe6880a714d`
- Research status: `accepted`
- Build mode: `static-review-only + intellij-workspace + makefile-packaging-surface`
- Catalog card: [catalog/projects/curioustorvald-terrarum.md](../../catalog/projects/curioustorvald-terrarum.md)

## Why This Repository Was Selected

- It was fresher than backlog candidate `Hugobros3/chunkstories` and looked more directly reusable for Android-adjacent game work because it is a 2D libGDX tilemap stack rather than a more desktop-leaning voxel engine.
- Despite the low star count, the repository exposed several strong subsystem surfaces that are worth mining for ideas: modular content loading, tiled lighting, world simulation, weather, skeletal sprites, and staged procedural generation.
- It is a good example of an engine-plus-game repository where the engine patterns are still visible inside the product code instead of being buried behind a monolithic application shell.

## Technical Profile

- Main language(s): Kotlin, Java
- Engine / framework: custom modular libGDX-based engine plus the game that runs on top of it
- Rendering stack: libGDX plus a custom multi-pass 2D pipeline with Float16 framebuffers, RGB+UV tiled light propagation, weather shaders, blur, glow, and layered shadows
- Android target: no Android module, Gradle Android target, or mobile launcher was found on the inspected revision; Android transfer value is architectural through Kotlin and libGDX subsystem patterns
- Build system: IntelliJ IDEA workspace with checked-in `*.iml` modules and packaging scripts under `buildapp/`; no root Gradle or Maven build was found
- Repository layout summary: engine-and-game workspace with the main code in `src/`, packaging helpers in `buildapp/`, optional side modules in `ModuleComputers/` and `MusicPlayer/`, and bundled assets/docs in the same repository
- Source footprint:
  - `src/`: `684` Kotlin/Java files
  - `ModuleComputers/src/`: `16`
  - `MusicPlayer/src/`: `2`
- Key modules reviewed:
  - `src/net/torvald/terrarum/App.java`
  - `src/net/torvald/terrarum/CommonResourcePool.kt`
  - `src/net/torvald/terrarum/ModMgr.kt`
  - `src/net/torvald/terrarum/IngameInstance.kt`
  - `src/net/torvald/terrarum/GameUpdateGovernor.kt`
  - `src/net/torvald/terrarum/modulebasegame/IngameRenderer.kt`
  - `src/net/torvald/terrarum/worlddrawer/LightmapRenderer.kt`
  - `src/net/torvald/terrarum/worlddrawer/WorldCamera.kt`
  - `src/net/torvald/terrarum/modulebasegame/WorldSimulator.kt`
  - `src/net/torvald/terrarum/weather/WeatherMixer.kt`
  - `src/net/torvald/terrarum/audio/SpatialAudioMixer.kt`
  - `src/net/torvald/terrarum/modulebasegame/worldgenerator/Worldgen.kt`
  - `src/net/torvald/terrarum/modulebasegame/worldgenerator/Terragen.kt`
  - `src/net/torvald/terrarum/modulebasegame/worldgenerator/Cavegen.kt`
  - `src/net/torvald/terrarum/modulebasegame/worldgenerator/Aquagen.kt`
  - `src/net/torvald/terrarum/modulebasegame/worldgenerator/Oregen.kt`
  - `src/net/torvald/terrarum/modulebasegame/worldgenerator/Biomegen.kt`
  - `src/net/torvald/spriteanimation/AssembledSpriteAnimation.kt`

## Build And Runtime Notes

- The repository was investigated through static code review.
- The inspected root does not expose a normal Gradle wrapper, Maven build, or other standard scripted build entrypoint.
- The checked-in workspace points to IntelliJ IDEA modules such as `Terrarum_renewed.iml`, `TerrarumBuild.iml`, `ModuleComputers/ModuleComputers.iml`, and `MusicPlayer/MusicPlayer.iml`.
- `README.md` explicitly expects `JDK 17 or higher`, `IntelliJ IDEA Community Edition`, and `GraalVM 23.1.10` for JavaScript execution.
- `buildapp/Makefile` exposes packaging-oriented targets such as `linux_x86`, `linux_arm`, `mac`, and `windows`, which confirms a release-script surface even though a reproducible root build script was not found.
- No runtime launch was attempted.
- Known setup limitations:
  - direct Android packaging or Android launcher support was not found
  - the repo is desktop/OpenGL-first in both documentation and rendering assumptions
  - the strong copyleft license reduces direct code reuse compared with the MIT/Apache references already in the lab

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `2`
- Implementation depth: `3`
- Code clarity: `2`
- Novelty: `3`
- Overall verdict: `accepted`
- Why:
  - the repository contains several high-yield subsystems with direct architectural transfer value even without a ready Android target
  - it is especially strong as a reference for content modularity, tiled-light rendering, region-based world simulation, and staged world generation
  - the codebase is uneven and product-specific, but the engine ideas are concrete enough to justify keeping it in the main catalog

## Interesting Findings

### Engine Architecture And Core Loop

- `src/net/torvald/terrarum/App.java` bootstraps shaders, queues early shared resources into `CommonResourcePool`, marks the GL thread explicitly, then launches a background post-init loading thread that runs `Lang` and `ModMgr` before handing control to the active `IngameInstance`.
- `src/net/torvald/terrarum/CommonResourcePool.kt` is a useful pattern for GL-safe resource loading: `runOnGLThread()` blocks background callers on a latch, `loadAll()` batches immediate GL-thread loads, `loadAllSlowly()` moves work into a one-per-frame slow queue, and `update()` drains both dispatch queues every frame.
- `src/net/torvald/terrarum/ModMgr.kt` keeps module loading metadata-driven. It reads `metadata.properties` and `default.json`, checks dependency versions, validates JAR hashes outside development builds, loads entrypoint classes through `URLClassLoader`, and instantiates Java classes on the GL thread through `CommonResourcePool.runOnGLThread`.
- `src/net/torvald/terrarum/GameUpdateGovernor.kt` separates update policy from gameplay logic with both `Anarchy` and `ConsistentUpdateRate`; the latter uses an accumulator to run fixed-step updates while still rendering with frame delta.
- `src/net/torvald/terrarum/IngameInstance.kt` maintains active and inactive actor containers, a `worldUpdaters` set for localized world simulation, a `PRTree<ActorWithBody>` for spatial queries, and rotating save-backup helpers for `.a/.b/.c` style autosave copies.

### Rendering And Graphics

- `src/net/torvald/terrarum/modulebasegame/IngameRenderer.kt` is a layered multi-pass renderer rather than a simple draw-order list. It splits actors into far-behind, behind, middle, mid-top, front, and overlay groups, renders terrain and actor layers into separate Float16 FBOs, then composites RGB, glow, emissive, and blurred shadow outputs with dedicated shaders.
- `IngameRenderer.kt` also throttles lightmap recalculation to every third render frame unless the camera wraps significantly or a new world loads, which is a concrete example of keeping an expensive screen-space simulation on a coarse cadence.
- `src/net/torvald/terrarum/worlddrawer/LightmapRenderer.kt` maintains an overscanned light buffer in an `UnsafeCvecArray`, stores light as full RGB plus a UV-like fourth channel, adjusts its sample window to `WorldCamera.zoomedX/zoomedY`, and propagates light through repeated horizontal, vertical, and diagonal swipe passes with per-tile opacity attenuation.
- `LightmapRenderer.kt` blends neighboring cells in a second pass and writes out a dedicated `lightBuffer`, which shows a very explicit CPU-side light propagation pipeline instead of hiding everything in a fragment shader.
- `src/net/torvald/terrarum/weather/WeatherMixer.kt` computes `globalLightNow` from daylight CLUTs and moonlight, renders a skybox and clouds as a rendering sub-pipeline, and ties cloud coloring to solar altitude, turbidity, and weather blending rather than using a static sky tint.
- `src/net/torvald/terrarum/worlddrawer/WorldCamera.kt` handles wrapped horizontal camera movement, clamped vertical motion, zoom-aware sample rectangles for the lightmap path, and a streamer-layout horizontal offset.
- `src/net/torvald/spriteanimation/AssembledSpriteAnimation.kt` assembles characters from reversed skeleton joints and transform lists, then places held items at named joints such as `HELD_ITEM`, which is a reusable 2D skeletal-sprite pattern for equipment-aware animation.

### Gameplay Systems

- `src/net/torvald/terrarum/modulebasegame/WorldSimulator.kt` runs world simulation around localized update regions rather than globally every tick. It merges overlapping updater regions, deduplicates fluid tiles through a processed mask, and then runs fluids, grass, fallables, wire logic, leaf drops, and dropped-item pickup in separate timed passes.
- `WorldSimulator.kt` includes a graph-oriented wire simulation path. The code resets node and segment signal strengths, propagates decayed signal values through a logical graph, and then writes per-tile emission values back only for compatibility with older code.
- `WorldSimulator.kt` also documents the fluid model clearly enough to reuse: copy world fluid map, simulate compression/flow, then copy results back, with explicit constants such as `FLUID_MAX_MASS`, `FLUID_MAX_COMP`, and `minFlow`.
- `src/net/torvald/terrarum/modulebasegame/worldgenerator/Worldgen.kt` breaks generation into named jobs for terrain, caves, underground fluids, ores, ore autotiling, biomes, and trees, then performs a later spawn-point search and generates the nearby chunk strip around the final player spawn.
- `Worldgen.kt` and `Terragen.kt` keep versioned world-generation parameters so older and newer worldgen layouts can coexist through `WorldgenParamsAlpha1` and `WorldgenParamsAlpha2`.
- `Terragen.kt`, `Cavegen.kt`, `Aquagen.kt`, `Oregen.kt`, and `Biomegen.kt` each focus on one generation layer: strata and terrain tiers, cave carving with attenuation and blockage control, underground water/oil/lava pockets, ore veins shaped by cave attenuation, and biome painting that transforms exposed terrain into woodland/plains/rocky/gravel/sandy surface zones.

### Audio, Weather, And Atmosphere

- `src/net/torvald/terrarum/audio/SpatialAudioMixer.kt` does not just expose left-right panning. It hardcodes matrix presets for stereo, quadraphonic, 4.1, 5.1, 6.1, 7.1, and a custom `5.1.2` layout, while documenting intended speaker roles such as UI in the center and weather/ambient in rear or side channels.
- `App.java` runs a dedicated high-priority `TerrarumAudioManager` thread and supports live `reloadAudioProcessor()` replacement while copying track state into the renewed mixer, which is a useful reference for hot-swapping audio backends without losing playback context.
- `WeatherMixer.kt` couples world weather state, wind vectors, cloud spawning/despawning, and sky/global-light evaluation tightly enough that the weather system reads like a runtime atmosphere subsystem rather than only a visual overlay.

### Tooling, Modding, And Content Pipeline

- `src/net/torvald/terrarum/ModMgr.kt` exposes loaders for blocks, ores, items, languages, IME/key layouts, materials, fluids, audio, weather, retextures, crafting recipes, GUI extensions, watchdogs, and canisters. That breadth makes it a strong reference for a metadata-first content pipeline.
- `ModMgr.kt` loads retextures by redirecting alternate file paths for specific asset categories, which is a compact way to support texture overrides without rewriting the whole asset loader.
- `ModMgr.kt` also treats keyboard layout and IME data as module content. The `GameIMELoader` registers both low-layer key layouts and higher-level IME definitions from module files, then loads per-language icon sheets.
- `CommonResourcePool.kt` plus `App.java` show a practical split between background discovery/initialization and GL-thread resource realization, which is especially relevant when mod content wants to create textures or other GPU-bound objects safely.

## Reusable Takeaways

- If a Kotlin/libGDX codebase needs mods, background loading, and GPU resources, explicit GL-thread marshaling can stay simple and auditable if it is centralized in one shared resource pool.
- Region-based world simulation around active actors is a strong alternative to full-world ticking when fluids, wiring, and environmental systems are too expensive to update globally.
- CPU-side tiled lighting can remain extensible if light transport, tile opacity, and buffer writeout are separated into explicit phases instead of compressed into one monolithic render pass.
- Versioned worldgen parameters plus staged generation jobs are a practical way to evolve procedural content without pretending that one parameter set will fit all save versions forever.

## Evidence Summary

- `src/net/torvald/terrarum/App.java` - bootstrap, GL-thread registration, post-init loading thread, audio manager lifecycle
- `src/net/torvald/terrarum/CommonResourcePool.kt` - GL-thread dispatch, batched loading, slow loading queue
- `src/net/torvald/terrarum/ModMgr.kt` - metadata-driven modules, dependency checks, JAR loading, loaders for content categories
- `src/net/torvald/terrarum/IngameInstance.kt` - actor containers, `worldUpdaters`, PRTree queries, save backups
- `src/net/torvald/terrarum/GameUpdateGovernor.kt` - fixed-step update governor
- `src/net/torvald/terrarum/modulebasegame/IngameRenderer.kt` - FBO-heavy layered renderer, light cadence, weather integration
- `src/net/torvald/terrarum/worlddrawer/LightmapRenderer.kt` - RGB+UV tile light propagation, overscan buffers, multi-pass swipes
- `src/net/torvald/terrarum/worlddrawer/WorldCamera.kt` - wraparound camera, zoom-aware sample window
- `src/net/torvald/terrarum/modulebasegame/WorldSimulator.kt` - localized simulation regions, fluids, wires, fallables, dropped-item pickup
- `src/net/torvald/terrarum/weather/WeatherMixer.kt` - skybox/cloud rendering, wind, global-light evaluation
- `src/net/torvald/terrarum/audio/SpatialAudioMixer.kt` - surround-mix presets and panning-law helpers
- `src/net/torvald/terrarum/modulebasegame/worldgenerator/Worldgen.kt` and `worldgenerator/*` - staged threaded world generation with versioned parameters
- `src/net/torvald/spriteanimation/AssembledSpriteAnimation.kt` - 2D skeletal assembly and held-item joint placement

## Risks Or Limits

- `GPL-3.0-or-later` is a strong copyleft license, so direct code reuse is more constrained than many of the lab's other references.
- No Android launcher or Android build path was found on the inspected revision.
- The workspace is harder to reproduce than a standard Gradle repository because it assumes IntelliJ modules, JDK 17+, and GraalVM-specific setup.
- The repository mixes engine and game concerns heavily, so extracting isolated patterns often requires more judgment than in cleaner framework-only repos.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `engine-framework`
- Focus tags: `2d`, `libgdx`, `audio`, `procedural-generation`, `asset-pipeline`, `performance`
- Follow-up needed:
  - if the lab revisits this repository later, focus on one subsystem such as the module ecosystem, world generator evolution, or the light/weather pipeline rather than reopening the entire workspace blindly
