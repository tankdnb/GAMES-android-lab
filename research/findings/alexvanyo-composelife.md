# Research Note

## Repository Snapshot

- Repository: `alexvanyo/composelife`
- Source URL: [https://github.com/alexvanyo/composelife](https://github.com/alexvanyo/composelife)
- Owner: `alexvanyo`
- Batch ID: [`BATCH-2026-06-04-AB`](../batches/BATCH-2026-06-04-AB.md)
- Type: `android-game`
- License: `Apache-2.0`
- Selection date: `2026-06-04`
- Last pushed at selection: `2026-06-03`
- Stars at selection: `253`
- Default branch at selection: `main`
- Investigated commit: `aa25b0f4a35de9bcc893559da4ed83d101177b59`
- Research status: `accepted`
- Build mode: `static-review + sanitized-export + gradle-help-failed-java8-needs-java17 + checkout-failed-invalid-colon-paths`
- Catalog card: [catalog/projects/alexvanyo-composelife.md](../../catalog/projects/alexvanyo-composelife.md)

## Why This Repository Was Selected

- `ComposeLife` came out of a refreshed exact-license shortlist after repository-level verification, not just GitHub search-index metadata.
- It had the strongest current balance of popularity, freshness, and expected research yield among the available candidates because it is a direct Android Kotlin product with a broad Compose, Wear OS, rendering, state-management, and test surface.
- The main question for this batch was whether `ComposeLife` is only a polished Game of Life simulator or whether it also contains reusable Android game-development ideas. The answer is `accepted`: the repository is richer than a normal sample app and preserves several reusable patterns for simulation timing, rendering backends, Android shell composition, content sync, and testing discipline.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: Android SDK + Jetpack Compose + Compose Multiplatform + Metro dependency injection + custom Game of Life simulation core + Wear OS watchface modules
- Rendering stack:
  - Compose UI and adaptive app shell for Android
  - AGSL-backed cell rendering on Android
  - SKSL-backed cell rendering on Skiko targets
  - OpenGL ES watchface renderer for Wear OS
  - web and desktop hosts around the same shared simulation modules
- Android target: direct Android app plus Wear OS watchface and configuration surfaces, with additional desktop and web hosts sharing the same simulation, data, and UI modules
- Build system: Gradle Kotlin DSL monorepo using included build logic, Kotlin Multiplatform, Compose, Metro, Develocity, and Android-specific benchmark/screenshot/baseline-profile workflows
- Repository layout summary:
  - `algorithm/` contains the shared cell-state models, serialization, and Game of Life algorithms
  - `app`, `app-impl`, `ui-*`, and `navigation/` contain the Android and shared Compose product shell
  - `wear`, `wear-watchface`, `wear-watchface-configuration`, and related WFF modules contain the watchface and Wear configuration stack
  - `data/`, `database/`, `preferences*/`, and `work/` contain persistence, remote pattern synchronization, and background-task seams
  - `build-logic/` contains centralized Gradle convention plugins
- Source footprint:
  - total files counted in repository: `4236`
  - Kotlin/KTS/Java files counted in repository: `788`
  - test-code files found under test source sets: `138`
  - Gradle modules included in `settings.gradle.kts`: `80`
- Special workspace caveat:
  - `1980` checked-in paths contain `:` in filenames under `wear-watchface-wff-resources/src/jvmTest/resources/solutions/`
  - those paths break normal Windows checkout, so the lab had to continue with git-object inspection and a sanitized tarball export for lightweight Gradle discovery
- Key modules and files reviewed:
  - `README.md`
  - `settings.gradle.kts`
  - `build.gradle.kts`
  - `gradle.properties`
  - `.github/workflows/ci.yml`
  - `docs/di.md`
  - `docs/navigation.md`
  - `algorithm/src/jbMain/kotlin/com/alexvanyo/composelife/model/TemporalGameOfLifeState.kt`
  - `algorithm/src/jbMain/kotlin/com/alexvanyo/composelife/algorithm/HashLifeAlgorithm.kt`
  - `algorithm/src/jbMain/kotlin/com/alexvanyo/composelife/algorithm/ConfigurableGameOfLifeAlgorithm.kt`
  - `navigation/README.md`
  - `navigation/src/commonMain/kotlin/com/alexvanyo/composelife/navigation/MutableBackstackNavigationController.kt`
  - `ui-app/src/commonMain/kotlin/com/alexvanyo/composelife/ui/app/ComposeLifeNavigation.kt`
  - `app-impl/src/androidMain/kotlin/com/alexvanyo/composelife/MainActivity.kt`
  - `ui-cells/src/androidMain/kotlin/com/alexvanyo/composelife/ui/cells/AGSLNonInteractableCells.kt`
  - `ui-cells/src/skikoMain/kotlin/com/alexvanyo/composelife/ui/cells/SKSLNonInteractableCells.kt`
  - `opengl-renderer/src/androidMain/kotlin/com/alexvanyo/composelife/openglrenderer/GameOfLifeShape.kt`
  - `wear-watchface/src/androidMain/kotlin/com/alexvanyo/composelife/wear/watchface/GameOfLifeRenderer.kt`
  - `data/src/jbMain/kotlin/com/alexvanyo/composelife/data/PatternCollectionRepositoryImpl.kt`
  - `data/src/androidMain/kotlin/com/alexvanyo/composelife/data/PatternCollectionSync.kt`
  - `data/src/androidMain/kotlin/com/alexvanyo/composelife/data/PatternCollectionSyncWorker.kt`

## Build And Runtime Notes

- The first direct `git clone` into `research/worktrees/` succeeded at the object-transfer level but failed to check out on Windows because the repository contains paths like `wear-watchface-wff-resources/src/jvmTest/resources/solutions/00:00.rle`.
- To preserve the research workflow, the lab used static git-object inspection first and then downloaded a tarball and extracted only Windows-safe paths into a sanitized temporary export for lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeds from the sanitized export:
  - Gradle `9.5.1`
  - launcher JVM `1.8.0_321`
- `cmd /c gradlew.bat help --no-daemon` fails in the lab because the build requires a newer JVM:
  - `Gradle requires JVM 17 or later to run. Your build is currently configured to use JVM 8.`
- The checked-in repository itself clearly expects a much newer environment:
  - README says `Android Studio Narwhal 3 Feature Drop 2025.1.3`
  - README says `JDK 21+`
  - `.github/workflows/ci.yml` sets up `JDK 21` and a large Android SDK / emulator matrix
- No runtime launch was attempted inside the lab.

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `3`
- Implementation depth: `3`
- Code clarity: `3`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - `ComposeLife` is more than a UI novelty sample. It contains reusable Android product-shell, simulation, rendering, sync, DI, navigation, and testing patterns that are directly applicable to Kotlin Android game or interactive-simulation work.
  - The repository is especially valuable as a reference for how a Compose-first Android product can still sustain complex shared modules, watchface support, multiple rendering backends, and a disciplined CI/test surface.

## Interesting Findings

### Engine Architecture And Core Loop

- `algorithm/.../TemporalGameOfLifeState.kt` is one of the strongest reusable patterns in the repository. It models a long-lived evolving simulation with explicit pause or run state, manual step requests, target step rate, running throughput metrics, and genealogy resets when the seed or step size changes.
- The same file avoids hiding the simulation loop inside arbitrary UI code. A `TemporalGameOfLifeStateMutator` implements `Updatable`, so simulation ownership stays explicit and can be launched by the Android shell like any other long-lived app service.
- `ConfigurableGameOfLifeAlgorithm.kt` is a useful algorithm hot-swap pattern. It listens to preference state and can switch between naive and `HashLife` computation while preserving the latest evolved state rather than forcing a full restart.
- `MainActivity.kt` shows a practical Android shell where the activity builds one scoped `UiGraph`, gates splash-screen dismissal on preferences readiness, and launches a set of `uiUpdatables` from one place instead of letting each screen or composable own background loops independently.

### Rendering And Graphics

- `AGSLNonInteractableCells.kt` and `SKSLNonInteractableCells.kt` are a standout rendering idea. The repository keeps the same cell-shape shader logic across Android AGSL and Skiko SKSL targets, using a bitmap mask of live cells and letting the shader decide the final cell shape and fill.
- `GameOfLifeShape.kt` mirrors the same idea in OpenGL ES for the watchface stack: upload a cell-window texture, then shade alive cells as signed-distance-based round rectangles on the GPU. That gives the repository three aligned rendering paths for the same visual model.
- `GameOfLifeRenderer.kt` shows a strong wearable-specific rendering pattern. It converts time into stable Game of Life digit patterns, blends them with a surrounding soup, and also recolors complications based on the chosen simulation color so the watchface feels visually integrated instead of layered on top of a separate HUD theme.
- The rendering architecture is valuable because it treats "draw the cells" as a cross-platform visual primitive rather than re-implementing one-off per-cell painting for each host.

### Input And Controls

- `ComposeLife` is not input-heavy in the traditional arcade sense, but it does show a reusable product-shell idea: gameplay or simulation control state stays above the composables in controllers and preference state, while the rendering code remains mostly agnostic to specific Android event plumbing.
- The more durable input-adjacent value is in the custom navigation and DI shells rather than in gesture logic. That is still relevant for Android games or simulation tools with several panels, editors, or modal flows.

### UI, HUD, And Menus

- `docs/di.md` is one of the clearest reusable architecture notes in the repository. It combines Metro with Kotlin context parameters and explicit `Ctx` wrappers so deep Compose functions can receive dependencies without leaking full dependency signatures through every intermediate composable.
- `navigation/README.md` and `MutableBackstackNavigationController.kt` show a state-based navigation system that keeps all live entries in an `entryMap` and points to the current one explicitly. That is a useful alternative to fragment-era stacks or route-string-only approaches when an Android game needs screen or panel state to survive backstack movement cleanly.
- `ComposeLifeNavigation.kt` demonstrates how destination-specific transient state can be separated from serializable surrogates. That makes the navigation layer more explicit about what should survive restoration and what should be regenerated.
- `MainActivity.kt` plus the adaptive window APIs show a polished Compose shell with edge-to-edge handling, adaptive layout inputs, and centralized theme application rather than a thin activity around otherwise disconnected screens.

### Persistence And Data

- `PatternCollectionRepositoryImpl.kt` is a strong reference for content synchronization. It downloads remote pattern archives, hashes them with SHA-256, avoids reprocessing unchanged archives, updates synchronization state reactively, and keeps archive files inside a clear persisted-data structure.
- `PatternCollectionSync.kt` is a good Android background-work pattern. It turns user preferences directly into a unique periodic WorkManager job, including metered-vs-unmetered network constraints and in-place work updates instead of ad hoc duplicate scheduling.
- `PatternCollectionSyncWorker.kt` keeps the worker layer intentionally thin: Android-specific scheduling lives at the worker boundary while synchronization logic remains in the repository implementation.
- For Android game projects that want downloadable community content, pattern packs, daily levels, or remote catalog refresh, this repository provides a compact end-to-end example of how to keep sync logic inside shared modules and expose only a small Android scheduling seam.

### Android Platform Integration

- `ComposeLife` is unusually broad for a game-adjacent Android product. It covers mobile Android, Wear OS watchface and configuration, desktop, and web while still keeping one shared Kotlin core.
- `MainActivity.kt` shows good Android product-shell discipline: edge-to-edge, splash gating by real readiness, adaptive-window inputs, centralized theme updates, and explicit per-activity graph construction.
- The Wear stack goes beyond a token sample. `wear-watchface`, `wear-watchface-configuration`, `wear-watchface-wff-resources`, and the separate WFF version modules show a deeper Android form-factor integration surface than most Kotlin game repositories expose.
- `PatternCollectionSync` and `PatternCollectionSyncWorker` demonstrate how background content refresh can stay a first-class platform concern without contaminating the higher-level game or simulation logic.

### Performance And Memory

- `HashLifeAlgorithm.kt` is a strong algorithmic reference. It canonicalizes macro cells and memoizes next-generation computations across several caches, which is directly useful for any Kotlin simulation or grid-heavy project that needs structure sharing and reuse instead of brute-force stepping.
- `TemporalGameOfLifeState.kt` keeps tick buffering tight: timed ticks and manual-step ticks are merged with rendezvous buffering so computation only advances when the downstream consumer is ready.
- The AGSL, SKSL, and OpenGL paths all push final cell shaping to the GPU after a compact live-cell mask is prepared. That is a useful performance posture for large-grid rendering in Compose-hosted products.
- The repository also shows a more general performance lesson: reusable product state, simulation state, and GPU state are treated as distinct concerns instead of being coupled into one giant mutable UI model.

### Build, Release, And Testing

- `settings.gradle.kts` defines an `80`-module monorepo, which is unusually large for a game-adjacent Kotlin sample and explains why the repository is more useful as an architecture reference than as a tiny tutorial.
- `.github/workflows/ci.yml` is one of the strongest validation surfaces in the lab so far:
  - Android SDK matrix from `23` through `36`
  - Gradle managed device matrix across phones, tablets, desktop Android, and Wear
  - screenshot verification and auto-update hooks
  - baseline-profile generation
  - code coverage and artifact upload
  - website deployment workflow
- The repository contains `138` test-code files across common, JVM, Android host/shared, and screenshot test trees, which is a materially stronger verification story than most Android game samples.
- The biggest build caveat is platform-specific: the checked-in watchface solution resource names with `:` make the repository awkward to check out on Windows, so future work in this lab may need the same sanitized-export workaround unless upstream changes those test-resource filenames.

## Reusable Takeaways

- Compose-first Android products can still keep simulation loops explicit and lifecycle-bound without moving all logic into composables or `LaunchedEffect` blocks.
- One visual domain can be rendered coherently across Android, desktop, and wearable hosts by sharing the shader idea and changing only the host-specific wrapper.
- Metro plus context-parameter `Ctx` wrappers are a viable pattern for large Compose codebases that want DI without dependency leakage through every composable signature.
- Background content synchronization is much easier to reason about when repository logic stays shared and Android scheduling is kept to a small WorkManager bridge.
- Game-adjacent repositories become far more reusable when CI, screenshot verification, benchmarks, and platform-matrix testing are treated as product architecture rather than post-hoc maintenance.

## Evidence Summary

- `algorithm/src/jbMain/kotlin/com/alexvanyo/composelife/model/TemporalGameOfLifeState.kt` - explicit evolving simulation state, manual stepping, rate control, throughput metrics, and `Updatable` mutator
- `algorithm/src/jbMain/kotlin/com/alexvanyo/composelife/algorithm/ConfigurableGameOfLifeAlgorithm.kt` - runtime algorithm switching between naive and `HashLife`
- `algorithm/src/jbMain/kotlin/com/alexvanyo/composelife/algorithm/HashLifeAlgorithm.kt` - macro-cell canonicalization and memoized accelerated evolution
- `docs/di.md` - Metro plus context-parameter dependency-injection pattern for deep Compose trees
- `navigation/README.md` and `navigation/.../MutableBackstackNavigationController.kt` - state-based navigation with retained entry map and explicit current entry
- `ui-app/.../ComposeLifeNavigation.kt` - typed route values with serializable surrogates and transient state
- `app-impl/.../MainActivity.kt` - centralized Android shell, adaptive graph creation, splash gating, and `uiUpdatables`
- `ui-cells/.../AGSLNonInteractableCells.kt` and `SKSLNonInteractableCells.kt` - shared shader-backed cell rendering across Android and Skiko
- `opengl-renderer/.../GameOfLifeShape.kt` and `wear-watchface/.../GameOfLifeRenderer.kt` - OpenGL watchface rendering, cell-texture upload, and time-as-pattern digits
- `data/.../PatternCollectionRepositoryImpl.kt`, `PatternCollectionSync.kt`, and `PatternCollectionSyncWorker.kt` - remote pattern archive sync, hash dedupe, and WorkManager-backed refresh scheduling
- `.github/workflows/ci.yml` - deep Android, Wear, screenshot, baseline-profile, and artifact workflow surface

## Risks Or Limits

- The repository is productized and deep, but it is not a conventional "engine" reference. Teams looking only for raw gameplay or engine-loop code may find the shell and infrastructure heavier than needed.
- Local verification in this lab still depends on workarounds because the repository contains Windows-incompatible colon-named resource paths.
- Even after the sanitized export workaround, the build requires Java `17+` and in practice documents `JDK 21+`, so current lab verification remains partially environmental.
- The repository is a Game of Life simulator and watchface, so some domain-specific data and UI choices are naturally more specialized than a general-purpose engine.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `android-game`
- Focus tags: `2d`, `android`, `multiplatform`, `shader`, `ui-hud`, `save-load`, `testing`, `performance`
- Follow-up needed:
  - if the lab revisits this repository, do it in a JDK `21` plus Android SDK-ready environment and isolate one subsystem such as the `HashLife` versus naive algorithm seam, the AGSL/SKSL/OpenGL rendering family, the custom navigation plus DI shell, the pattern-sync pipeline, or the Wear watchface stack instead of reopening the whole monorepo broadly
