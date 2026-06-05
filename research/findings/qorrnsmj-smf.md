# Research Note

## Repository Snapshot

- Repository: `qorrnsmj/smf`
- Source URL: [https://github.com/qorrnsmj/smf](https://github.com/qorrnsmj/smf)
- Owner: `qorrnsmj`
- Batch ID: [`BATCH-2026-06-05-C`](../batches/BATCH-2026-06-05-C.md)
- Type: `engine-framework`
- License: `MIT`
- Selection date: `2026-06-05`
- Last pushed at selection: `2026-05-31`
- Stars at selection: `0`
- Default branch at selection: `master`
- Investigated commit: `304987dc65c9b284e733e644e2c453cd8abb6975`
- Research status: `reference-only`
- Build mode: `static-review + gradle-version + gradle-help-with-workspace-gradle-home`
- Catalog card: [catalog/projects/qorrnsmj-smf.md](../../catalog/projects/qorrnsmj-smf.md)

## Why This Repository Was Selected

- `qorrnsmj/smf` was the last remaining candidate in the current exact-license short backlog.
- The main question for this pass was whether the repository is a genuinely reusable low-level Kotlin engine reference, or only an experimental tutorial-derived shell.
- The answer is `reference-only`: there is enough real code to preserve, especially in rendering, state flow, audio, and simple physics, but the repository is still too desktop-only, too tutorial-shaped, and too rough in maturity to promote into the main engine baseline.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: custom JVM-only LWJGL / OpenGL engine with a small built-in game layer
- Rendering stack: GLFW + OpenGL 3.3 + LWJGL + custom renderer stack + OpenAL audio
- Android target: none in the checked-in tree; Android relevance is indirect through low-level runtime patterns
- Build system: Gradle `8.8` wrapper + Kotlin JVM `2.0.0` + Shadow plugin
- Repository layout summary:
  - `src/main/kotlin/qorrnsmj/smf/` - engine runtime, rendering, physics, audio, state, task, and gameplay-layer code
  - `src/main/resources/assets/` - models, shaders, fonts, textures, and audio assets
  - `src/main/kotlin/qorrnsmj/test/` - tutorial or demo progression code paths mixed into the main source tree
  - `docs/` - preview images only, with no deeper architecture or build notes
- Source footprint:
  - total files counted in repository: `179`
  - Kotlin/Kotlin DSL/Java files counted in repository: `120`
- Test surface:
  - visible automated test files: `0`
  - the checked-in tree includes demo and manual verification code, but no real `src/test` regression surface was found
- Key modules and files reviewed:
  - `README.md`
  - `build.gradle.kts`
  - `settings.gradle.kts`
  - `gradle/wrapper/gradle-wrapper.properties`
  - `src/main/kotlin/qorrnsmj/smf/SMF.kt`
  - `src/main/kotlin/qorrnsmj/smf/core/Game.kt`
  - `src/main/kotlin/qorrnsmj/smf/core/FixedTimestepGame.kt`
  - `src/main/kotlin/qorrnsmj/smf/window/Window.kt`
  - `src/main/kotlin/qorrnsmj/smf/state/StateMachine.kt`
  - `src/main/kotlin/qorrnsmj/smf/state/custom/InGameState.kt`
  - `src/main/kotlin/qorrnsmj/smf/graphic/Scene.kt`
  - `src/main/kotlin/qorrnsmj/smf/graphic/render/MasterRenderer.kt`
  - `src/main/kotlin/qorrnsmj/smf/physics/PhysicsWorld.kt`
  - `src/main/kotlin/qorrnsmj/smf/physics/collision/CollisionDetection.kt`
  - `src/main/kotlin/qorrnsmj/smf/audio/AudioManager.kt`
  - `src/main/kotlin/qorrnsmj/smf/game/entity/custom/Entity.kt`
  - `src/main/kotlin/qorrnsmj/smf/game/level/LevelManager.kt`
  - `src/main/kotlin/qorrnsmj/smf/game/level/test/TestLevel.kt`
  - `src/main/kotlin/qorrnsmj/smf/game/task/cutscene/Cutscene.kt`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` initially failed because the wrapper tried to lock under the blocked global path:
  - `C:\Users\Username\.gradle\wrapper\dists\...gradle-8.8-bin.zip.lck (Access denied)`
- After redirecting `GRADLE_USER_HOME` into `research/cache/gradle-qorrnsmj-smf`, `cmd /c gradlew.bat --version` succeeded:
  - Gradle `8.8`
  - launcher JVM `1.8.0_321`
- With the same redirected `GRADLE_USER_HOME`, `cmd /c gradlew.bat help --no-daemon` also succeeded.
- That matters because this repository is not currently blocked by a Java-version floor in the lab. The lightweight build surface is at least configurable when Gradle state is kept inside the workspace.
- The checked-in build still looks narrow and desktop-bound:
  - one JVM module
  - hard-coded `natives-windows`
  - Shadow fat-jar packaging
  - no Android or multiplatform host modules

## Usefulness Assessment

- Reuse potential: `2`
- Android transfer: `1`
- Implementation depth: `2`
- Code clarity: `2`
- Novelty: `1`
- Overall verdict: `reference-only`
- Why:
  - `smf` is more than a hollow prototype. It has a working fixed-timestep loop, render-stack ownership, a simple but real physics world, audio pooling, and a lightweight state or level or cutscene layer.
  - It falls short of `accepted` because the repository openly derives from tutorial material, mixes demo validation into the runtime, carries no real automated tests, remains desktop-only, and still shows multiple maturity issues directly in the checked-in code.

## Interesting Findings

### Engine Architecture And Core Loop

- `src/main/kotlin/qorrnsmj/smf/SMF.kt` is a clear single-entry bootstrap:
  - GLFW init
  - `Window` creation
  - renderer creation
  - `StateMachine`
  - `Timer`
  - audio bootstrap
  - asset preloading
  - state transition into gameplay
- `src/main/kotlin/qorrnsmj/smf/core/FixedTimestepGame.kt` shows a readable fixed-step loop with:
  - explicit `TARGET_FPS` and `TARGET_UPS`
  - accumulator-based update stepping
  - interpolated `alpha` render parameter
  - optional manual sync when v-sync is disabled
- `src/main/kotlin/qorrnsmj/smf/state/StateMachine.kt` and `state/custom/InGameState.kt` show a very small but serviceable state model where whole game modes can be started and swapped without pushing engine details into the outer loop.
- `src/main/kotlin/qorrnsmj/smf/game/level/LevelManager.kt` adds another runtime seam above states: levels are staged through `currentLevel` and `nextLevel`, with a separate transition update instead of immediate replacement.

### Rendering And Graphics

- `src/main/kotlin/qorrnsmj/smf/graphic/Scene.kt` is one of the cleaner pieces in the repository:
  - one scene container owns camera, terrain, skybox, lights, entities, effects, and text overlays
  - the shape is small enough to copy into another prototype without dragging the full engine
- `src/main/kotlin/qorrnsmj/smf/graphic/render/MasterRenderer.kt` shows a practical render pipeline split:
  - skybox pass
  - terrain pass
  - entity pass
  - optional post-process pass
  - debug visualization pass
  - text pass
- The renderer also routes offscreen rendering only when post-processing effects are present, which is a useful small-engine optimization pattern.
- The repository has a broad low-level graphics layer around shader programs, FBO or VBO or VAO wrappers, text rendering, and post-processing effects. That gives it more value than a toy sprite-only engine.

### Gameplay Systems

- `src/main/kotlin/qorrnsmj/smf/game/task/cutscene/Cutscene.kt` and related task or sequence classes show a lightweight gameplay sequencing model based on updatable tasks instead of hardcoded scripted branches.
- `src/main/kotlin/qorrnsmj/smf/game/level/test/TestLevel.kt` is useful as evidence in both directions:
  - it demonstrates scene assembly, trigger wiring, debug overlays, cutscene startup, and collision verification inside the same gameplay shell
  - it also shows how much of the repository still behaves like an integrated testbed rather than a clean engine-plus-sample split

### Input And Controls

- `Window.kt` and the key callback setup in `SMF.kt` keep native GLFW bindings at the host edge instead of scattering them through every gameplay class.
- The tutorial or prototype style is still visible because several controls and debug toggles are read directly from GLFW in level code, especially inside `TestLevel.kt`, rather than being normalized through a dedicated input system.

### Physics And Collision

- `src/main/kotlin/qorrnsmj/smf/physics/PhysicsWorld.kt` is a real subsystem, not a placeholder:
  - gravity application
  - semi-implicit Euler integration
  - parent or child transform propagation
  - terrain collision handling
  - entity-vs-entity corrections
  - grounded-state bookkeeping
- `src/main/kotlin/qorrnsmj/smf/physics/collision/CollisionDetection.kt` shows a compact broad-phase plus narrow-phase approach with:
  - collider presence filtering
  - static-static skip
  - parent or child and sibling skip rules
  - AABB broad phase before detailed checks
  - overlap correction plus simple impulse resolution
- This physics stack is still simple, but it is already more reusable than a tutorial that only moves meshes without any collision ownership.

### Audio

- `src/main/kotlin/qorrnsmj/smf/audio/AudioManager.kt` is a worthwhile subsystem for a small engine:
  - explicit initialization guard
  - source pooling
  - dedicated BGM source
  - listener setup
  - active-source reclamation on update
- This is one of the stronger reasons not to dismiss the repository as empty. The author has already moved beyond rendering-only experiments into practical engine service management.

### Build, Release, And Testing

- `build.gradle.kts` and `settings.gradle.kts` show a very compact JVM build with one executable jar target and no module split.
- The repository has no visible automated test tree.
- The checked-in source still includes several quality caveats:
  - tutorial-derived README wording
  - mojibake or encoding issues in comments and README text
  - `.idea` checked in
  - `lwjglx-debug-1.0.0.jar` checked in
  - TODO-heavy runtime comments
- These do not make the code useless, but they lower confidence for promoting it into the main catalog.

## Reusable Takeaways

- For a small engine, a single `Scene` aggregate plus a pass-split `MasterRenderer` can stay readable without requiring a full ECS renderer architecture.
- A fixed-step accumulator loop with interpolated rendering is still a solid baseline for physics-aware Kotlin desktop game prototypes.
- Source pooling for audio is worth doing early, even in a hobby-sized engine, because it keeps sound-effect ownership simple and explicit.
- Collision systems gain a lot from basic relationship filters such as static-static skip and parent or sibling exclusion before broad-phase checks.

## Evidence Summary

- `SMF.kt`, `Game.kt`, `FixedTimestepGame.kt`, `StateMachine.kt`, `LevelManager.kt` - runtime loop, state shell, and staged level transitions
- `Scene.kt` and `MasterRenderer.kt` - compact scene ownership and multi-pass render pipeline
- `PhysicsWorld.kt` and `CollisionDetection.kt` - real though simple physics/collision handling
- `AudioManager.kt` - pooled audio service management
- `TestLevel.kt` - integrated gameplay plus debug testbed that both proves subsystem depth and reveals tutorial/prototype shaping

## Risks Or Limits

- No Android target exists in the checked-in tree.
- The README explicitly frames the project as under development and inspired by ThinMatrix tutorials.
- The source tree mixes engine code, gameplay code, and validation/demo code in ways that reduce architectural cleanliness.
- No real automated tests were found.
- Repository hygiene is rough:
  - checked-in `.idea`
  - checked-in debug jar
  - encoding issues in comments and README
- The build is functional for lightweight discovery, but it is still only a desktop JVM fat-jar workflow with Windows-native assumptions.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `reference-only`
- Focus tags: `3d`, `opengl`, `collision`, `audio`
- Follow-up needed:
  - if the lab revisits this repository, keep it narrow: isolate the fixed-step loop, the scene-plus-render-pass split, the audio source pool, or the simple collision ownership rules instead of reopening it as a broad Android-engine baseline
