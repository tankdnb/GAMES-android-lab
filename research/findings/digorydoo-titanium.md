# Findings: `digorydoo/titanium`

## Snapshot

- Repository: `https://github.com/digorydoo/titanium`
- Investigated commit: `ef2202d17a61a261ab68c7dce4b00e9fd5448783`
- License: `GPL-3.0`
- Repository type: `engine-framework`
- Primary language: `Kotlin`
- Build mode: `static-review + gradle-version + gradle-help-failed-java8-needs-java17`
- Research date: `2026-06-15`

## What It Is

`titanium` is a substantial Kotlin/JVM 3D engine-and-game workspace built around a strict module split: pure engine core, pure game layer, LWJGL host/runtime shell, and separate asset-import tools. The checked-in tree targets desktop JVM today, but it is much closer to a real in-progress engine than to a one-file OpenGL prototype: scene loading, custom collision and rigid-body logic, OpenGL rendering, GLFW input, OpenAL audio, an in-game editor mode, custom mesh or texture importers, and a meaningful low-level test surface are all present.

## Why It Matters

This repository is worth keeping because it shows a strong architectural stance that is reusable even outside its current desktop target:

- engine and game code are intentionally kept free of direct OpenGL dependencies
- the LWJGL host owns platform glue while the engine core owns gameplay/runtime state
- collision and rigid-body handling are implemented in readable Kotlin rather than hidden in external physics middleware
- the asset pipeline is treated as first-class tooling instead of a manual prebuild footnote

It is not a direct Android runtime reference, but it is a strong research source for teams that may eventually want their own Kotlin game-tech stack with sharper boundaries than a monolithic engine app.

## Verified Technical Profile

- Primary category: `engine-framework`
- Focus tags: `3d`, `opengl`, `physics`, `asset-pipeline`, `input`, `testing`
- Engine / framework: custom Kotlin JVM engine over LWJGL, GLFW, OpenGL, and OpenAL
- Rendering approach: desktop OpenGL host in `titanium-main`, pure engine-side render abstractions elsewhere
- Android target: none checked in
- Other targets seen in repo: desktop JVM only
- Build system: Gradle Kotlin DSL

## High-Value Reusable Ideas

### 1. The repository keeps engine, game, and platform host seams unusually explicit

The module split declared in `settings.gradle.kts` and described in `README.md` is not cosmetic:

- `titanium-engine` keeps core runtime code
- `titanium-game` holds concrete game content
- `titanium-main` is the only checked-in runtime host with LWJGL or OpenGL dependencies
- `tool-import-asset` and `tool-collect-intl` keep preprocessing outside the main game shell

That separation is reinforced in code:

- `titanium-engine/.../core/App.kt` exposes one global app container for engine subsystems without dragging platform-specific GL code into the engine layer
- `titanium-main/.../core/AppImpl.kt` wires concrete desktop implementations into that abstract app shell

This is a strong reference for Kotlin teams who want portability or testability through module boundaries rather than through framework magic.

### 2. The main loop is compact, explicit, and host-owned

`titanium-main/src/main/kotlin/io/github/digorydoo/titanium/main/core/Main.kt` is one of the repo's strongest files:

- GLFW window creation, callbacks, and GL capability setup stay in the host layer
- the frame loop is explicit: clear, maintain time, animate content, handle intermissions and lamps, render shadows, render regular scene content, finish frame
- `GameTime.maintain()` centralizes frame pacing, hiccup detection, FPS measurement, and story-time progression

This is useful as a reference for custom Kotlin game hosts that want deterministic ownership over frame lifecycle instead of burying it inside framework callbacks.

### 3. Scene loading is staged instead of treated as one blocking black box

`titanium-engine/.../scene/SceneLoader.kt` is more interesting than a normal hobby-engine loader:

- loading is expressed as explicit stages such as `BEFORE_READ_BRICKS`, `BEFORE_UPDATE_BRICKS`, `BEFORE_LOAD_SKY`, and `BEFORE_LOAD_GEL_LIST`
- progress updates are surfaced to the HUD
- expensive work is coordinated through `App.process.runAsync` and main-thread callbacks
- comments explicitly document which steps still require the main thread because they invoke GL functions

That staged loader plus progress design is directly reusable for Android-adjacent games that need visible long-running content transitions.

