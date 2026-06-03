# Project Entry

## Basic Info

- Project name: `Solarnet`
- Source repository: [https://github.com/MartianZoo/solarnet](https://github.com/MartianZoo/solarnet)
- Author / organization: `MartianZoo`
- License: `Apache-2.0`
- Research note: [research/findings/martianzoo-solarnet.md](../../research/findings/martianzoo-solarnet.md)
- Investigated commit: `2db507c5e1bf95098adba09c0a6f35043a81fc9e`
- Last verified: `2026-06-04`
- Activity / maintenance status: active at selection; the repository was last pushed on `2026-06-01`, and the latest visible work included build/toolchain cleanup in an otherwise actively maintained rules-engine workspace.

## Short Description

Kotlin JVM rules-engine workspace for Terraforming Mars that combines a declarative `Pets` specification language, a typed runtime/effect system, a canonical data pack, and a REPL shell instead of a traditional rendering-focused game engine.

## Technical Profile

- Primary category: `engine-framework`
- Focus tags: `asset-pipeline`, `testing`
- Engine / framework: custom rules engine + `Pets` specification language + Dagger-assembled runtime scopes
- Rendering approach: no dedicated renderer; the repository is logic-first and exposes a text REPL/debug shell around the runtime
- Main language(s): Kotlin
- Android target: indirect; no Android target is present, but the shared logic and content-modeling patterns are highly reusable for Android board, card, and turn-based games
- Build system: multi-module Gradle Kotlin DSL JVM workspace

## Why It Matters

- `Solarnet` is one of the stronger logic-core references in the lab for games where UI should stay thin and rules complexity should live in reusable Kotlin modules.
- Its main value is the combination of declarative rules content, a loaded semantic type system, task-driven effect execution, a separate canonical content pack, and unusually deep full-game/invariant test coverage.

## Reusable Ideas

- Gameplay ideas:
  - component-multiset game state, queued task execution, and full-game scripted verification for a dense turn-based ruleset
- Architecture patterns:
  - declarative class declarations loaded into a richer runtime type system, with Dagger-assembled game and player scopes
- Graphics / rendering techniques:
  - none directly; this is a pure logic/reference entry rather than a rendering reference
- Input / UI approaches:
  - REPL-driven inspection and command execution as a debugging and verification surface for complex rule systems
- Performance or optimization ideas:
  - keep shipped content declarative and testable, so behavior-heavy changes can be validated through invariant and full-game tests instead of hidden imperative branches

## Notable Implementations

- `Engine.newGame()` assembles a scoped runtime through Dagger rather than a monolithic singleton rules object.
- `MClass` loads inert class declarations into a richer semantic runtime model with inheritance, defaults, dependencies, invariants, and effect compilation.
- `Effector` converts declarative effect subscriptions into queued tasks triggered by state changes.
- `Canon` keeps the official content pack in `.pets` and `.json5` resources separate from the reusable runtime.
- `ReplSession` and its tests show a practical command shell for inspecting and driving the engine.
- The repository includes broad parser, invariant, full-game, solo-game, and REPL tests rather than only a handful of narrow unit tests.

## Android Relevance

- Native Android use:
  - no; the repository is JVM-only in the inspected revision
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - especially useful for Android games where complex turn rules, card effects, expansions, or content packs should live in a shared pure-Kotlin core while the Android app remains mostly a host shell

## Risks / Limitations

- The repository is domain-specific and dense; teams will often reuse the architecture more directly than the concrete content.
- There is no mobile UX, rendering, or Android integration surface here.
- The rules DSL and loaded type system are powerful but come with real onboarding complexity.
- Local lab build verification is still limited by the Java `8` machine, while the repository effectively expects at least Java `11` to configure and a newer toolchain for normal work.
- Public ecosystem signal remains low despite the strong internal test and architecture quality.

## Notes

Treat `solarnet` as a high-value pure-logic and content-pipeline reference for Android-adjacent turn-based game development, not as a renderer or ready-made mobile game shell.
