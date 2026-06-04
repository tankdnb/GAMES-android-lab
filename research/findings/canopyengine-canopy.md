# Research Note

## Repository Snapshot

- Repository: `canopyengine/canopy`
- Source URL: [https://github.com/canopyengine/canopy](https://github.com/canopyengine/canopy)
- Owner: `canopyengine`
- Batch ID: [`BATCH-2026-06-04-K`](../batches/BATCH-2026-06-04-K.md)
- Type: `engine-framework`
- License: `Apache-2.0` via GitHub metadata; the repository root also contains both `LICENSE-APACHE` and `LICENSE-MIT`
- Selection date: `2026-06-04`
- Last pushed at selection: `2026-06-01`
- Stars at selection: `3`
- Default branch at selection: `main`
- Investigated commit: `44fca3ef4d869e5e35b121992ee45ca7e07bf088`
- Research status: `accepted`
- Build mode: `static-review + gradle-help + build-dry-run + engine-test + devtools-test`
- Catalog card: [catalog/projects/canopyengine-canopy.md](../../catalog/projects/canopyengine-canopy.md)

## Why This Repository Was Selected

- `canopyengine/canopy` was the next verified candidate in the compact explicit-license shortlist and had the strongest current balance of freshness, permissive licensing, and expected engine-architecture yield.
- Compared with the remaining backlog reserve `vitaviva/ugame`, `canopy` looked more likely to add reusable runtime, scene, input, save, and tooling ideas rather than only another narrow Android game shell.
- The main question for this pass was whether the repository already contains a real reusable engine core or only a design sketch. The answer is that the runtime and testing layers are already valuable, even though the graphics/desktop side still looks partially parked or stale.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: custom node-driven Kotlin engine with platform/runtime modules, a libGDX adapter layer, and a small reactive state system
- Rendering stack: active build centers on engine/runtime, headless, terminal, and libGDX adapter modules; the checked-in desktop rendering/physics tree is excluded from the active build and should be treated as a stale reference rather than as a verified runtime baseline
- Android target: indirect only in the inspected revision; no active Android module is included in the build, but the runtime boundaries, input abstractions, save model, and node-tree architecture are still reusable for Android game work
- Build system: Gradle multi-module workspace with `engine`, `platforms:headless`, `platforms:terminal`, `adapters:libgdx`, `tooling:devtools`, and `tooling:utils`
- Repository layout summary:
  - `engine/` contains the app shell, node tree, scene manager, tree systems, reactive signals, save pipeline, and input model
  - `platforms/headless/` contains a minimal runtime host around the shared engine core
  - `platforms/terminal/` contains a terminal-oriented host built on the same headless loop
  - `adapters/libgdx/` contains headless hosting, assets, and input integration
  - `tooling/devtools/` contains a deterministic headless test driver used by the repository's tests
  - `platforms/desktop/` contains a larger graphics/physics tree, but it is currently excluded from `settings.gradle.kts`
- Source footprint:
  - total files counted in repository: `137`
  - Kotlin/Java/Gradle files counted in repository: `121`
- Test surface:
  - test files found: `14`
  - meaningful automated tests found: `14`
- Key modules reviewed:
  - `README.md`
  - `settings.gradle.kts`
  - `build.gradle.kts`
  - `gradle.properties`
  - `gradle/libs.versions.toml`
  - `gradle/gradle-daemon-jvm.properties`
  - `.github/workflows/build.yml`
  - `engine/build.gradle.kts`
  - `platforms/headless/build.gradle.kts`
  - `platforms/terminal/build.gradle.kts`
  - `platforms/desktop/build.gradle.kts`
  - `adapters/libgdx/build.gradle.kts`
  - `tooling/devtools/build.gradle.kts`
  - `engine/src/main/kotlin/io/canopy/engine/app/App.kt`
  - `engine/src/main/kotlin/io/canopy/engine/app/ScreenManager.kt`
  - `engine/src/main/kotlin/io/canopy/engine/core/nodes/Node.kt`
  - `engine/src/main/kotlin/io/canopy/engine/core/nodes/Node2D.kt`
  - `engine/src/main/kotlin/io/canopy/engine/core/nodes/Behavior.kt`
  - `engine/src/main/kotlin/io/canopy/engine/core/nodes/TreeSystem.kt`
  - `engine/src/main/kotlin/io/canopy/engine/core/managers/SceneManager.kt`
  - `engine/src/main/kotlin/io/canopy/engine/core/flows/events/Signal.kt`
  - `engine/src/main/kotlin/io/canopy/engine/core/flows/events/Computed.kt`
  - `engine/src/main/kotlin/io/canopy/engine/core/flows/events/Effect.kt`
  - `engine/src/main/kotlin/io/canopy/engine/data/saving/SaveManager.kt`
  - `engine/src/main/kotlin/io/canopy/engine/input/InputManager.kt`
  - `engine/src/main/kotlin/io/canopy/engine/input/InputSystem.kt`
  - `adapters/libgdx/src/main/kotlin/io/canopy/adapters/libgdx/app/headless/HeadlessHost.kt`
  - `adapters/libgdx/src/main/kotlin/io/canopy/adapters/libgdx/data/assets/GdxAssetsManager.kt`
  - `adapters/libgdx/src/main/kotlin/io/canopy/adapters/libgdx/input/GdxInputManager.kt`
  - `platforms/headless/src/main/kotlin/io/canopy/platforms/headless/app/HeadlessApp.kt`
  - `platforms/terminal/src/main/kotlin/io/canopy/platforms/terminal/app/TerminalApp.kt`
  - `platforms/desktop/src/main/kotlin/io/canopy/platforms/desktop/app/DesktopCanopyApp.kt`
  - `platforms/desktop/src/main/kotlin/io/canopy/platforms/desktop/graphics/systems/RenderSystem.kt`
  - `platforms/desktop/src/main/kotlin/io/canopy/platforms/desktop/physics/systems/PhysicsSystem.kt`
  - `tooling/devtools/src/main/kotlin/io/canopy/devtools/app/AppTestDriver.kt`
  - `engine/src/test/kotlin/io/canopy/engine/core/nodes/NodeTests.kt`
  - `tooling/devtools/src/test/kotlin/io/canopy/devtools/app/CanopyAppTests.kt`
  - `tooling/devtools/src/test/kotlin/io/canopy/devtools/app/CanopyScreenTests.kt`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery and targeted tests.
- `cmd /c gradlew.bat --version` succeeds and reports Gradle `9.5.0`.
- `cmd /c gradlew.bat help --no-daemon` succeeds.
- `cmd /c gradlew.bat build --dry-run --no-daemon` succeeds and confirms that the actively included modules are the engine, headless, terminal, libGDX adapter, and tooling modules.
- `cmd /c gradlew.bat :engine:test --no-daemon` succeeds.
- `cmd /c gradlew.bat :tooling:devtools:test --no-daemon` succeeds.
- The build surface is modern and explicit:
  - Kotlin `2.3.21`
  - libGDX `1.14.0`
  - KTX `1.13.1-rc1`
  - root Java toolchain/source/target `21`
  - `gradle/gradle-daemon-jvm.properties` pins daemon toolchain `17`
  - CI in `.github/workflows/build.yml` uses JDK `17`
- There is noticeable metadata and documentation drift:
  - `README.md` still shows version badge `0.0.1`, while `gradle.properties` says `0.1.0-dev1`
  - the root tree contains both `LICENSE-APACHE` and `LICENSE-MIT`, while GitHub resolves the repository as `Apache-2.0`
  - `README.md` implies a current engine surface broader than the actively included modules, while the checked-in `platforms/desktop` tree is excluded from the build
- No Android, terminal, or desktop runtime launch was attempted.

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `2`
- Implementation depth: `3`
- Code clarity: `2`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - the runtime core, node tree, scene management, save pipeline, and devtools harness are already concrete enough to reuse
  - the repository fills a useful gap in the lab between heavy ECS engines and very small Android-only product samples
  - the main downgrade from a stronger score is that the rendering/desktop side is visibly less trustworthy than the core runtime and test layers

## Interesting Findings

### Engine Architecture And Core Loop

- `App.kt` provides a clean platform-agnostic application shell around lifecycle hooks, manager registration, asynchronous launch ownership, and backend exit handling.
- `Node.kt` is the main reusable idea in the repository. Nodes are composed as a tree, can be built through a DSL with automatic parent attachment, support groups and path lookup, and can host behavior objects without requiring every node to become a deep subclass hierarchy.
- `Behavior.kt` shows a practical middle ground between data-only nodes and large inheritance trees: logic can be attached as class-backed or lambda-backed behavior objects and still receive clear lifecycle callbacks.
- `SceneManager.kt` keeps current scene ownership, a flat path index, node groups, registered tree systems, and a fixed-step physics accumulator in one place. It is not a large engine, but it is a readable example of how to keep scene runtime responsibilities centralized.
- `TreeSystem.kt` is a useful alternative to a full ECS for smaller engines. Systems are registered by phase and accepted node types, then processed across the tree through `PhysicsPre`, `PhysicsPost`, `FramePre`, and `FramePost` stages.
- `ScreenManager.kt` shows that the engine already thinks in higher-level app flow rather than only in bare nodes, which makes it more useful as a future small-game shell reference.

### Rendering And Graphics

- The strongest graphics lesson here is architectural rather than production-ready rendering output: the repository deliberately keeps the engine core separate from the host/runtime layer.
- `HeadlessHost.kt`, `HeadlessApp.kt`, and `TerminalApp.kt` show a reusable pattern where the same engine core can be hosted by different front ends without moving lifecycle ownership into gameplay code.
- The checked-in `platforms/desktop` tree still contains potentially useful ideas such as `RenderSystem.kt` and `PhysicsSystem.kt`, but those files are currently excluded from `settings.gradle.kts` and contain enough unresolved or inconsistent code paths that they should be treated as stale reference material rather than as verified engine baseline.
- `GdxAssetsManager.kt` is a better active rendering-adjacent seam than the excluded desktop code: it shows how the repository keeps asset/runtime integration out of the core engine module.

### Input And Controls

- `InputManager.kt` defines a solid engine-owned input seam: abstract actions, state transitions such as `Pressed` / `JustPressed`, axis/vector helpers, and optional persistence registration through the save system.
- `GdxInputManager.kt` shows how those abstract actions are bound onto a concrete libGDX keyboard/mouse source without leaking backend types into core gameplay code.
- `InputSystem.kt` keeps input dispatch as a runtime concern instead of as UI glue. The idea is good, but the inspected revision also reveals a useful caution: because the system declares no required node types, its real matching/dispatch behavior is weaker and likely still incomplete.
- The repository is a good reminder that small engines benefit from an explicit action model early, even before they settle on a final Android or desktop host.

### Persistence And Data

- `SaveManager.kt` is one of the more transferable pieces in the repository. It maps destination names to slots and save modules, then stores JSON by module ID instead of forcing every subsystem into one monolithic save blob.
- `InputManager.registerPersistence(...)` demonstrates a strong pattern for small games and engines: subsystem configuration can register its own save module directly instead of relying on one global serializer layer.
- The save model is small enough to understand quickly but structured enough to reuse in Android projects that need settings, bindings, or lightweight game-state persistence.

### Tooling And Content Pipeline

- `tooling/devtools` adds more value than its size suggests. `AppTestDriver.kt` provides a deterministic headless harness for app and screen testing, which makes the engine feel materially more mature than a similar repository with no tooling module at all.
- `CanopyAppTests.kt` and `CanopyScreenTests.kt` show how the repository tests lifecycle and app-flow seams through the headless driver instead of only unit-testing isolated helpers.
- The devtools split is also useful as a structural reminder: lightweight tooling and test harnesses do not need to wait for a large editor surface before they are worth adding to a game engine repository.

### Build, Release, And Testing

- `canopy` has a healthier verification surface than many small engine repos in the lab: the included modules configure cleanly, `build --dry-run` works, and both targeted test tasks succeed.
- The repository already carries real CI and toolchain intent through `build.gradle.kts`, `libs.versions.toml`, `gradle-daemon-jvm.properties`, and `.github/workflows/build.yml`.
- `NodeTests.kt` covers hierarchy building, lifecycle, behavior callbacks, and runtime mutation. That is exactly the kind of regression coverage a node-tree engine should prioritize.
- The main build caveat is consistency rather than absence of verification: root Java `21`, daemon `17`, and README/license/version drift all suggest the repository is moving faster than its top-level documentation.

## Reusable Takeaways

- A small Kotlin engine becomes much easier to evolve when nodes, behaviors, scenes, systems, input, and save ownership stay inside clear engine-owned seams instead of being scattered through UI or backend code.
- A node-tree plus phased tree-system model can be easier to reason about than a full ECS when the project wants structured hierarchy, behaviors, and scene flow more than archetype-level data throughput.
- Even an early engine benefits from a real headless test harness. `canopy` is stronger because lifecycle and scene behavior are verified through a host that resembles the runtime.
- Documentation drift matters. The repository is still worth keeping, but the mismatch between active modules and checked-in desktop code is a useful warning for future lab evaluations.

## Evidence Summary

- `engine/app/App.kt`, `engine/app/ScreenManager.kt`, `engine/core/managers/SceneManager.kt`, and `engine/core/nodes/TreeSystem.kt` - app shell, scene ownership, phased tree systems, and fixed-step runtime flow
- `engine/core/nodes/Node.kt` and `engine/core/nodes/Behavior.kt` - node-tree DSL, behavior attachment, path/group helpers, and lifecycle
- `engine/core/flows/events/Signal.kt`, `Computed.kt`, and `Effect.kt` - small reactive state graph with dependency tracking
- `engine/input/InputManager.kt`, `engine/input/InputSystem.kt`, and `adapters/libgdx/input/GdxInputManager.kt` - engine-owned action model, system dispatch, and backend binding
- `engine/data/saving/SaveManager.kt` - slot/module JSON persistence seam
- `tooling/devtools/app/AppTestDriver.kt` and the related tests - deterministic headless app/screen verification

## Risks Or Limits

- Android relevance is still indirect because no active Android module or backend is included in the current build graph.
- The checked-in `platforms/desktop` tree is excluded from the active build and appears partially stale or inconsistent, so the strongest value in the repository is the runtime/test architecture rather than the rendering layer.
- `InputSystem.kt` likely needs more work; the inspected registration path suggests that input dispatch is not fully mature yet.
- `Signal.kt` emits through `runBlocking`, which can block the caller thread and is worth treating carefully if similar patterns are reused in Android UI-adjacent code.
- README/license/version/scope drift lowers confidence in top-level documentation, so future passes should trust the code and build graph more than the marketing surface.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `engine-framework`
- Focus tags: `2d`, `scene-graph`, `libgdx`, `input`, `testing`
- Follow-up needed:
  - if the lab revisits this repository, rerun the active test surface in a fuller JDK `17+` or `21` environment and isolate one seam at a time instead of reopening the whole tree
  - the best narrow revisit targets would be the node/behavior runtime, the scene/tree-system ownership model, the save/input integration seam, or the excluded desktop rendering path