### 4. Collision and separation are implemented as real engine subsystems, not quick math helpers

`titanium-engine/.../physics/CollisionManager.kt` and `CollisionHandler.kt` preserve several reusable patterns:

- collision work is split into primary and secondary passes
- nearby candidates are tracked through per-gel vicinity caches
- collisions are separated before bounce or gameplay notification
- pathological resolution cases are guarded with retry ceilings, relative-push aborts, and recovery paths such as zombieing crashing gels
- brick collisions are handled through the same manager, with temporary rigid bodies derived from brick coordinates

This is more mature than many small Kotlin engines and is useful as a design reference even if the exact math is desktop-first.

### 5. The repository treats content tooling as part of the engine, not an afterthought

`tool-import-asset` and the shell scripts around it give the repo unusual value:

- `tool-import-asset/.../Main.kt` cleanly routes between Collada and brick-texture import modes
- the Collada reader stack under `tool-import-asset/.../collada/` preserves a real checked-in conversion pipeline
- root `build.gradle.kts` wires generated sources and generated resources into the game build
- `README.md` and `make-proper.sh` describe the generation flow for meshes and texture atlases

For the lab, this is a strong example of how asset preprocessing can live as a normal Kotlin toolchain instead of as a hidden binary or manual external step.

## Other Useful Implementations

- `titanium-engine/.../scene/ActiveSceneContent.kt` shows a layered runtime split between collidable, non-collidable, menu, UI, and stellar-object layers while keeping lighting adaptation and spawn processing centralized.
- `titanium-engine/.../input/InputAccessor.kt` shows a practical unification layer where keyboard and gamepad actions are exposed through common accessors and synthesized joystick vectors.
- `titanium-main/.../input/InputManagerImpl.kt` cleanly flips control mode back to keyboard as soon as GLFW key or char events arrive.
- `docs/physics.txt` is a durable advantage: the repo checks in the math notes behind collision behavior instead of keeping them implicit.

## Testing Surface

The repository has a real low-level test surface.

Verified examples include:

- `RigidBodyTest.kt`
- `CollideSphereVsSphereTest.kt`
- `CollideSphereVsCuboidTest.kt`
- `CollideCylinderVsCylinderTest.kt`
- `ShaderPrecompilerTest.kt`
- multiple brick/material or localization tests

Visible checked-in engine test count is about `23` Kotlin test files in `titanium-engine/src/test/kotlin`.

This is meaningful for a hobby-scale engine workspace, especially because tests cover geometry, collision, and shader-preprocessor behavior rather than only trivial smoke paths.

## Android Relevance

### Direct relevance

Low.

No Android module, Android source set, or mobile host shell was visible in the inspected revision.

### Indirect relevance

High enough to keep.

Reasons:

- Kotlin-first engine and tooling code
- strong separation between runtime core and host glue
- reusable staged loader, input abstraction, and collision-management ideas
- useful counterpoint to Compose-first and LibGDX-first Android references already in the lab

## Build And Environment Notes

Verified locally:

- `gradlew.bat --version` succeeded and reported Gradle `9.0.0`
- `gradlew.bat help --no-daemon -Pflavour=development` failed because Gradle requires Java `17+`, while the lab machine currently exposes Java `8`
- `gradle/libs.versions.toml` declares target JDK `17`

Additional checked-in reproducibility caveats:

- `README.md` requires external game assets that are not stored in the repo
- Windows setup expects Cygwin for shell-based build steps
- the checked-in workflow still depends on a sibling checkout of `kutils` during normal setup

Interpretation:

- the repository is real and actively maintained
- the local failure is primarily a lab-JVM mismatch
- full local runtime validation would still require both a newer JDK and the out-of-repo asset setup

## Risks And Limits

- desktop-only in the inspected revision
- checked-in setup is not self-contained because assets and sibling `kutils` sources are expected outside the repo
- shell-script-heavy workflow increases Windows friction even though `gradlew.bat` exists
- GPL-3.0 makes it more suitable as an ideas/reference source than as a casual copy-paste base

## Catalog Verdict

`accepted`

The repository is worth keeping because it preserves a real Kotlin engine architecture with explicit module seams, a host-owned main loop, staged scene loading, readable collision and rigid-body subsystems, and first-class asset-import tooling. Its Android value is indirect, but the architecture depth is strong enough to justify inclusion in the main catalog.
