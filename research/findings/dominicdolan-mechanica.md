# Research Note

## Repository Snapshot

- Repository: `DominicDolan/Mechanica`
- Source URL: [https://github.com/DominicDolan/Mechanica](https://github.com/DominicDolan/Mechanica)
- Owner: `DominicDolan`
- Batch ID: [`BATCH-2026-06-12-C`](../batches/BATCH-2026-06-12-C.md)
- Type: `engine-framework`
- License: `MIT`
- Selection date: `2026-06-12`
- Last pushed at selection: `2026-02-26`
- Stars at selection: `0`
- Default branch at selection: `develop`
- Investigated commit: `8918e04435a79da975d06c88989a842516ea4a04`
- Research status: `accepted`
- Build mode: `static-review + gradle-version + gradle-help-failed-missing-lwjgl_natives-property`
- Catalog card: [catalog/projects/dominicdolan-mechanica.md](../../catalog/projects/dominicdolan-mechanica.md)

## Why This Repository Was Selected

- `DominicDolan/Mechanica` was the strongest remaining engine candidate in the compact exact-license shortlist.
- The main question for this pass was whether the repository was a real reusable small-engine architecture reference or only another thin LWJGL experiment.
- The answer is `accepted`: it is still rough and desktop-first, but the checked-in code shows a real multi-module 2D engine with scene management, fixed-step update strategy, shader-backed rendering helpers, UI integration seams, and a visible automated test surface.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: custom Kotlin JVM 2D engine over LWJGL/GLFW/OpenGL with supporting UI and shader modules
- Rendering stack: LWJGL `3.3.4`, GLFW window host, OpenGL-based drawer/shader pipeline, custom shader and UI helper modules
- Android target: none in the checked-in tree
- Build system: Gradle Kotlin DSL multi-module build with Kotlin JVM `2.2.0`, Java toolchain `22`, local `Kotlin-CAVE-jvm-0.2.jar`, and required external Gradle properties for platform-specific LWJGL natives
- Repository layout summary:
  - `mechanica/` - core engine runtime, scenes, draw stack, input, and game configuration
  - `desktop-application/` - GLFW/LWJGL host window and desktop runtime shell
  - `mechanica-shaders/` - shader helpers and rendering abstractions
  - `mechanica-ui/` - UI bridge/helpers around the engine draw layer
  - `common/` and `application-interface/` - shared contracts and low-level support
  - `samples/` - small runnable engine demos
- Source footprint:
  - total files counted in repository: `379`
  - Kotlin/Java files counted in repository: `339`
- Test surface:
  - visible automated test files: real unit tests exist under `mechanica/src/test/kotlin`
- Key modules and files reviewed:
  - `README.md`
  - `settings.gradle.kts`
  - `build.gradle.kts`
  - `mechanica/build.gradle.kts`
  - `desktop-application/build.gradle.kts`
  - `samples/build.gradle.kts`
  - `mechanica/src/main/kotlin/com/mechanica/engine/game/configuration/GameSetup.kt`
  - `mechanica/src/main/kotlin/com/mechanica/engine/game/delta/MultiUpdateCalculator.kt`
  - `mechanica/src/main/kotlin/com/mechanica/engine/scenes/SceneManager.kt`
  - `mechanica/src/main/kotlin/com/mechanica/engine/drawer/shader/PathRenderer.kt`
  - `mechanica-ui/src/main/kotlin/com/mechanica/engine/duke/UIUtils.kt`
  - `desktop-application/src/main/kotlin/com/mechanica/engine/display/GLFWWindow.kt`
  - `samples/src/main/kotlin/com/mechanica/engine/samples/drawer/DrawerMiniDemo.kt`
  - `mechanica/src/test/kotlin/com/mechanica/engine/scenes/ActiveStateTests.kt`

## Build And Runtime Notes

- The repository was primarily investigated through static code review.
- Lightweight wrapper discovery was partly successful in the current Windows lab:
  - `gradlew.bat --version` succeeded after redirecting `GRADLE_USER_HOME` into `research/cache/`
  - `gradlew.bat help --no-daemon` failed during configuration
- The immediate configuration failure is not just a Java-floor issue:
  - `desktop-application/build.gradle.kts` calls `providers.gradleProperty("lwjgl_natives").get()`
  - the build therefore hard-requires an external `lwjgl_natives` property before even basic Gradle help can complete
- There is also visible documentation drift:
  - `README.md` still says Java `12+`
  - the root Gradle build now enforces `jvmToolchain(22)`
- The build also depends on a checked-in local jar:
  - `libs/Kotlin-CAVE-jvm-0.2.jar`
- This makes the repository usable as an architecture reference, but weaker as a friction-free reproducible baseline.

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `1`
- Implementation depth: `3`
- Code clarity: `2`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - the repository contains a real compact engine architecture with scene lifecycle ownership, configurable delta stepping, shader-based drawing helpers, sample apps, and tests
  - it remains clearly desktop-first and somewhat rough, but it still earns `accepted` because its runtime and renderer structure are substantially more reusable than a pure prototype shell

## Interesting Findings

### Engine Architecture And Core Loop

- `mechanica/src/main/kotlin/com/mechanica/engine/game/configuration/GameSetup.kt` is the main assembly seam:
  - view and camera setup
  - GL/audio context initialization
  - persistence bootstrap
  - `SceneManager` construction
  - input and surface callback wiring
- `mechanica/src/main/kotlin/com/mechanica/engine/game/delta/MultiUpdateCalculator.kt` is the strongest reusable core-loop detail:
  - fixed-step accumulation
  - multiple update passes when needed
  - interpolation-friendly render values through `RenderableDouble`
  - an explicit safeguard that breaks if update work itself overruns the target step
- `mechanica/src/main/kotlin/com/mechanica/engine/scenes/SceneManager.kt` owns scene lifecycle cleanly:
  - active scene node graph
  - delayed scene switching
  - pause handling
  - single-frame stepping
  - centralized update and render orchestration
- This gives the lab a compact reference for small-engine scene ownership that is more structured than the average hobby LWJGL loop.

### Rendering And Graphics

- `desktop-application/src/main/kotlin/com/mechanica/engine/display/GLFWWindow.kt` is a real desktop host shell, not just a launcher stub:
  - GLFW init and teardown
  - callbacks
  - vSync
  - fullscreen and windowed switching
  - framebuffer and resize updates
  - icon and cursor control
- `mechanica/src/main/kotlin/com/mechanica/engine/drawer/shader/PathRenderer.kt` shows a notable rendering idea:
  - line and circle expansion via geometry shaders
  - stencil usage for path rendering
  - dynamic buffer growth for variable path sizes
- The rendering layer is useful mainly as a low-level OpenGL reference for custom Kotlin engines, not as an Android-native graphics baseline.

### UI And Host Integration

- `mechanica-ui/src/main/kotlin/com/mechanica/engine/duke/UIUtils.kt` shows an intentional engine-to-UI seam:
  - `RenderDescription` is translated into engine drawing operations instead of mixing UI state directly into low-level render code
- That is a small file, but it captures a reusable pattern:
  - UI tree description on one side
  - engine drawer implementation on the other

### Samples And Developer Ergonomics

- `samples/src/main/kotlin/com/mechanica/engine/samples/drawer/DrawerMiniDemo.kt` is intentionally tiny but useful:
  - it demonstrates the engine’s expected bootstrap flow
  - draw API ergonomics
  - matrix transforms
  - a minimal loop-driven sample entry point

### Testing And Verification

- `mechanica/src/test/kotlin/com/mechanica/engine/scenes/ActiveStateTests.kt` confirms that the repository is not documentation-only:
  - active/inactive state callbacks are exercised
  - listener ordering is tested by priority

### Build, Release, And Tooling Caveats

- The root build is modern but opinionated:
  - Kotlin `2.2.0`
  - Java toolchain `22`
  - `mavenLocal()`
  - a checked-in local jar
  - required external Gradle properties
- `README.md` documents `kotlin_cave_home` and `lwjgl_natives`, but the build itself still fails fast if those expectations are not preconfigured.

## Reusable Takeaways

- A small custom engine can stay understandable if scene ownership, delta policy, host windowing, and draw helpers are kept in explicit modules instead of one giant `main` loop.
- Fixed-step runtime code becomes much easier to reason about when interpolation data types and overrun handling are designed into the loop abstraction early.
- Even a compact engine benefits from explicit adapters between UI description and low-level draw commands.
- Build surfaces for experimental engines often drift faster than their README files; documenting exact configuration friction is part of the research value.

## Evidence Summary

- `GameSetup.kt`, `MultiUpdateCalculator.kt`, and `SceneManager.kt` prove the repository contains real engine-runtime architecture rather than only rendering experiments.
- `GLFWWindow.kt` and `PathRenderer.kt` show a meaningful host/render stack with explicit lifecycle and shader-backed geometry handling.
- `UIUtils.kt` and `DrawerMiniDemo.kt` show usable adapter and sample seams.
- `ActiveStateTests.kt` confirms at least part of the lifecycle model is covered by tests.

## Risks Or Limits

- No direct Android target is checked in.
- Build reproducibility is weaker than the repo first appears:
  - required external Gradle properties
  - Java toolchain `22`
  - local jar dependency
- README requirements are stale relative to the current build.
- Public signal is low at `0` stars, so this should be treated as a compact niche reference, not an ecosystem baseline.
- Code quality is uneven: the architecture is real, but several parts still look under-documented and tightly coupled.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `engine-framework`
- Focus tags: `2d`, `opengl`, `shader`, `ui-hud`, `testing`
- Follow-up needed:
  - if the lab revisits this repository, keep it narrow: compare the scene manager, fixed-step delta calculator, geometry-shader path rendering, or the GLFW host seam instead of reopening the whole repository blindly
