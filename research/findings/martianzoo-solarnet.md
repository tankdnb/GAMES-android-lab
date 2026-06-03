# Research Note

## Repository Snapshot

- Repository: `MartianZoo/solarnet`
- Source URL: [https://github.com/MartianZoo/solarnet](https://github.com/MartianZoo/solarnet)
- Owner: `MartianZoo`
- Batch ID: [`BATCH-2026-06-04-C`](../batches/BATCH-2026-06-04-C.md)
- Type: `engine-framework`
- License: `Apache-2.0`
- Selection date: `2026-06-04`
- Last pushed at selection: `2026-06-01`
- Stars at selection: `16`
- Investigated commit: `2db507c5e1bf95098adba09c0a6f35043a81fc9e`
- Research status: `accepted`
- Build mode: `static-review + gradle-help-failed-java8-needs-java11`
- Catalog card: [catalog/projects/martianzoo-solarnet.md](../../catalog/projects/martianzoo-solarnet.md)

## Why This Repository Was Selected

- From the current licensed short backlog, `MartianZoo/solarnet` had the best balance of fresh activity, explicit Apache-2.0 licensing, and expected architecture yield.
- It looked more valuable than the remaining `StudioAdriatic/PGSGP` candidate for the lab's current needs because it is a Kotlin game-rules engine rather than a narrower platform-integration plugin.
- The main question for this pass was whether `solarnet` was mostly a one-off Terraforming Mars implementation or a reusable reference for Kotlin turn-based game logic, DSL-style rules modeling, and content-pipeline structure. It turned out to be a strong logic-core and specification-language reference.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: custom JVM rules engine plus the `Pets` specification language
- Rendering stack: no conventional renderer; the repository is logic-first and exposes a CLI/REPL shell around the game engine
- Android target: indirect; no Android runtime is present, but the logic-core and content-modeling patterns transfer well to Android board, card, and turn-based games
- Build system: multi-module Gradle Kotlin DSL JVM workspace
- Repository layout summary:
  - `pets` contains the specification language, parser, AST, and authority/data abstractions
  - `engine` contains the runtime type system, component graph, effect execution, and gameplay assembly
  - `canon` contains the official Terraforming Mars content pack as `.pets` and `.json5` resources
  - `repl` contains a command shell for inspecting and driving the engine
- Source footprint:
  - total files reviewed in repository: `271`
  - Kotlin/Java/KTS files reviewed across the repository: `217`
- Test surface:
  - test files found: `89`
  - meaningful parser, engine, invariant, full-game, and REPL tests found: `89`
- Key modules reviewed:
  - `README.md`
  - `docs/language-intro.md`
  - `docs/component-types.md`
  - `settings.gradle.kts`
  - `build.gradle.kts`
  - `gradle.properties`
  - `engine/build.gradle.kts`
  - `pets/build.gradle.kts`
  - `canon/build.gradle.kts`
  - `repl/build.gradle.kts`
  - `engine/src/main/java/dev/martianzoo/engine/Engine.kt`
  - `engine/src/main/java/dev/martianzoo/engine/Component.kt`
  - `engine/src/main/java/dev/martianzoo/engine/Effector.kt`
  - `engine/src/main/java/dev/martianzoo/engine/Changer.kt`
  - `engine/src/main/java/dev/martianzoo/engine/ApiTranslation.kt`
  - `engine/src/main/java/dev/martianzoo/tfm/engine/TfmGameplay.kt`
  - `engine/src/main/java/dev/martianzoo/types/MClass.kt`
  - `pets/src/main/java/dev/martianzoo/data/ClassDeclaration.kt`
  - `pets/src/main/java/dev/martianzoo/pets/ClassParsing.kt`
  - `pets/src/main/java/dev/martianzoo/tfm/api/TfmAuthority.kt`
  - `canon/src/main/java/dev/martianzoo/tfm/canon/Canon.kt`
  - `engine/src/test/java/dev/martianzoo/tfm/engine/CanonInvariantsTest.kt`
  - `engine/src/test/java/dev/martianzoo/tfm/engine/games/Game20230521Test.kt`
  - `repl/src/test/java/dev/martianzoo/tfm/repl/ReplSessionTest.kt`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeds and reports Gradle `8.10` on a Java `8` launcher.
- `cmd /c gradlew.bat help --no-daemon --stacktrace` fails during project configuration because the current lab machine still exposes Java `8`, while the resolved KSP plugin already requires at least JVM `11`.
- The checked-in build surface shows the repository expects a modern JVM setup beyond that immediate blocker:
  - the root `build.gradle.kts` configures `jvmToolchain(21)` for Kotlin JVM subprojects
  - the root plugins pin Kotlin JVM `2.1.20`
  - `engine/build.gradle.kts` applies Dagger `2.55` plus KSP `2.1.20-1.0.32`
  - `repl/build.gradle.kts` packages the shell with `shadowJar`
- No runtime launch was attempted.

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `2`
- Implementation depth: `3`
- Code clarity: `2`
- Novelty: `3`
- Overall verdict: `accepted`
- Why:
  - `solarnet` is one of the stronger pure-logic references in the lab so far: it shows how to keep a dense board-game ruleset out of UI code and encode special cases through declarative classes, effects, and tasks.
  - The repository also demonstrates a clean split between reusable runtime, canonical data pack, and operator tooling, which is highly reusable for Android teams building content-heavy turn-based games.
  - Its Android relevance is architectural rather than direct, but the engine/content/testing patterns are distinctive enough to merit catalog inclusion.

## Interesting Findings

### Engine Architecture And Core Loop

- `engine/.../Engine.kt` is a strong assembly reference. `Engine.newGame(setup)` builds a Dagger graph for shared game services and per-player subcomponents instead of letting one mutable singleton object own everything.
- `engine/.../ApiTranslation.kt` and `tfm/engine/TfmGameplay.kt` show a useful layering pattern for rules-heavy games: keep a generic execution core underneath, then expose a game-specific ergonomic facade for common actions such as playing cards, paying costs, or advancing phases.
- `engine/.../Component.kt` and `types/MClass.kt` are the most distinctive architectural pieces in the repository. Declarative class definitions are loaded into a richer runtime type system that can resolve inheritance, defaults, dependencies, invariants, and effect inheritance before gameplay starts.
- `engine/.../Effector.kt` turns declarative effects into queued tasks. Instead of hardcoding most reactions in gameplay classes, the runtime derives active effects from components and uses triggers such as gain/remove events to emit follow-up work.
- `engine/.../Changer.kt` shows a useful integrity pattern: game-state changes are applied through one player-scoped mutator that can reject invalid edits, log causes, and recursively deal with dependent removals when constraints are violated.

### Gameplay Systems

- `docs/language-intro.md` describes the core design clearly: game state is a multiset of components, and gameplay proceeds by adding, removing, transmuting, and tasking those components rather than by mutating a traditional entity object graph.
- `docs/component-types.md` shows how far the component model goes. Players, tags, cards, resources, tiles, areas, and ownership relationships are all modeled through the same type/dependency system rather than through several unrelated domain hierarchies.
- `pets/.../ClassDeclaration.kt` and `types/MClass.kt` together show a powerful pattern for card/board games with many exceptions: keep declarations inert, then load them into a richer semantic model where defaults, owner replacement, and inherited effects can be compiled once.
- `engine/.../Effector.kt` plus `engine/.../ApiTranslation.kt` give the engine a reactive rules shape that is well suited to cards, milestones, map areas, and other conditional content with lots of triggered side effects.
- `engine/src/test/java/dev/martianzoo/tfm/engine/games/Game20230521Test.kt` is especially valuable. It scripts a long real game using readable gameplay commands and assertions, which is a very strong reference for how to verify dense turn-based rules without relying only on tiny unit tests.

### Persistence And Data

- `pets/.../TfmAuthority.kt` is a clean content-source abstraction. The runtime asks an authority for class declarations, definitions, and extra classes instead of hardcoding one canonical data source.
- `canon/.../Canon.kt` demonstrates a strong separation between runtime and shipped content: the official Terraforming Mars implementation is just one authority backed by `.pets` and `.json5` resources.
- The content pack split is particularly reusable for Android teams. A mobile client can keep the game UI/product shell separate from a shared rules library and a swappable content bundle, which makes DLC, variants, or ruleset experiments easier to manage.

### Tooling, REPL, And Content Pipeline

- `pets/.../ClassParsing.kt` shows a surprisingly rich Kotlin DSL/content pipeline. Nested declarations, dependencies, defaults, effects, actions, invariants, and docstrings are all parsed into a domain declaration model instead of being scattered across hand-coded classes.
- `canon` keeps canonical `.pets` and `.json5` resources inside the repository as first-class assets, which is a good example of treating rules content as versioned data rather than as hardcoded implementation detail.
- `repl/src/test/java/dev/martianzoo/tfm/repl/ReplSessionTest.kt` shows the CLI shell is not a toy extra. The REPL can create games, inspect board state, change integrity modes, execute commands, and drive tasks, which makes it useful both for debugging and for scripted verification.

### Build, Release, And Testing

- The test surface is unusually deep for a low-signal hobby-scale repository:
  - parser and AST tests in `pets`
  - engine invariant and card-behavior tests in `engine`
  - long scripted full-game and solo-game tests
  - REPL session tests in `repl`
- `CanonInvariantsTest.kt` is a particularly good example of verifying content semantics rather than only imperative behavior. It checks canonical limits and class restrictions directly from the loaded data model.
- The module split also scales well from a maintenance perspective: `pets`, `engine`, `canon`, and `repl` each have a distinct responsibility instead of living in one monolithic rules workspace.

## Reusable Takeaways

- For content-heavy board or card games, a declarative rules DSL plus a loaded semantic type system can scale better than encoding every special card or tile effect as bespoke imperative code.
- A shared game-logic library becomes easier to port into Android when runtime rules, canonical content packs, and operator tooling are split into separate modules.
- Full-game scripted tests are worth treating as a primary verification tool for complex turn-based rules, not only as a late extra after unit tests.
- When a game has many triggered effects and ownership/dependency rules, a queued-task model can make rule interactions easier to trace and test than direct nested mutation.

## Evidence Summary

- `Engine.kt`, `ApiTranslation.kt`, and `TfmGameplay.kt` - Dagger-assembled runtime plus a game-specific facade over a generic rules engine
- `Component.kt`, `Effector.kt`, `Changer.kt`, and `MClass.kt` - declarative type/effect loading, triggered task emission, and invariant-aware state changes
- `ClassDeclaration.kt`, `ClassParsing.kt`, `TfmAuthority.kt`, and `Canon.kt` - DSL parsing, authority/content abstraction, and canonical `.pets` plus `.json5` content packs
- `docs/language-intro.md` and `docs/component-types.md` - explanation of the component multiset, dependency model, and rule-expression approach
- `CanonInvariantsTest.kt`, `Game20230521Test.kt`, and `ReplSessionTest.kt` - invariant validation, full-game scripting, and live-shell verification
- root/module build files - modern JVM toolchain expectations, KSP/Dagger wiring, and distinct module responsibilities

## Risks Or Limits

- The repository is highly domain-specific to Terraforming Mars, so direct reuse often means adapting the architecture rather than copying concrete gameplay content.
- There is no Android runtime, graphics stack, or mobile UX layer in the inspected revision; the main value is pure logic, content modeling, and testing structure.
- The loaded type/DSL system is powerful but dense. Teams copying the pattern should expect real onboarding cost.
- Public ecosystem signal is still low at `16` stars, so the repository should be treated as a strong specialized reference rather than as widely validated community baseline.
- Local build validation in the lab is still limited by the Java `8` machine, while the inspected repository already needs at least Java `11` to configure and effectively targets a newer toolchain through `jvmToolchain(21)`.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `engine-framework`
- Focus tags: `asset-pipeline`, `testing`
- Follow-up needed:
  - rerun Gradle discovery and selected tests in a JDK `21`-ready environment, or at minimum a Java `11+` environment for configuration
  - if the lab revisits this repository later, isolate the `Pets` DSL, the loaded runtime type system, the full-game script tests, or the REPL shell instead of reopening the whole codebase broadly
