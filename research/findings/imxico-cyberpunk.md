# Research Note

## Repository Snapshot

- Repository: `ImXico/cyberpunk`
- Source URL: [https://github.com/ImXico/cyberpunk](https://github.com/ImXico/cyberpunk)
- Owner: `ImXico`
- Batch ID: [`BATCH-2026-06-04-T`](../batches/BATCH-2026-06-04-T.md)
- Type: `library-sdk`
- License: `MIT`
- Selection date: `2026-06-04`
- Last pushed at selection: `2020-04-15`
- Stars at selection: `78`
- Default branch at selection: `master`
- Investigated commit: `47d9a8130b31ec9bab20708995ee3a2bd93b45e7`
- Research status: `accepted`
- Build mode: `static-review + gradle-help + test-dry-run + test-failed-no-jdk`
- Catalog card: [catalog/projects/imxico-cyberpunk.md](../../catalog/projects/imxico-cyberpunk.md)

## Why This Repository Was Selected

- `ImXico/cyberpunk` was the next exact-license-verified repository in the compact shortlist and the strongest remaining candidate for a narrow libGDX helper-library pass.
- The repository is stale and not Android-native, so the main question for this batch was whether the code still contains enough transferable Kotlin game-runtime patterns to stay in the main catalog.
- The answer is yes, but narrowly: the strongest value is not in the whole library surface equally, but in a few compact subsystems such as the `StateManager` plus transition-FBO pattern and the pixel-first Box2D builders.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: modular helper library on top of libGDX
- Rendering stack:
  - libGDX `Batch`, `Camera`, `Viewport`, `FrameBuffer`, `TextureRegion`, and `Box2DDebugRenderer`
  - singleton-based asset helpers for audio and texture atlases
- Android target: indirect; no Android module is checked in, but the helpers are explicitly shaped for libGDX game-jam or prototype workflows that can still transfer into Android libGDX projects
- Build system: Gradle multi-project Groovy DSL build with JitPack-oriented publication and legacy Travis CI
- Repository layout summary:
  - `core/` contains state flow, transitions, graphics helpers, and world-size constants
  - `physics/` contains Box2D world/config wrappers plus reusable builders
  - `camera/`, `image/`, `text/`, `audio/`, and `profiler/` provide small focused utilities
  - root Gradle files keep each module independently publishable
- Source footprint:
  - total files counted in repository: `57`
  - Kotlin/Java files counted in repository: `26`
  - test files found: `1`
  - meaningful automated tests found: `1`, but only for tiny coordinate helpers
- Key modules reviewed:
  - `README.md`
  - `build.gradle`
  - `settings.gradle`
  - `gradle.properties`
  - `.travis.yml`
  - `gradle/wrapper/gradle-wrapper.properties`
  - `core/README.md`
  - `camera/README.md`
  - `audio/README.md`
  - `physics/README.md`
  - `core/src/main/kotlin/cyberpunk/core/state/State.kt`
  - `core/src/main/kotlin/cyberpunk/core/state/StateAdapter.kt`
  - `core/src/main/kotlin/cyberpunk/core/state/StateManager.kt`
  - `core/src/main/kotlin/cyberpunk/core/transition/Transition.kt`
  - `core/src/main/kotlin/cyberpunk/core/transition/TransitionFBO.kt`
  - `core/src/main/kotlin/cyberpunk/core/transition/types/Fade.kt`
  - `core/src/main/kotlin/cyberpunk/core/transition/types/HorizontalSlide.kt`
  - `core/src/main/kotlin/cyberpunk/core/WorldConfig.kt`
  - `camera/src/main/kotlin/cyberpunk/camera/CameraStyles.kt`
  - `image/src/main/kotlin/cyberpunk/image/ImageManager.kt`
  - `image/src/main/kotlin/cyberpunk/image/ImageHelper.kt`
  - `text/src/main/kotlin/cyberpunk/text/TextHelper.kt`
  - `audio/src/main/kotlin/cyberpunk/audio/SoundManager.kt`
  - `audio/src/main/kotlin/cyberpunk/audio/MusicManager.kt`
  - `profiler/src/main/kotlin/cyberpunk/profiler/PerformanceProfiler.kt`
  - `physics/src/main/kotlin/cyberpunk/physics/PhysicsConfig.kt`
  - `physics/src/main/kotlin/cyberpunk/physics/PhysicsWorld.kt`
  - `physics/src/main/kotlin/cyberpunk/physics/PhysicsUtility.kt`
  - `physics/src/main/kotlin/cyberpunk/physics/builder/BodyBuilder.kt`
  - `physics/src/main/kotlin/cyberpunk/physics/builder/BodyDefBuilder.kt`
  - `physics/src/main/kotlin/cyberpunk/physics/builder/FixtureDefBuilder.kt`
  - `image/src/test/kotlin/cyberpunk/image/ImageHelperTests.kt`

## Build And Runtime Notes

- The repository was investigated through static review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat help --no-daemon` succeeds in the lab and bootstraps Gradle `5.6.1`.
- `cmd /c gradlew.bat test --dry-run --no-daemon` also succeeds, confirming a readable multi-module test graph across all helper modules.
- `cmd /c gradlew.bat test --no-daemon` fails at `:audio:compileKotlin` because Gradle is running on the machine's Java `8` JRE instead of a full JDK:
  - `Kotlin could not find the required JDK tools in the Java installation 'C:\Program Files\Java\jre1.8.0_321'`
- The inspected build itself is intentionally old and should be treated as a historical libGDX helper stack rather than as a modern baseline:
  - Kotlin `1.3.61`
  - libGDX `1.9.10`
  - Gradle `5.6.1`
  - `jcenter()` is still configured
  - `.travis.yml` pins `oraclejdk9`
- No runtime launch was attempted.

## Usefulness Assessment

- Reuse potential: `2`
- Android transfer: `2`
- Implementation depth: `2`
- Code clarity: `3`
- Novelty: `1`
- Overall verdict: `accepted`
- Why:
  - the repository is stale and narrow, but it still preserves a few compact libGDX helper patterns that remain useful as reference material
  - the strongest reusable value is in the small `StateManager` plus FBO-transition shell and the pixel-first Box2D builder layer
  - it is worth keeping in the main catalog as a narrow helper-library reference, not as a modern engine baseline

## Interesting Findings

### Engine Architecture And Core Loop

- `State.kt`, `StateAdapter.kt`, and `StateManager.kt` form a compact state-driven runtime where each state owns input, update, render, resize, pause, resume, and dispose behavior while `StateManager` keeps camera, viewport, batch, and transition orchestration centralized.
- `StateAdapter.kt` is a useful small pattern for libGDX games that want a single base class to bridge `InputProcessor` behavior and screen-to-world `unproject()` helpers without forcing game code to talk to the viewport directly every time.
- `WorldConfig.kt` keeps one explicit virtual resolution boundary for the whole state/transition layer, which is a small but still reusable pattern for keeping game-jam-scale libGDX projects consistent.

### Rendering And Graphics

- `TransitionFBO.kt` shows a compact render-to-texture transition seam: capture the current and next states into two `FrameBuffer`s, flip their `TextureRegion`s once, and let transition implementations render only screen-space blends instead of reaching into gameplay code.
- `Fade.kt` and `HorizontalSlide.kt` are simple but readable examples of transition implementations that sit completely outside gameplay state classes.
- `CameraStyles.kt` is deliberately small, but it is still a useful example of treating camera-follow behaviors as extension functions instead of burying them in one monolithic camera controller.

### UI, HUD, And Menus

- `ImageHelper.kt` and `TextHelper.kt` keep centering logic in plain helper functions instead of duplicating manual alignment math across menus or HUD code.
- The combination of `CameraStyles`, image/text centering, and `StateAdapter.unproject()` gives this repository a coherent "small libGDX product shell" flavor even though it does not ship an actual game.

### Physics And Collision

- `PhysicsUtility.kt` is the strongest physics-side idea in the repository: keep the game thinking in pixels while centralizing Box2D unit conversion behind small extension helpers.
- `PhysicsWorld.kt` and `PhysicsConfig.kt` wrap Box2D world ownership, fixed-step configuration, and optional debug rendering into a compact API that is easier to drop into a prototype than raw `World` plus `Box2DDebugRenderer` setup.
- `BodyBuilder.kt`, `BodyDefBuilder.kt`, and `FixtureDefBuilder.kt` provide a readable fluent-builder layer over Box2D body/fixture setup, including automatic shape disposal after body creation and reusable builder instances after `build()`.

### Audio

- `SoundManager.kt` and `MusicManager.kt` show the repository's overall philosophy clearly: keep keyed singleton registries for fast prototype ergonomics, Java interoperability, and very low ceremony.
- `audio/README.md` is worth noting because it explicitly frames these managers as temporary/simple game-jam tools and recommends eventual `AssetManager`-based solutions for larger projects.

### Build, Release, And Testing

- The module split is clean for such a small repo: each helper family lives in its own Gradle project and can be consumed independently.
- The build surface still matters as a reference because `gradlew.bat help` and `test --dry-run` both work in the lab, which is better than many similarly old repos.
- The visible verification surface is very weak in depth: only `ImageHelperTests.kt` was found, and it covers two tiny centering invariants rather than any of the more important state/transition or Box2D seams.

## Reusable Takeaways

- For small libGDX games, a narrow `StateManager` plus optional FBO-based transitions can still be a practical alternative to a heavier scene framework.
- Pixel-first Box2D builder helpers are a good ergonomic pattern when the game team wants to think in screen/world pixels instead of meters most of the time.
- Small helper libraries are most useful when they keep subsystems truly modular; `cyberpunk` is strongest where its modules stay tiny and independent.
- It is worth documenting when a repository itself admits that some helpers are game-jam shortcuts rather than scalable long-term abstractions.

## Evidence Summary

- `State.kt`, `StateAdapter.kt`, and `StateManager.kt` - compact libGDX state runtime with camera/viewport ownership and transition orchestration
- `Transition.kt`, `TransitionFBO.kt`, `Fade.kt`, and `HorizontalSlide.kt` - render-to-texture state transitions separated from gameplay state code
- `WorldConfig.kt` - fixed virtual world dimensions for the shared shell
- `CameraStyles.kt` - reusable extension-based camera behaviors
- `PhysicsUtility.kt`, `PhysicsWorld.kt`, `PhysicsConfig.kt`, `BodyBuilder.kt`, `BodyDefBuilder.kt`, and `FixtureDefBuilder.kt` - pixel-first Box2D wrapper and builder layer
- `SoundManager.kt`, `MusicManager.kt`, `ImageManager.kt`, `ImageHelper.kt`, and `TextHelper.kt` - keyed singleton asset helpers and common alignment utilities
- `build.gradle`, `.travis.yml`, `gradle-wrapper.properties`, and `ImageHelperTests.kt` - old but readable build surface with only a very small test footprint

## Risks Or Limits

- The repository is stale by implementation activity; the last inspected commit is from `2020-04-15`.
- The whole stack is old and partially legacy-bound: Kotlin `1.3.61`, libGDX `1.9.10`, Gradle `5.6.1`, `jcenter()`, and Travis `oraclejdk9`.
- The central `StateManager` path has two verified caveats in the inspected code:
  - `go(state)` documents a null-transition path, but `render()` only completes a handoff when `transition` is non-null once `nextState` is set
  - `go(...)` disposes `currentState` before transition rendering, so `wrapCurrent { currentState?.render(batch) }` can end up drawing a disposed state
- The singleton managers are intentionally prototype-oriented and scale worse than a proper `AssetManager` plus ownership-aware dependency model.
- The automated test surface is too small to give strong confidence in the most important runtime seams.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `library-sdk`
- Focus tags: `libgdx`, `physics`, `audio`, `ui-hud`
- Follow-up needed:
  - if the lab revisits this repository, rerun `test` in a real JDK-backed environment
  - the most useful narrow follow-up targets would be the `StateManager` handoff/transition seam or the Box2D builder layer rather than the whole repository
