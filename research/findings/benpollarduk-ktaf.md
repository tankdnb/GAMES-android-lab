# Research Note

## Repository Snapshot

- Repository: `benpollarduk/ktaf`
- Source URL: [https://github.com/benpollarduk/ktaf](https://github.com/benpollarduk/ktaf)
- Owner: `benpollarduk`
- Batch ID: [`BATCH-2026-06-04-V`](../batches/BATCH-2026-06-04-V.md)
- Type: `library-sdk`
- License: `MIT`
- Selection date: `2026-06-04`
- Last pushed at selection: `2025-05-08`
- Stars at selection: `13`
- Default branch at selection: `main`
- Investigated commit: `d98b84e69eb79aafdb5fa32be2ad4935a63a4519`
- Research status: `accepted`
- Build mode: `static-review + gradle-help-failed-java8-sonarqube-plugin-needs-java11`
- Catalog card: [catalog/projects/benpollarduk-ktaf.md](../../catalog/projects/benpollarduk-ktaf.md)

## Why This Repository Was Selected

- `benpollarduk/ktaf` was the last remaining exact-license-verified repository in the current compact shortlist.
- The main question for this pass was whether `ktaf` added enough distinct value after the already researched `ktvn`, or whether it should stay only as a comparison note.
- It does add distinct value: `ktvn` is a branching visual-novel runtime, while `ktaf` is a parser-driven text-adventure framework centered on rooms, exits, items, conversations, and swappable IO/rendering hosts.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: custom Kotlin JVM text-adventure framework
- Rendering stack:
  - ANSI console frame builders
  - HTML frame builders for a Ktor host
  - Swing example host layered over the same core runtime
- Android target: indirect; no Android module is checked in, but the parser runtime, room/item/conversation systems, and host-IO seam transfer well to narrative-heavy or exploration-heavy Android games
- Build system: Gradle multi-project JVM build with a core library, example-content module, console/Swing/Ktor example hosts, publishing, docs, and release automation
- Repository layout summary:
  - `ktaf/` contains the core runtime, assets, command interpretation, rendering, discovery, and utilities
  - `ktaf-example/` contains sample game content assembled from reusable regions, rooms, NPCs, and items
  - `app-ktaf-example-console/`, `app-ktaf-example-swing/`, and `app-ktaf-example-ktor/` provide three host shells for the same runtime
  - `docs/` and `.github/workflows/` cover authored docs, sequence diagrams, and release automation
- Source footprint:
  - total files counted in repository: `317`
  - Kotlin/Java files counted in repository: `272`
  - test files found: `94`
  - meaningful automated tests found: `94`
- Key modules reviewed:
  - `README.md`
  - `settings.gradle.kts`
  - `gradle.properties`
  - `ktaf/build.gradle.kts`
  - `app-ktaf-example-console/build.gradle.kts`
  - `app-ktaf-example-swing/build.gradle.kts`
  - `app-ktaf-example-ktor/build.gradle.kts`
  - `.github/workflows/main-ci.yml`
  - `.github/workflows/main-release.yml`
  - `ktaf/src/main/kotlin/com/github/benpollarduk/ktaf/logic/Game.kt`
  - `ktaf/src/main/kotlin/com/github/benpollarduk/ktaf/logic/GameExecutor.kt`
  - `ktaf/src/main/kotlin/com/github/benpollarduk/ktaf/utilities/templates/GameTemplate.kt`
  - `ktaf/src/main/kotlin/com/github/benpollarduk/ktaf/utilities/RegionMaker.kt`
  - `ktaf/src/main/kotlin/com/github/benpollarduk/ktaf/utilities/OverworldMaker.kt`
  - `ktaf/src/main/kotlin/com/github/benpollarduk/ktaf/assets/locations/Room.kt`
  - `ktaf/src/main/kotlin/com/github/benpollarduk/ktaf/assets/Item.kt`
  - `ktaf/src/main/kotlin/com/github/benpollarduk/ktaf/conversations/Conversation.kt`
  - `ktaf/src/main/kotlin/com/github/benpollarduk/ktaf/interpretation/InputInterpreter.kt`
  - `ktaf/src/main/kotlin/com/github/benpollarduk/ktaf/interpretation/MovementCommandInterpreter.kt`
  - `ktaf/src/main/kotlin/com/github/benpollarduk/ktaf/io/IOConfiguration.kt`
  - `ktaf/src/main/kotlin/com/github/benpollarduk/ktaf/io/configurations/AnsiConsoleConfiguration.kt`
  - `ktaf/src/main/kotlin/com/github/benpollarduk/ktaf/rendering/frames/FrameBuilderCollection.kt`
  - `ktaf/src/main/kotlin/com/github/benpollarduk/ktaf/logic/discovery/GameCatalogResolver.kt`
  - `app-ktaf-example-ktor/src/main/kotlin/com/github/benpollarduk/ktaf/ktor/io/KtorConfiguration.kt`
  - `app-ktaf-example-ktor/src/main/kotlin/com/github/benpollarduk/ktaf/ktor/plugins/Routing.kt`
  - `ktaf-example/src/main/kotlin/com/github/benpollarduk/ktaf/example/ExampleGame.kt`
  - `ktaf/src/test/kotlin/com/github/benpollarduk/ktaf/logic/GameExecutorTest.kt`
  - `ktaf/src/test/kotlin/com/github/benpollarduk/ktaf/logic/discovery/GameCatalogResolverTest.kt`
  - `ktaf/src/test/kotlin/com/github/benpollarduk/ktaf/interpretation/InputInterpreterTest.kt`

## Build And Runtime Notes

- The repository was investigated through static review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeds in the lab and reports Gradle `8.3` running on Java `8`.
- `cmd /c gradlew.bat help --no-daemon` fails during configuration because the applied SonarQube plugin path resolves only Java `11` variants while the current lab machine still exposes Java `8`.
- The inspected repository itself still looks intentionally maintained around a JDK `11` floor rather than around the lab machine:
  - `.github/workflows/main-ci.yml` sets up Temurin JDK `11`
  - `.github/workflows/main-release.yml` also publishes on JDK `11`
  - the core module targets Java and Kotlin language level `9`
  - the build applies `explicitApi`, ktlint, Detekt, JaCoCo, Dokka, Shadow, and Maven publishing
- No runtime launch was attempted.

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `1`
- Implementation depth: `3`
- Code clarity: `3`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - `ktaf` is not Android-native, but it is a complete Kotlin game-framework/library rather than a toy sample
  - it complements `ktvn` instead of duplicating it by focusing on parser-driven exploration, room graphs, item interactions, and conversation flow
  - the strongest reusable value is the separation between authored world/content, command interpretation, frame-building, and concrete host IO

## Interesting Findings

### Engine Architecture And Core Loop

- `Game.kt` keeps one central runtime container around the player, overworld, interpreter, end conditions, and current frame, while host-specific rendering and input stay behind `IOConfiguration`.
- `IOConfiguration` plus `FrameBuilderCollection` is the most reusable seam in the repo: the same runtime can run through an ANSI console, a Swing shell, or a Ktor-backed HTML host without changing the game content model.
- `GameExecutor.kt` and `GameTemplate.kt` keep authored content separate from execution ownership. A template instantiates a new game for a specific host configuration, and the executor decides whether the experience exits or loops back to the title.

### Rendering And Graphics

- `FrameBuilderCollection`, the ANSI builders, the HTML builders, and the grid-map builders show a clean frame-oriented presentation model where each game state produces a typed frame instead of writing directly to one UI toolkit.
- `AnsiConsoleConfiguration.kt` is a simple but complete terminal-host reference: it clears the screen, renders a frame, places the cursor, and toggles cursor visibility according to whether input is allowed.
- The HTML host keeps the same frame-oriented model and auto-generates room and region maps, which is useful as a reminder that even a text-adventure runtime can keep map rendering and scene rendering behind a single presentation contract.

### Gameplay Systems

- `RegionMaker.kt` and `OverworldMaker.kt` are strong small-world authoring references. Rooms are placed in 3D coordinates, normalized into a matrix, and reciprocal exits are auto-linked so content authors do not need to wire both directions manually every time.
- `Room.kt` is a compact but useful adventure-game object model: rooms own exits, NPCs, items, visibility filtering, visit tracking, and cross-target lookup for items, characters, and exits through one parser-facing surface.
- `Item.kt`, `InteractionResult.kt`, and the room-target lookup flow show a practical interaction pattern where items can morph, targets can be consumed, and the gameplay layer can stay text-first without scattering one-off condition checks.
- `Conversation.kt` adds a lighter conversation model than `ktvn`: paragraph-by-paragraph dialogue, response choices, log capture, and instruction-driven paragraph jumps without requiring a full visual-novel step DSL.

### Input And Controls

- `InputInterpreter.kt` composes a chain of specialized interpreters instead of one giant parser. That is a useful pattern for command-heavy games because movement, item use, conversation, global commands, and custom commands stay modular.
- `MovementCommandInterpreter.kt` does more than parse `N/E/S/W/U/D`: it also derives contextual help from the current room so the visible command list reflects which exits are actually traversable.
- `Game.displayHelp()` combines static and contextual command help, which is a transferable idea for Android command-driven or menu-driven games that want UI affordances generated from the current domain state.

### UI, HUD, And Menus

- The title/about/help/scene/conversation/map/completion/game-over builders form a full frame family instead of one generic text page, which keeps presentation logic structured even in a text-heavy framework.
- The Ktor and Swing example hosts show two different product-shell directions around the same core: a minimal browser-delivered HTML host and a desktop shell that can evolve into a richer tool or prototype UI.
- The automatic map frames are worth noting because they keep navigational affordances as part of the framework itself instead of leaving every game to reinvent map formatting.

### Tooling And Content Pipeline

- `GameCatalogResolver.kt` is a useful extensibility reference: it scans jars, finds `GameTemplate` implementations through reflection, and builds a catalog of discoverable games without hardcoding one title into the host app.
- The example module plus the three host apps show a good repo structure for a small framework: separate the publishable runtime, the sample authored content, and the executable shells.
- The checked-in `docs/mkdocs` documentation set and sequence diagrams are also valuable process examples for small JVM game libraries that want to stay teachable rather than repository-internal only.

### Build, Release, And Testing

- The module build has more discipline than the small star count suggests: `explicitApi`, ktlint, Detekt, JaCoCo, Dokka, Shadow, Maven publishing, GitHub Packages publication, and docs-site regeneration are all wired in.
- The visible test surface is broad for a niche text-adventure framework. There are tests across commands, interpreters, conversations, rendering builders, room/region utilities, discovery, and core executor behavior.
- The release workflow also rebuilds and pushes both the authored docs site and API docs to separate repositories, which is a reusable small-library maintenance pattern.

## Reusable Takeaways

- Parser-driven games benefit from separating command interpretation, world/content modeling, and output hosting instead of letting one UI shell own every rule.
- Coordinate-based room makers that normalize layout and auto-link inverse exits are a practical content-authoring helper for exploration-heavy games.
- Frame-builder presentation seams are useful even outside graphics-heavy engines; they let one runtime support console, desktop, browser, and potentially Android hosts without rewriting core gameplay logic.
- Dynamic template discovery through jars is a practical pattern when the runtime should stay separate from authored content packs or examples.

## Evidence Summary

- `Game.kt`, `GameExecutor.kt`, and `GameTemplate.kt` - central runtime ownership separated from authored content and concrete hosts
- `IOConfiguration.kt` and `FrameBuilderCollection.kt` - host/input/render seam around typed frames
- `AnsiConsoleConfiguration.kt` and the Ktor/Swing example hosts - multiple concrete shells for the same runtime
- `RegionMaker.kt`, `OverworldMaker.kt`, and `Room.kt` - room-graph authoring, reciprocal-exit linking, visit tracking, and target lookup
- `Item.kt`, `InteractionResult.kt`, and `Conversation.kt` - item interaction flow plus lightweight NPC dialogue branching
- `InputInterpreter.kt` and `MovementCommandInterpreter.kt` - layered parser architecture with contextual command help
- `GameCatalogResolver.kt` - jar-based discovery of authored game templates
- `ktaf/build.gradle.kts`, the GitHub workflows, and the broad `ktaf/src/test` tree - small-library publishing/docs discipline with real subsystem coverage

## Risks Or Limits

- The repository is JVM-only in the checked-in state and does not include any Android host implementation.
- The architecture is intentionally text-adventure-specific, so the direct transfer value is lower for graphics-heavy Android games.
- The build still carries some weight and duplication for a small framework; even `help` configures analysis and publishing plugins up front.
- `KtorConfiguration.kt` and `Routing.kt` rely on singleton state and polling loops, which is fine for a small example host but not a strong production-server pattern.
- `GameCatalogResolver.kt` instantiates templates during discovery, so content discovery can execute game-construction code and the README is correct to call the approach volatile.
- Local validation in the lab is still blocked by the Java `8` machine, while the inspected repository expects at least JDK `11` for normal Gradle configuration.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `library-sdk`
- Focus tags: `ui-hud`, `input`, `asset-pipeline`, `testing`
- Follow-up needed:
  - if the lab revisits this repository, rerun Gradle discovery or selected tests in a JDK `11+` environment
  - the most useful narrow follow-up targets would be the frame-builder plus IO seam, the jar-discovery path, or the room/item/conversation parser surface rather than reopening the whole repository blindly
