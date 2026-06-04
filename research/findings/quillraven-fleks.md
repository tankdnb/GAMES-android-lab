# Research Note

## Repository Snapshot

- Repository: `Quillraven/Fleks`
- Source URL: [https://github.com/Quillraven/Fleks](https://github.com/Quillraven/Fleks)
- Owner: `Quillraven`
- Batch ID: [`BATCH-2026-06-04-N`](../batches/BATCH-2026-06-04-N.md)
- Type: `library-sdk`
- License: `MIT`
- Selection date: `2026-06-04`
- Last pushed at selection: `2026-05-14`
- Stars at selection: `258`
- Default branch at selection: `master`
- Investigated commit: `c332ffc04b2b2db7f362dda7c5541b00e9ef4658`
- Research status: `accepted`
- Build mode: `static-review + gradle-help-failed-no-jdk`
- Catalog card: [catalog/projects/quillraven-fleks.md](../../catalog/projects/quillraven-fleks.md)

## Why This Repository Was Selected

- `Fleks` survived the explicit-license shortlist refresh and exact repository-level verification as one of the strongest remaining Kotlin game-development libraries with both healthy maintenance and clear reusable architecture value.
- The main question for this batch was whether the standalone ECS library still adds enough value after the earlier `korlibs/korge-fleks` integration pass. The answer is `accepted`: `korge-fleks` showed one concrete KorGE gameplay stack, while `Fleks` itself exposes the more reusable core ideas around entity storage, family queries, system scheduling, snapshots, and benchmarks.
- Compared with the remaining backlog, `Fleks` offered the best balance of popularity, recency, and expected architecture yield for teams building shared Kotlin gameplay cores, including Android-adjacent ones.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: standalone Kotlin Multiplatform ECS library
- Rendering stack: none; the repository is intentionally runtime-agnostic and meant to plug into a host engine, UI shell, or game loop
- Android target: indirect but strong; there is no dedicated Android module in the inspected tree, but the common ECS, snapshot, and scheduling patterns are directly reusable in shared Android game logic
- Build system: Gradle Kotlin DSL multiplatform build using custom `buildSrc` convention plugins, Dokka, publishing, signing, and JVM benchmarks
- Repository layout summary:
  - `src/commonMain/` contains the ECS core, world configuration DSL, component/entity/family services, and system types
  - `src/commonTest/` contains the primary test surface, including world, family, serialization, and system behavior tests
  - `src/jvmBenchmarks/` contains benchmark scenarios comparing Fleks against other ECS implementations
  - `.github/workflows/` contains build and publish automation
  - `buildSrc/` contains shared Gradle convention plugins for JVM, JS, native, publishing, and benchmark setup
- Source footprint:
  - total files counted in repository: `58`
  - Kotlin/KTS/Java files counted in repository: `48`
- Test surface:
  - test-like files counted in repository: `16`
- Key modules reviewed:
  - `ReadMe.md`
  - `settings.gradle.kts`
  - `build.gradle.kts`
  - `gradle.properties`
  - `gradle/libs.versions.toml`
  - `.github/workflows/build.yml`
  - `.github/workflows/publish.yml`
  - `src/commonMain/kotlin/com/github/quillraven/fleks/component.kt`
  - `src/commonMain/kotlin/com/github/quillraven/fleks/entity.kt`
  - `src/commonMain/kotlin/com/github/quillraven/fleks/family.kt`
  - `src/commonMain/kotlin/com/github/quillraven/fleks/system.kt`
  - `src/commonMain/kotlin/com/github/quillraven/fleks/world.kt`
  - `src/commonMain/kotlin/com/github/quillraven/fleks/worldCfg.kt`
  - `src/commonMain/kotlin/com/github/quillraven/fleks/OneShotComponentSystem.kt`
  - `src/commonTest/kotlin/com/github/quillraven/fleks/WorldTest.kt`
  - `src/commonTest/kotlin/com/github/quillraven/fleks/SerializationTest.kt`
  - `src/jvmBenchmarks/kotlin/com/github/quillraven/fleks/benchmark/fleks.kt`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeds in the inspected clone:
  - Gradle `8.14.5`
  - Launcher JVM `1.8.0_321`
- `cmd /c gradlew.bat help --no-daemon` fails in the lab because the current machine still has only a JRE and no Java compiler:
  - `No Java compiler found, please ensure you are running Gradle with a JDK`
- The inspected build surface expects a newer toolchain than the lab currently provides:
  - `.github/workflows/build.yml` runs the matrix build on JDK `11`
  - `.github/workflows/publish.yml` publishes on JDK `17`
  - the wrapper is pinned to Gradle `8.14.5`
- The repository also includes a reproducible benchmark posture rather than only correctness tests:
  - `src/jvmBenchmarks/` compares Fleks scenarios against Ashley and Artemis
  - README benchmark guidance and the benchmark module together make the performance claims auditable instead of purely rhetorical
- A small documentation caveat is worth keeping in memory:
  - the main README file is named `ReadMe.md`
  - in the Windows console used by this lab, some symbols in that file render with mojibake artifacts even though the underlying content is still readable
- No runtime launch was attempted inside the lab.

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `2`
- Implementation depth: `3`
- Code clarity: `3`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - `Fleks` is a compact but serious ECS core with a clear Kotlin-first API, meaningful tests, snapshots, benchmarks, and a multiplatform shape that can back Android gameplay logic even without shipping an Android renderer or host shell.
  - Its value is not in UI or platform code but in the reusable gameplay/runtime core it exposes for other engines and products.

## Interesting Findings

### Engine Architecture And Core Loop

- `src/commonMain/kotlin/com/github/quillraven/fleks/world.kt` keeps `World` intentionally small and explicit: systems, families, injectables, snapshots, and add/remove operations all live behind one runtime boundary instead of being spread across several managers that the host has to coordinate manually.
- `src/commonMain/kotlin/com/github/quillraven/fleks/worldCfg.kt` provides one of the better Kotlin DSL configuration seams in the lab. It stages injectables, families, and systems in order, while using a scoped current-world helper so setup code stays terse without turning into global singleton state.
- `src/commonMain/kotlin/com/github/quillraven/fleks/component.kt` and `entity.kt` show the core identity strategy clearly:
  - component and tag types receive stable integer IDs through `UniqueId`
  - entities carry both `id` and `version`, which makes recycling safe and easy to validate
  - component add/remove hooks are first-class rather than bolted on later
- `EntityService` and `ComponentService` use array-backed holders indexed by `entity.id` plus per-entity component bit masks. That is one of the strongest transferable implementation details in the repo because it keeps the ECS storage predictable and performance-oriented without exposing raw arrays to the public API.

### Gameplay Systems

- `src/commonMain/kotlin/com/github/quillraven/fleks/system.kt` exposes a clean system model:
  - `IntervalSystem` supports both `EachFrame` and fixed-step `Fixed(step)` scheduling
  - `onAlpha` exposes interpolation context cleanly for render-facing or smoothing code
  - `IteratingSystem` composes family queries, optional sorting, and per-entity iteration hooks without forcing every game to build its own loop scaffolding
- `src/commonMain/kotlin/com/github/quillraven/fleks/OneShotComponentSystem.kt` is especially reusable. It formalizes the common gameplay need for transient tags/components that should auto-remove at the end of an update instead of relying on ad hoc cleanup code spread across systems.
- `src/commonMain/kotlin/com/github/quillraven/fleks/family.kt` shows a mature family/query layer built around `all`, `none`, and `any` predicates, family hooks, dirty refreshes, and iteration-time delayed removals. That combination is a strong reference for ECS libraries that need predictable iteration semantics without forbidding entity mutation entirely.

### Persistence And Data

- `World.snapshot`, `snapshotOf`, `loadSnapshot`, and `loadSnapshotOf` make save/load a first-class capability of the ECS runtime rather than an afterthought left entirely to game-specific code.
- `src/commonTest/kotlin/com/github/quillraven/fleks/SerializationTest.kt` proves the snapshot story is real. It demonstrates polymorphic registration for components and tags, JSON round-tripping via `kotlinx.serialization`, and restoring a world from serialized state.
- This is one of the stronger durable findings in the lab because many ECS libraries stop at runtime queries and never show a clear persistence path.

### Performance And Memory

- `Family` caches matching entities in a mutable bag and refreshes only when dirty instead of rebuilding every query result every frame.
- The entity/component masks are bit-array based, so family membership checks reduce mostly to bitwise containment and intersection checks rather than reflective scans or repeated map lookups.
- Delayed removal during family iteration is handled centrally inside `EntityService`, which avoids unsafe mid-iteration invalidation and lets gameplay code stay simpler.
- `src/jvmBenchmarks/kotlin/com/github/quillraven/fleks/benchmark/fleks.kt` is valuable not just for claiming speed, but for preserving the benchmark shapes themselves: add/remove, simple iteration, and more complex entity patterns are all codified for repeatable comparison against Ashley and Artemis.

### Build, Release, And Testing

- `build.gradle.kts`, `gradle/libs.versions.toml`, and the custom `buildSrc` plugins show a disciplined KMP library workflow rather than a toy sample:
  - common, JS, JVM, and native convention plugins are separated
  - Dokka, Maven Central publishing, and signing are already wired
  - benchmark support is part of the normal build surface
- The test surface is meaningful for a small library:
  - `WorldTest.kt` covers ECS lifecycle behavior
  - `SerializationTest.kt` covers snapshots and restoration
  - other common tests cover family, system, and entity semantics
- `.github/workflows/build.yml` and `publish.yml` show a healthy maintenance posture for a niche library:
  - matrix build on Windows, Ubuntu, and macOS
  - separate publish path
  - explicit Gradle wrapper validation and cache setup

## Reusable Takeaways

- A Kotlin ECS library can stay host-agnostic and still provide high-value game-runtime features such as snapshots, fixed-step systems, and deterministic family iteration semantics.
- Array-backed component holders plus per-entity bit masks remain a strong baseline for compact, predictable ECS performance in Kotlin.
- One-shot components and tags deserve a first-class abstraction because they show up frequently in gameplay code.
- Benchmarks and serialization tests are worth treating as core library features, not optional extras, when building reusable gameplay-runtime infrastructure.

## Evidence Summary

- `src/commonMain/kotlin/com/github/quillraven/fleks/world.kt` and `worldCfg.kt` - explicit world boundary, configuration DSL, injectables, family/system registration, snapshot support
- `src/commonMain/kotlin/com/github/quillraven/fleks/component.kt` and `entity.kt` - component IDs, entity versioning, array-backed holders, delayed-removal-aware entity access
- `src/commonMain/kotlin/com/github/quillraven/fleks/family.kt` - bit-mask queries, dirty family refreshes, family hooks, iteration-time removal handling
- `src/commonMain/kotlin/com/github/quillraven/fleks/system.kt` and `OneShotComponentSystem.kt` - fixed-step scheduling, iterating systems, interpolation hook, one-shot cleanup pattern
- `src/commonTest/kotlin/com/github/quillraven/fleks/SerializationTest.kt` - snapshot serialization and restore behavior
- `src/jvmBenchmarks/kotlin/com/github/quillraven/fleks/benchmark/fleks.kt` - Ashley/Artemis comparison benchmarks
- `.github/workflows/build.yml` and `publish.yml` - active CI and publishing expectations

## Risks Or Limits

- Android relevance is indirect. `Fleks` is a gameplay/runtime core, not a drop-in Android engine, rendering framework, or shipped product shell.
- The repository does not cover input, rendering, audio, or Android platform glue; those concerns need a host runtime around it.
- Local validation in this lab still stops early because the machine lacks a full JDK.
- The benchmark posture is helpful, but the checked README still contains some older context and renders with encoding artifacts on this Windows console, so documentation polish lags slightly behind the core library quality.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `library-sdk`
- Focus tags: `multiplatform`, `ecs`, `save-load`, `performance`, `testing`
- Follow-up needed:
  - if the lab revisits this repository, do it in a JDK `11+` or `17+` environment and isolate one seam such as snapshot serialization, family hooks and delayed removals, or the benchmark comparisons against Ashley and Artemis
