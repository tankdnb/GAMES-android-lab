# Research Note

## Repository Snapshot

- Repository: `benpollarduk/ktvn`
- Source URL: [https://github.com/benpollarduk/ktvn](https://github.com/benpollarduk/ktvn)
- Owner: `benpollarduk`
- Batch ID: [`BATCH-2026-06-04-G`](../batches/BATCH-2026-06-04-G.md)
- Type: `library-sdk`
- License: `MIT`
- Selection date: `2026-06-04`
- Last pushed at selection: `2025-05-08`
- Stars at selection: `20`
- Default branch at selection: `main`
- Investigated commit: `e7dc751aa3ebb65aad3cf7351579ee93b681143a`
- Research status: `accepted`
- Build mode: `static-review + gradle-help-failed-java8-sonarqube-plugin-needs-java11`
- Catalog card: [catalog/projects/benpollarduk-ktvn.md](../../catalog/projects/benpollarduk-ktvn.md)

## Why This Repository Was Selected

- `ktvn` was the next verified candidate in the compact explicit-license shortlist and offered a better signal-to-yield ratio than the remaining low-signal engine alternative.
- The repository is a Kotlin visual-novel framework rather than a direct Android game, but it has a substantial DSL, a reusable story runtime, explicit persistence seams, and multiple host adapters.
- The main question for this pass was whether `ktvn` was too JVM-specific for the lab. It is JVM-first, but the architecture is reusable enough for dialogue-heavy Android games to justify keeping it in the main catalog.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: custom Kotlin JVM visual-novel framework with pluggable `GameEngine` hosts
- Rendering stack: renderer-agnostic core with included ANSI-console and Swing prototype hosts
- Android target: indirect; no Android module is checked in, but the narrative runtime, persistence, and adapter boundaries transfer cleanly to Kotlin Android games
- Build system: Gradle multi-project JVM build with separate core library, examples, console prototyper, Swing prototyper, publishing, and docs workflows
- Repository layout summary:
  - `ktvn/` contains the core DSL, runtime, adapters, persistence, discovery, and default console engine
  - `ktvn-examples/` contains packaged example visual novels
  - `app-ktvn-prototyper-console/` and `app-ktvn-prototyper-swing/` provide two concrete host shells
  - `docs/` and `.github/workflows/` cover documentation and release automation
- Source footprint:
  - total files counted in repository: `300`
  - Kotlin/Java files counted in repository: `254`
  - Kotlin files in `ktvn/src/main`: `141`
  - Kotlin files in `ktvn-examples/src/main`: `16`
- Test surface:
  - test files found: `48`
  - meaningful automated tests found: `48`
- Key modules reviewed:
  - `README.md`
  - `settings.gradle.kts`
  - `gradle.properties`
  - `ktvn/build.gradle.kts`
  - `ktvn-examples/build.gradle.kts`
  - `app-ktvn-prototyper-console/build.gradle.kts`
  - `app-ktvn-prototyper-swing/build.gradle.kts`
  - `.github/workflows/main-ci.yml`
  - `.github/workflows/main-release.yml`
  - `.github/workflows/publish-docs.yml`
  - `ktvn/src/main/kotlin/com/github/benpollarduk/ktvn/structure/Story.kt`
  - `ktvn/src/main/kotlin/com/github/benpollarduk/ktvn/structure/Chapter.kt`
  - `ktvn/src/main/kotlin/com/github/benpollarduk/ktvn/structure/Scene.kt`
  - `ktvn/src/main/kotlin/com/github/benpollarduk/ktvn/structure/StepIdentifierMapper.kt`
  - `ktvn/src/main/kotlin/com/github/benpollarduk/ktvn/structure/steps/Then.kt`
  - `ktvn/src/main/kotlin/com/github/benpollarduk/ktvn/structure/steps/Decision.kt`
  - `ktvn/src/main/kotlin/com/github/benpollarduk/ktvn/structure/steps/Interactive.kt`
  - `ktvn/src/main/kotlin/com/github/benpollarduk/ktvn/logic/VisualNovel.kt`
  - `ktvn/src/main/kotlin/com/github/benpollarduk/ktvn/logic/Game.kt`
  - `ktvn/src/main/kotlin/com/github/benpollarduk/ktvn/logic/GameExecutor.kt`
  - `ktvn/src/main/kotlin/com/github/benpollarduk/ktvn/logic/ProgressionController.kt`
  - `ktvn/src/main/kotlin/com/github/benpollarduk/ktvn/logic/ProgressionMode.kt`
  - `ktvn/src/main/kotlin/com/github/benpollarduk/ktvn/logic/configuration/DynamicGameConfiguration.kt`
  - `ktvn/src/main/kotlin/com/github/benpollarduk/ktvn/logic/adapters/dynamic/DynamicGameAdapter.kt`
  - `ktvn/src/main/kotlin/com/github/benpollarduk/ktvn/logic/engines/GameEngine.kt`
  - `ktvn/src/main/kotlin/com/github/benpollarduk/ktvn/logic/engines/ansiConsole/AnsiConsoleGameEngine.kt`
  - `ktvn/src/main/kotlin/com/github/benpollarduk/ktvn/io/game/GameSave.kt`
  - `ktvn/src/main/kotlin/com/github/benpollarduk/ktvn/io/restore/RestorePoint.kt`
  - `ktvn/src/main/kotlin/com/github/benpollarduk/ktvn/io/tracking/identifier/StepIdentifierTracker.kt`
  - `ktvn/src/main/kotlin/com/github/benpollarduk/ktvn/io/discovery/VisualNovelCatalogResolver.kt`
  - `ktvn-examples/src/main/kotlin/com/github/benpollarduk/ktvn/examples/theFateOfMorgana/TheFateOfMorgana.kt`
  - `app-ktvn-prototyper-console/src/main/kotlin/com/github/benpollarduk/ktvn/prototyper/console/Main.kt`
  - `app-ktvn-prototyper-swing/src/main/kotlin/com/github/benpollarduk/ktvn/prototyping/swing/App.kt`
  - `ktvn/src/test/kotlin/com/github/benpollarduk/ktvn/logic/GameExecutorTest.kt`
  - `ktvn/src/test/kotlin/com/github/benpollarduk/ktvn/logic/ProgressionControllerTest.kt`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeds and reports Gradle `8.3` on the current lab machine.
- `cmd /c gradlew.bat help --no-daemon` fails because the current lab machine still exposes Java `8`, while the resolved SonarQube Gradle plugin variant requires at least Java `11`.
- The inspected repository itself still looks intentionally maintained around a JDK `11` floor rather than around the Java `8` lab environment:
  - `.github/workflows/main-ci.yml` and `main-release.yml` both set up JDK `11`
  - the module builds target JVM / Java language level `9`
  - the core build applies `explicitApi`, JaCoCo, ktlint, Detekt, Dokka, Shadow, and Maven publishing
- No runtime launch was attempted.

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `1`
- Implementation depth: `3`
- Code clarity: `3`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - `ktvn` is not Android-native, but it is a real Kotlin game-framework/library with a richer architecture surface than a toy sample.
  - The most reusable value is the separation between content DSL, runtime flow, host engine adapters, progression control, and persistence.
  - For Android work, it is best treated as a narrative-runtime and product-shell reference rather than as a renderer or engine baseline.

## Interesting Findings

### Engine Architecture And Core Loop

- `Story.kt`, `Chapter.kt`, and `Scene.kt` form a clean hierarchical runtime: story execution advances chapter-by-chapter, scene-by-scene, and step-by-step, while each layer can redirect flow via typed results such as `SelectChapter`, `SelectScene`, `GotoStep`, `End`, and `Clear`.
- `VisualNovel.kt` keeps a `Story` and `GameConfiguration` together as the discoverable unit, and `StepIdentifierMapper` deterministically assigns chapter/scene/step coordinates to every step at startup. That is a strong pattern for story-heavy games that need stable references for resume, skip, analytics, or debug tooling.
- `Game.kt` and `GameExecutor.kt` keep execution state, cancellation, ending collection, and elapsed-time tracking outside the story DSL itself. The content model stays declarative while the game wrapper owns run control.

### Gameplay Systems

- The step DSL is more capable than a plain script wrapper. `Then.kt`, `Decision.kt`, `Conditional.kt`, `Interactive.kt`, and the `StepResult` variants provide named jumps, branching by flag state, and mini-game or external-component hooks without hardwiring those features into one renderer or one app shell.
- `Scene.kt` treats content progression as a list of executable `Step` objects and computes skippability through `StepTracker` rather than through ad hoc UI state. That makes auto/skip behavior part of the runtime contract instead of a surface-only feature.
- `TheFateOfMorgana.kt` and the example chapter/scene files show one practical content-scaling pattern: keep the visual novel itself very small and assemble it from chapter/scene functions plus a shared asset store instead of putting the whole story in one giant script file.

### UI, HUD, And Menus

- `GameEngine.kt` is the key UI seam. The story runtime emits typed events for speak, narrate, ask, move, animate, clear, chapter/scene transitions, and audio, while host implementations decide how to render those events.
- `AnsiConsoleGameEngine.kt` is a useful minimal host reference: it turns progression into sequenced text frames, uses ANSI cursor control to simulate a simple UI, and maps step acknowledgment plus answer entry through one `ProgressionController`.
- `app-ktvn-prototyper-swing/App.kt` shows a richer debug/prototyping shell where one engine instance drives a Swing UI with flag viewers, resource trackers, progression controls, and direct restore-point jumping. That is a strong reference for internal tooling around a narrative game runtime.

### Persistence And Data

- Persistence is deliberately split by concern instead of one giant snapshot. `GameSave` tracks meta-progress such as play time and endings reached, `RestorePoint` captures current flags plus story position, and `StepIdentifierTracker` records which steps have already been seen for skip behavior.
- `StepIdentifierTracker.kt` is especially reusable for narrative games: deterministic step identifiers give one compact way to persist read/unread state across runs without serializing the whole scene graph.
- `ProgressionController.kt` centralizes `WaitForConfirmation`, `Skip`, and `Auto` flow with cancellation support. That is a practical small-runtime pattern for dialogue-heavy games that need shared progression semantics across different front ends.

### Tooling And Content Pipeline

- `VisualNovelCatalogResolver.kt` is a strong extensibility pattern for desktop or tool-driven workflows. It scans jars, loads `VisualNovel` subclasses via a class loader, and builds a catalog from discovered stories instead of hardcoding one executable entry point.
- `app-ktvn-prototyper-console/Main.kt` shows how that catalog surface can be used operationally: if a jar path is passed in, the app loads one or more visual novels from the artifact and lets the user select which one to run.
- The repository structure itself is reusable: keep the core runtime, examples, and prototype hosts in separate modules so story teams can read runnable examples without polluting the publishable library surface.

### Build, Release, And Testing

- The checked-in build and release discipline is stronger than the star count suggests. The core module uses `explicitApi`, ktlint, Detekt, JaCoCo, Dokka, Shadow, and Maven publishing; release workflows also update separate docs and API-docs repositories.
- The test surface is broad for a niche framework. `GameExecutorTest.kt`, `ProgressionControllerTest.kt`, `StoryTest.kt`, `SceneTest.kt`, `AnsiConsoleGameEngineTest.kt`, serializer tests, and layout/text tests give concrete coverage around runtime flow, adapters, persistence, and text sequencing.
- The current build layout duplicates a lot of configuration across modules, and even lightweight `gradlew help` configures analysis/publishing plugins up front. That raises config weight, but it also makes the repository a useful example of how small JVM game libraries can standardize publication and docs automation.

## Reusable Takeaways

- Story-heavy games benefit from separating content DSL, execution runtime, host UI adapters, and persistence rather than letting UI screens own all narrative state directly.
- Deterministic step identifiers are a compact way to implement skip-seen-content behavior, restore points, and debug jumps.
- A game-facing engine interface can keep one narrative core portable across very different hosts, from a console prototype to a richer desktop tool or a future Android shell.
- External story discovery through jar scanning is a practical pattern for toolchains, modding, or content packs when the runtime should stay separate from authored content.

## Evidence Summary

- `Story.kt`, `Chapter.kt`, `Scene.kt`, and `StepResult.kt` - hierarchical story runtime with typed flow redirection
- `VisualNovel.kt` and `StepIdentifierMapper.kt` - story/configuration packaging and deterministic step mapping
- `Game.kt`, `GameExecutor.kt`, and `ProgressionController.kt` - execution ownership, cancellation, progression modes, and save/replay flow
- `DynamicGameConfiguration.kt`, `DynamicGameAdapter.kt`, and `GameEngine.kt` - host-agnostic adapter boundary for UI/runtime integration
- `AnsiConsoleGameEngine.kt` and `app-ktvn-prototyper-swing/App.kt` - concrete prototype hosts for the same core runtime
- `GameSave.kt`, `RestorePoint.kt`, and `StepIdentifierTracker.kt` - split persistence model for progress, current position, and seen-content tracking
- `VisualNovelCatalogResolver.kt` and console `Main.kt` - jar-based visual-novel discovery and launch flow
- `.github/workflows/*.yml` plus the `ktvn/src/test` tree - CI/release/docs automation and meaningful subsystem coverage

## Risks Or Limits

- The repository is JVM-first and ships no Android host module, so its Android transfer value is architectural rather than direct.
- `README.md` still explicitly says the DSL is in the early stages and may change, which lowers confidence in long-term API stability.
- The most visible host implementations are console and Swing prototypes, so mobile-first UX patterns would still need substantial Android-specific adaptation.
- Local build confirmation in the lab is blocked by the Java `8` machine, while the inspected repository expects at least JDK `11` for normal Gradle configuration.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `library-sdk`
- Focus tags: `ui-hud`, `save-load`, `testing`
- Follow-up needed:
  - if the lab revisits this repository, rerun Gradle discovery or selected tests in a JDK `11+` environment
  - the most useful narrow follow-up targets would be the story/runtime flow boundary, the step-tracker persistence model, or the jar-based visual-novel discovery surface
