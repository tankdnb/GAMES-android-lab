# Research Note

## Repository Snapshot

- Repository: `minigdx/tiny`
- Source URL: [https://github.com/minigdx/tiny](https://github.com/minigdx/tiny)
- Owner: `minigdx`
- Batch ID: [`BATCH-2026-05-10-F`](../batches/BATCH-2026-05-10-F.md)
- Type: `engine-framework`
- License: `MIT`
- Selection date: `2026-05-10`
- Last pushed at selection: `2026-03-29`
- Stars at selection: `155`
- Investigated commit: `4d40cb5aa3ae8e53f90d3823dd812965090455f9`
- Research status: `accepted`
- Build mode: `static-review + gradle-help-failed-no-jdk`
- Catalog card: [catalog/projects/minigdx-tiny.md](../../catalog/projects/minigdx-tiny.md)

## Why This Repository Was Selected

- It was the freshest backlog candidate among the stronger Kotlin game-engine repositories verified directly through `gh repo view`.
- Even without a direct Android target, it combines a compact KMP runtime with hot reload, a browser editor, a desktop debug server, export tooling, and generated script docs, which is a strong research surface for this lab.
- It is a good counterweight to larger engine references because it shows how much workflow infrastructure can stay small and cohesive inside one repository.

## Technical Profile

- Main language(s): Kotlin, Lua
- Engine / framework: Tiny Game Engine
- Rendering stack: custom 2D palette-index renderer over KGL, using LWJGL/OpenGL on JVM and browser WebGL on JS
- Android target: no direct Android target or Android module was found in the inspected repository; transfer value is architectural through Kotlin Multiplatform runtime boundaries, input/resource abstractions, and tooling patterns
- Build system: Gradle Kotlin DSL monorepo
- Repository layout summary: multiplatform engine monorepo with `tiny-engine`, `tiny-cli`, `tiny-debugger`, `tiny-web-editor`, `tiny-doc`, several annotation processors, and a small set of sample games
- Key modules reviewed:
  - `tiny-engine/src/commonMain/kotlin/com/github/minigdx/tiny/engine/GameEngine.kt`
  - `tiny-engine/src/commonMain/kotlin/com/github/minigdx/tiny/engine/GameResourceProcessor.kt`
  - `tiny-engine/src/commonMain/kotlin/com/github/minigdx/tiny/engine/GameResourceCollector.kt`
  - `tiny-engine/src/commonMain/kotlin/com/github/minigdx/tiny/resources/GameScript.kt`
  - `tiny-engine/src/commonMain/kotlin/com/github/minigdx/tiny/render/DefaultVirtualFrameBuffer.kt`
  - `tiny-engine/src/commonMain/kotlin/com/github/minigdx/tiny/lua/MapLib.kt`
  - `tiny-engine/src/commonMain/kotlin/com/github/minigdx/tiny/lua/SprLib.kt`
  - `tiny-engine/src/commonMain/kotlin/com/github/minigdx/tiny/lua/FloppyLib.kt`
  - `tiny-engine/src/commonMain/kotlin/com/github/minigdx/tiny/sound/SoundManager.kt`
  - `tiny-engine/src/commonMain/kotlin/com/github/minigdx/tiny/sound/MusicGenerator.kt`
  - `tiny-engine/src/jvmMain/kotlin/com/github/minigdx/tiny/platform/glfw/GlfwPlatform.kt`
  - `tiny-engine/src/jvmMain/kotlin/com/github/minigdx/tiny/platform/glfw/LwjglInput.kt`
  - `tiny-web-editor/src/jsMain/kotlin/Main.kt`
  - `tiny-cli/src/main/kotlin/com/github/minigdx/tiny/cli/command/RunCommand.kt`
  - `tiny-cli/src/main/kotlin/com/github/minigdx/tiny/cli/command/ExportCommand.kt`
  - `tiny-engine/build.gradle.kts`

## Build And Runtime Notes

- The repository was primarily investigated through static code review.
- A lightweight Gradle discovery pass was attempted with `.\gradlew.bat help --no-daemon`.
- The wrapper bootstrapped Gradle successfully, but the command failed during configuration because the local environment exposed only a Java runtime without a Java compiler or full JDK.
- `java -version` reported `1.8.0_321` during the check, which confirms that local build validation remains limited in this environment.
- Known setup limitations:
  - no direct Android target or Android export path was documented in the inspected codebase
  - game logic is Lua-first, so reuse is strongest for engine/tooling ideas rather than Kotlin gameplay code directly

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `2`
- Implementation depth: `3`
- Code clarity: `3`
- Novelty: `3`
- Overall verdict: `accepted`
- Why:
  - the repository contains a coherent runtime plus a full developer loop around it: config, hot reload, debugger, browser editor, export, and docs generation
  - several patterns transfer well into Android-oriented Kotlin game work even though the shipped targets are desktop and web
  - it is especially strong as a reference for lightweight iteration workflows and scripting-host architecture

## Interesting Findings

### Engine Architecture And Core Loop

- `tiny-engine/src/commonMain/kotlin/com/github/minigdx/tiny/engine/GameEngine.kt` runs a fixed-step `1/60f` update loop with an accumulator, processes resource events before simulation, preserves script state across reloads, and exposes useful built-in iteration shortcuts such as screenshot, GIF recording, and profiler toggling.
- `tiny-engine/src/commonMain/kotlin/com/github/minigdx/tiny/engine/GameResourceCollector.kt` and `GameResourceProcessor.kt` enforce a mandatory boot order for `_boot.lua` and `_engine.lua`, then stream the rest of the resources concurrently, which is a compact pattern for keeping hot-reloadable content deterministic.
- `tiny-engine/src/commonMain/kotlin/com/github/minigdx/tiny/resources/GameScript.kt` builds an isolated Lua environment per script, validates reloads without live audio side effects, supports `_getState` and `_setState`, and switches scripts through an explicit `Exit` signal instead of letting script transitions leak through global state.
- `tiny-engine/src/commonMain/kotlin/com/github/minigdx/tiny/lua/TinyLib.kt` makes frame, time, platform, and script switching available to Lua in one small built-in runtime API rather than burying those hooks inside several unrelated systems.

### Rendering And Graphics

- `tiny-engine/src/commonMain/kotlin/com/github/minigdx/tiny/render/DefaultVirtualFrameBuffer.kt` uses an offscreen palette-index framebuffer, texture/primitive batch managers, explicit stencil drawing modes, camera-and-clip intersection culling, and cached frame readback for screenshots or GIF recording.
- `tiny-engine/src/commonMain/kotlin/com/github/minigdx/tiny/lua/SprLib.kt` allows in-place spritesheet mutation through `pset`, then rebinds the changed spritesheet into the renderer, which is a good reference for tiny-tooling and pixel-art workflows where assets can be edited live.
- `tiny-engine/src/commonMain/kotlin/com/github/minigdx/tiny/engine/GameOptions.kt` keeps virtual resolution, zoom, gutter, and pointer projection in one runtime contract, which is reusable whenever Android and desktop need to agree on the same logical playfield.

### Gameplay Systems

- `tiny-engine/src/commonMain/kotlin/com/github/minigdx/tiny/lua/MapLib.kt` exposes LDtk levels, layers, tile flags, entities, and custom fields directly to Lua, with cached entity tables invalidated by world version or level changes instead of rebuilding everything every frame.
- `MapLib.kt` also lets scripts toggle layer visibility and convert between screen coordinates and map cells, which makes the LDtk bridge more than a passive loader.
- `tiny-engine/src/commonMain/kotlin/com/github/minigdx/tiny/resources/GameScript.kt` plus `TinyLib.kt` form a lightweight scene-flow model where boot scripts can transition into numbered or named game scripts while optionally carrying over state.

### Input And Controls

- `tiny-engine/src/jvmMain/kotlin/com/github/minigdx/tiny/platform/glfw/LwjglInput.kt` maps GLFW keyboard and mouse events into the engine's virtual touch/key model, resets stuck state on focus loss, and supports remote key injection for debugger-driven control.
- `tiny-engine/src/commonMain/kotlin/com/github/minigdx/tiny/input/TouchManager.kt` keeps touch and key events queued until the game loop consumes them, tracks `just pressed` and held state separately, and reuses pooled event objects to reduce per-frame churn.
- `GameOptions.kt` projects physical coordinates into virtual screen coordinates using zoom and gutters, which is directly relevant to Android game layouts that need consistent logical input zones across devices.

### UI, HUD, And Menus

- `tiny-web-editor/src/jsMain/kotlin/Main.kt` builds a browser editor and live preview around the same `GameEngine`, injecting code from DOM-backed streams and producing shareable Base64 URLs, which is a strong pattern for keeping documentation examples, prototypes, and the runtime in sync.
- The same web editor wraps the runtime with a thin `EditorWebGlPlatform` rather than a separate sandbox engine, showing how tooling surfaces can stay honest by reusing the same game loop and resource loading path.

### Physics And Collision

- No dedicated physics or collision subsystem was a main focus of this repository; the stronger value is the runtime, scripting host, rendering model, and tooling surface.

### Tooling, Android Integration, Or Other Notable Areas

- `tiny-engine/src/commonMain/kotlin/com/github/minigdx/tiny/file/CommonVirtualFileSystem.kt` polls any `SourceStream` every second, which gives local files, bundled resources, and DOM/editor streams one common hot-reload path without platform-specific watcher code.
- `tiny-cli/src/main/kotlin/com/github/minigdx/tiny/cli/command/RunCommand.kt` starts a debugger web app, a WebSocket file-watch channel, reload notifications, and even remote key-control HTTP endpoints around the desktop runtime, which is unusually complete for a small engine repo.
- `tiny-cli/src/main/kotlin/com/github/minigdx/tiny/cli/command/ExportCommand.kt` packages web and desktop exports with safe path resolution, custom boot scripts, LDtk-linked tilesets, icons, and either `jpackage` bundles or portable launchers.
- `tiny-engine/build.gradle.kts` wires KSP generators for Lua stubs and JSON API output, and the annotation-processor modules make the scripting surface self-documenting instead of relying only on handwritten docs.
- `tiny-engine/src/commonMain/kotlin/com/github/minigdx/tiny/lua/FloppyLib.kt` serializes Lua tables into JSON-backed per-game storage with circular-reference warnings, which is a compact persistence pattern worth reusing in lightweight games or tools.
- `tiny-engine/src/commonMain/kotlin/com/github/minigdx/tiny/sound/SoundManager.kt` and `MusicGenerator.kt` keep procedural music generation, note synthesis, RMS-aware track mixing, and loop-friendly fade behavior inside the engine core instead of requiring an external audio authoring pipeline for everything.

## Reusable Takeaways

- State-preserving script reload using explicit `_getState` and `_setState` hooks is a practical way to keep fast iteration without forcing a full reboot of the current play state.
- A small game engine becomes much more valuable when the web editor, desktop debugger, export pipeline, and docs generation all reuse the same runtime instead of drifting into separate prototypes.
- Palette-index rendering plus cached framebuffer readback is a clean foundation for screenshot, GIF, and low-overhead tooling features in 2D engines.
- JSON-backed table persistence is enough for many small games and internal tools when you make the script-facing save/load API explicit and predictable.

## Evidence Summary

- `tiny-engine/src/commonMain/kotlin/com/github/minigdx/tiny/engine/GameEngine.kt` - fixed-step loop, reload flow, profiler and capture shortcuts
- `tiny-engine/src/commonMain/kotlin/com/github/minigdx/tiny/engine/GameResourceProcessor.kt` - concurrent resource pipeline and script switching
- `tiny-engine/src/commonMain/kotlin/com/github/minigdx/tiny/engine/GameResourceCollector.kt` - deterministic mandatory resource ordering and reload detection
- `tiny-engine/src/commonMain/kotlin/com/github/minigdx/tiny/resources/GameScript.kt` - Lua host, validation, state transfer, and error shaping
- `tiny-engine/src/commonMain/kotlin/com/github/minigdx/tiny/render/DefaultVirtualFrameBuffer.kt` - framebuffer, batching, clipping, stencil modes, cached readback
- `tiny-engine/src/commonMain/kotlin/com/github/minigdx/tiny/lua/MapLib.kt` - LDtk bridge, layer/entity access, cached world views
- `tiny-engine/src/commonMain/kotlin/com/github/minigdx/tiny/lua/SprLib.kt` - sprite drawing and live spritesheet mutation
- `tiny-engine/src/commonMain/kotlin/com/github/minigdx/tiny/lua/FloppyLib.kt` - persistence bridge from Lua tables to JSON storage
- `tiny-engine/src/commonMain/kotlin/com/github/minigdx/tiny/sound/SoundManager.kt` and `MusicGenerator.kt` - built-in synthesis and mixing logic
- `tiny-engine/src/jvmMain/kotlin/com/github/minigdx/tiny/platform/glfw/LwjglInput.kt` and `GlfwPlatform.kt` - desktop platform, input bridge, screenshot/GIF capture, safe file IO
- `tiny-web-editor/src/jsMain/kotlin/Main.kt` - shared runtime inside a browser editor surface
- `tiny-cli/src/main/kotlin/com/github/minigdx/tiny/cli/command/RunCommand.kt` - debug server, file watching, remote controls
- `tiny-cli/src/main/kotlin/com/github/minigdx/tiny/cli/command/ExportCommand.kt` - web/desktop export packaging
- `tiny-engine/build.gradle.kts` - generated Lua stubs and JSON API artifacts

## Risks Or Limits

- The repository does not currently present a direct Android target, so Android transfer is architectural rather than implementation-ready.
- The gameplay layer is Lua-first, which may be less directly reusable for teams that want Kotlin-only game logic.
- Hot reload is polling-based in `CommonVirtualFileSystem`, so edit feedback is simple and portable but not especially low-latency or event-driven.
- Gradle discovery could not progress into a meaningful build because the environment lacked a full JDK.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `engine-framework`
- Focus tags: `2d`, `multiplatform`, `input`, `audio`, `editor-tools`, `asset-pipeline`
- Follow-up needed:
  - if the lab later wants a deeper pass, revisit the debugger protocol or web editor integration as a dedicated tooling study, or check whether the project grows an Android backend in a later revision
