# Research Note

## Repository Snapshot

- Repository: `icela/FriceEngine`
- Source URL: [https://github.com/icela/FriceEngine](https://github.com/icela/FriceEngine)
- Owner: `icela`
- Batch ID: [`BATCH-2026-06-04-AI`](../batches/BATCH-2026-06-04-AI.md)
- Type: `engine-framework`
- License: `AGPL-3.0`
- Selection date: `2026-06-04`
- Last pushed at selection: `2019-12-28`
- Stars at selection: `349`
- Default branch at selection: `master`
- Investigated commit: `8374f87a286d7323348d7aea8213eaebd64dfe6c`
- Research status: `reference-only`
- Build mode: `static-review + gradle-help-failed-legacy-bintray-http-builder`
- Catalog card: [catalog/projects/icela-friceengine.md](../../catalog/projects/icela-friceengine.md)

## Why This Repository Was Selected

- `FriceEngine` was the only remaining carry-over candidate in the exact-license shortlist, so it was the right point to close before refreshing the queue.
- The repository also still carries unusual historical signal for a Kotlin game-engine niche: explicit license metadata, `349` stars, and a compact codebase that can be audited almost completely in one pass.
- Static review answers the main question conservatively: `FriceEngine` is worth preserving, but only as `reference-only`. It still contains some readable Kotlin engine ideas, yet it is too stale, too JVM-desktop-specific, and too legacy-tooling-bound to serve as a main Android-facing baseline.

## Technical Profile

- Main language(s): Kotlin, Java
- Engine / framework: custom JVM game engine with Swing and JavaFX backends
- Rendering stack: Swing `JFrame` / `JComponent` + `Graphics2D` + JavaFX `Canvas` / `GraphicsContext` behind a shared drawer/image abstraction
- Android target: none in the checked-in tree; Android relevance is only indirect through a few transferable Kotlin runtime patterns
- Build system: Gradle `4.7` wrapper + Kotlin JVM `1.2.60` + Java `8` + Dokka `0.9.17` + Bintray/JCenter-era publishing plugins
- Repository layout summary:
  - `src/` - engine runtime, rendering adapters, object model, resource helpers, timers, media, and persistence utilities
  - `test/` - mixed test/demo tree with a few real assertions and many interactive runtime samples
  - `res/` - bundled assets such as the engine icon and sample media
  - `lib/` - checked-in MP3 decoding jars used by the audio helpers
- Source footprint:
  - total files counted in repository: `100`
  - Kotlin/KTS/Java files counted in repository: `89`
- Test surface:
  - files under `test/`: `16`
  - meaningful engine/gameplay regression coverage: very limited; most of the tree is interactive sample code rather than automated verification
- Key modules and files reviewed:
  - `README.md`
  - `LICENSE.txt`
  - `build.gradle.kts`
  - `settings.gradle.kts`
  - `gradle/wrapper/gradle-wrapper.properties`
  - `.travis.yml`
  - `.circleci/config.yml`
  - `appveyor.yml`
  - `lib/README.md`
  - `src/org/frice/Initializer.kt`
  - `src/org/frice/Game.kt`
  - `src/org/frice/GameFX.kt`
  - `src/org/frice/platform/FriceGame.kt`
  - `src/org/frice/platform/Layer.kt`
  - `src/org/frice/platform/FriceDrawer.kt`
  - `src/org/frice/platform/FriceImage.kt`
  - `src/org/frice/platform/adapter/JvmDrawer.kt`
  - `src/org/frice/platform/adapter/JfxDrawer.kt`
  - `src/org/frice/obj/Objects.kt`
  - `src/org/frice/obj/FObject.kt`
  - `src/org/frice/anim/FAnim.kt`
  - `src/org/frice/anim/move/UniformMove.kt`
  - `src/org/frice/anim/move/AccelerateMove.kt`
  - `src/org/frice/util/EventManager.kt`
  - `src/org/frice/event/DelayedEvent.kt`
  - `src/org/frice/util/time/FClock.kt`
  - `src/org/frice/util/time/FTimer.kt`
  - `src/org/frice/util/time/FpsCounter.kt`
  - `src/org/frice/util/QuadTree.kt`
  - `src/org/frice/resource/manager/Managers.kt`
  - `src/org/frice/resource/image/ImageResources.kt`
  - `src/org/frice/util/media/AudioPlayer.kt`
  - `src/org/frice/util/data/Preference.kt`
  - `src/org/frice/util/data/XMLPreference.kt`
  - `test/org/frice/Test.kt`
  - `test/org/frice/JfxTest.kt`
  - `test/org/frice/PreferenceTest.kt`
  - `test/org/frice/XMLPreferenceTest.kt`
  - `test/org/frice/util/ColorUtilsTest.kt`
  - `test/org/frice/platform/FriceImageTest.kt`
  - `test/org/frice/util/media/AudioPlayerTest.kt`
  - `test/org/frice/anim/move/DirectedMoveTest.kt`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeded locally and reported:
  - Gradle `4.7`
  - Java `1.8.0_321`
- `cmd /c gradlew.bat help --no-daemon` failed during root configuration because the old publishing stack now depends on an artifact that no longer resolves from the configured repositories:
  - missing `org.codehaus.groovy.modules.http-builder:http-builder:0.7.2`
  - transitive path goes through `com.jfrog.bintray.gradle:gradle-bintray-plugin:1.7.3`
- `cmd /c gradlew.bat test --dry-run --no-daemon` fails at the same configuration stage for the same reason.
- The build files and CI configs confirm this is a legacy Java-8-era publication setup:
  - Kotlin `1.2.60`
  - Gradle `4.7`
  - `jcenter()`
  - Bintray publishing
  - Travis CI + CircleCI + AppVeyor
- The repository also vendors MP3 support jars in `lib/`:
  - `jl1.0.1.jar`
  - `mp3spi1.9.5.jar`
  - `tritonus_share.jar`
- No runtime launch was attempted because the static pass already provided enough evidence and the JavaFX/Swing runtime is clearly desktop-only.

## Usefulness Assessment

- Reuse potential: `2`
- Android transfer: `1`
- Implementation depth: `2`
- Code clarity: `2`
- Novelty: `2`
- Overall verdict: `reference-only`
- Why:
  - `FriceEngine` still has value as a compact historical Kotlin engine reference: the shared Swing/JavaFX API surface, buffered layer mutation, timer/event helpers, resource caching, and image utilities are all easy to read.
  - It falls short as a main lab baseline because there is no Android target, the engine is tied to old desktop UI stacks, the build is now broken by legacy Bintray-era dependencies, and several maturity issues are visible directly in the checked-in runtime.

## Interesting Findings

### Engine Architecture And Core Loop

- `src/org/frice/Game.kt`, `src/org/frice/GameFX.kt`, `src/org/frice/platform/FriceGame.kt`, and `src/org/frice/Initializer.kt` show the repository's clearest architectural idea: one shared engine API is implemented twice, once on Swing and once on JavaFX, while launch helpers decide backend setup and shared runtime flags such as `FManager.useJfx`.
- `src/org/frice/platform/Layer.kt` plus `FriceGame.processBuffer()` are still a useful small-engine pattern. Objects and texts are staged through add/remove buffers and applied once per frame, which avoids some concurrent-mutation failures without needing a larger ECS or message bus.
- `src/org/frice/util/EventManager.kt`, `src/org/frice/event/DelayedEvent.kt`, and `src/org/frice/util/time/FClock.kt` form a tiny scheduling model where engine time is explicit and delayed jobs are checked from the refresh loop instead of being tied to one UI toolkit callback style.
- The same files also expose why this should stay a comparison reference: `GameFX.start(...)` drives the whole JavaFX runtime from a raw background `thread { while (true) { ... } }` loop while still drawing through JavaFX `GraphicsContext`, which is a risky modern baseline for JavaFX host safety.

### Rendering And Graphics

- `src/org/frice/platform/FriceDrawer.kt`, `src/org/frice/platform/adapter/JvmDrawer.kt`, and `src/org/frice/platform/adapter/JfxDrawer.kt` show a clear backend-abstraction seam. Drawing operations, font setup, and rotation live behind one interface, which is still a transferable idea when comparing platform adapters.
- `src/org/frice/platform/FriceImage.kt` and `src/org/frice/resource/image/ImageResources.kt` provide a second useful seam: image resources can be sliced, flipped, scaled, or animated through `FrameImageResource` without backend-specific calling code.
- `src/org/frice/Game.kt` uses one offscreen `JvmImage` buffer and then blits it in `paintComponent(...)`, while `GameFX.kt` writes directly into a JavaFX `Canvas`. That contrast is useful historically because it shows two different backend strategies behind one public runtime API.

### Input And Controls

- `src/org/frice/Game.kt`, `src/org/frice/GameFX.kt`, and `src/org/frice/platform/FriceGame.kt` keep input translation relatively clean: each backend turns native mouse/key events into shared engine events, and button hit-testing stays in one place through `containsPoint(...)`.
- `src/org/frice/platform/Layer.kt` and the button types show a very small HUD/input routing idea where buttons are tracked separately from other objects and are hit-tested by the runtime instead of by each game.
- This area also exposes a concrete maturity problem: `Layer.removeObject(...)` and `Layer.instantRemoveObject(...)` add `FButton` instances back into `buttons` instead of removing them, which means button bookkeeping is not reliable enough for a main reference baseline.

### Physics And Collision

- `src/org/frice/obj/Objects.kt` keeps collision extremely small and readable: `Collidable.collides(...)` is just an AABB overlap check over `box`, and `PhysicalObject` can override its collision shape through `collisionBox`.
- `src/org/frice/platform/FriceGame.kt` uses `activeArea` / `defaultActiveArea` plus `autoGC` to remove off-screen objects, which is a direct and reusable pattern for tiny 2D prototypes.
- `src/org/frice/util/QuadTree.kt` shows that the author already recognized the need for spatial partitioning, but the current runtime still does not integrate it into the main object-processing path. That makes it more useful as a comparison seam than as a production-ready collision baseline.

### Audio

- `src/org/frice/util/media/AudioPlayer.kt` is one of the more practical subsystems: it normalizes incoming audio to signed PCM through JavaSound and explicitly warns when the JRE mixer is unreliable, suggesting a fallback to the JavaFX media path.
- The checked-in `lib/` jars plus `lib/README.md` make the tradeoff concrete: MP3 support is not abstract package management here, it is a bundled compatibility workaround kept inside the repository.

### Persistence, Resources, And Utility Surface

- `src/org/frice/resource/manager/Managers.kt` is still a useful tiny resource-cache pattern. File, web, and jar text/bytes/images all share one `FManager<T>` shape, and image managers return clones to avoid accidental shared mutation across callers.
- `src/org/frice/util/data/Preference.kt` and `src/org/frice/util/data/XMLPreference.kt` show a lightweight desktop analogue to Android-style preferences. The XML variant is especially explicit about typed values and document rewrites, which can still be useful as a small persistence comparison sample.
- `Managers.kt` also shows a design compromise worth documenting: jar resource lookup depends on the caller class extracted from `Thread.currentThread().stackTrace[2]`, which is clever but brittle compared with explicit classloader ownership.

### Build, Release, And Testing

- `build.gradle.kts`, `.travis.yml`, `.circleci/config.yml`, and `appveyor.yml` show a vivid legacy Kotlin/JVM build shape:
  - Java `8`
  - Gradle `4.7`
  - Kotlin `1.2.60`
  - JCenter/Bintray publication
  - Travis/CircleCI/AppVeyor matrix
- The build is not merely old; it is partially non-reproducible today. The `com.jfrog.bintray` plugin transitively requires `http-builder:0.7.2`, and that artifact no longer resolves in the configured dependency chain.
- The visible `test/` tree mixes several real assertion files such as `ColorUtilsTest.kt`, `PreferenceTest.kt`, and `XMLPreferenceTest.kt` with many interactive desktop demos such as `DirectedMoveTest.kt`, `AudioPlayerTest.kt`, and `FriceImageTest.kt`. That is useful context because the repository advertises tests, but much of the surface is manual runtime exploration rather than regression safety.

## Reusable Takeaways

- A tiny engine can still benefit from a shared runtime interface when multiple rendering hosts must expose similar gameplay APIs.
- Buffered add/remove queues inside per-layer storage are a practical lightweight defense against frame-loop mutation issues in very small runtimes.
- Timer/event scheduling does not need a large subsystem if engine time is explicit and delayed work is checked deterministically from the main refresh path.
- Resource helpers become easier to reuse when text, bytes, images, file paths, web URLs, and jar resources all share one small caching abstraction.
- `FriceEngine` is also a cautionary example: a compact public API can still hide backend-threading risks, bookkeeping bugs, and publication-era dependencies that make the whole stack poor as a modern baseline.

## Evidence Summary

- `Game.kt`, `GameFX.kt`, `FriceGame.kt`, `Initializer.kt` - shared engine API across Swing and JavaFX backends
- `Layer.kt` - buffered per-frame object/text staging and a concrete button-removal bookkeeping flaw
- `FriceDrawer.kt`, `JvmDrawer.kt`, `JfxDrawer.kt`, `FriceImage.kt` - backend-neutral rendering and image seams
- `Objects.kt`, `QuadTree.kt`, `FriceGame.kt` - simple collision, auto-GC, and an unused spatial-partitioning direction
- `EventManager.kt`, `DelayedEvent.kt`, `FClock.kt`, `FTimer.kt` - explicit engine-time scheduling model
- `Managers.kt`, `ImageResources.kt`, `Preference.kt`, `XMLPreference.kt` - small cache/persistence helpers with reusable patterns and a few brittle implementation choices
- `AudioPlayer.kt` and `lib/README.md` - JavaSound-normalized audio plus vendored MP3 compatibility jars
- `build.gradle.kts` and CI configs - legacy Kotlin `1.2` / Bintray / JCenter / Java `8` build story now broken by missing transitive publication dependencies

## Risks Or Limits

- No Android target exists in the checked-in tree.
- The repository is stale as code: the last pushed code revision is from `2019-12-28`.
- Licensing is restrictive for direct reuse in a public idea library because the checked-in engine is `AGPL-3.0`.
- The JavaFX backend writes through `GraphicsContext` from a background thread, which is not a strong modern runtime pattern.
- `Layer.removeObject(...)` and `Layer.instantRemoveObject(...)` mishandle `FButton` removal bookkeeping.
- The build is no longer reproducible as checked in because the old Bintray plugin path now fails on missing `http-builder`.
- Much of the visible test tree is demo-oriented rather than a dependable automated regression surface.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `reference-only`
- Focus tags: `2d`, `input`, `collision`, `audio`
- Follow-up needed:
  - if the lab revisits this repository, keep it narrow: either harvest the dual-backend drawer/image seam, the tiny timer/event scheduler, or the resource/persistence helpers, and do not reopen it as a modern Android-engine baseline unless there is a specific legacy-comparison reason
