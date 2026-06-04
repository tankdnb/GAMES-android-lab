# Project Entry

## Basic Info

- Project name: `Ktvn`
- Source repository: [https://github.com/benpollarduk/ktvn](https://github.com/benpollarduk/ktvn)
- Author / organization: `benpollarduk`
- License: `MIT`
- Research note: [research/findings/benpollarduk-ktvn.md](../../research/findings/benpollarduk-ktvn.md)
- Investigated commit: `e7dc751aa3ebb65aad3cf7351579ee93b681143a`
- Last verified: `2026-06-04`
- Activity / maintenance status: modest but real maintenance for a niche JVM framework; the repository was pushed on `2025-05-08`, GitHub still showed an update timestamp on `2026-02-05`, and the latest inspected commit was `Update publish-docs.yml`.

## Short Description

Kotlin visual-novel framework built around a story DSL, a host-agnostic runtime, split progression/persistence layers, and two included prototype hosts: an ANSI-console runner and a richer Swing prototyper.

## Technical Profile

- Primary category: `library-sdk`
- Focus tags: `ui-hud`, `save-load`, `testing`
- Engine / framework: custom Kotlin JVM narrative-runtime library with pluggable `GameEngine` hosts
- Rendering approach: renderer-agnostic core; output is delegated to host implementations, with included ANSI console and Swing debug/prototyping shells
- Main language(s): Kotlin
- Android target: indirect; no Android module is included, but the story DSL, progression controller, save/restore model, and adapter seams transfer well to narrative-heavy Android games
- Build system: Gradle multi-project JVM build with publishing, docs, release, and test automation

## Why It Matters

- `Ktvn` is a strong reference for teams building dialogue-heavy or branching story games in Kotlin, especially when they want content authorship and runtime flow to stay separate from the final UI shell.
- Its best value for this lab is architectural: a small but complete example of how to package story DSL, branching control, host adapters, persistence, and prototyping tools into one reusable library.

## Reusable Ideas

- Gameplay ideas:
  - chapter/scene/step narrative flow, named jumps, interactive mini-game hooks, and skip-seen-content support
- Architecture patterns:
  - one core narrative runtime plus pluggable `GameEngine` hosts, with configuration and execution ownership kept outside the content DSL
- Graphics / rendering techniques:
  - keep the runtime renderer-agnostic and let host engines translate story events into their own UI or rendering model
- Input / UI approaches:
  - centralize wait/skip/auto progression and answer collection so different hosts share one interaction contract
- Performance or optimization ideas:
  - deterministic step identifiers plus persisted seen-step tracking instead of full runtime-state snapshots for skip logic

## Notable Implementations

- `Story`, `Chapter`, `Scene`, and `StepResult` provide a typed branching runtime instead of an ad hoc script interpreter.
- `VisualNovel` packages story plus configuration and assigns stable step identifiers at startup.
- `DynamicGameConfiguration` and `DynamicGameAdapter` let the same content run against different host engines.
- `GameSave`, `RestorePoint`, and `StepIdentifierTracker` split persistence into meta-progress, current position, and seen-content tracking.
- `VisualNovelCatalogResolver` discovers packaged visual novels from jars, making the runtime usable beyond one hardcoded sample.
- The console and Swing prototypers demonstrate both a minimal runtime host and a more tool-oriented debugging shell.

## Android Relevance

- Native Android use:
  - indirect
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - especially useful for Android games with heavy dialogue, route branching, replay/skip requirements, or mini-game hooks embedded into narrative steps

## Risks / Limitations

- The repository is JVM-only in the checked-in state and does not provide an Android host implementation.
- `README.md` still describes the DSL as early-stage and subject to change.
- The included prototype hosts are console and Swing, so mobile-first interaction and rendering patterns would still need Android-specific design work.
- Local lab build validation is currently blocked because Gradle configuration still needs at least JDK `11` while the machine remains on Java `8`.

## Notes

This is a good `library-sdk` reference: not a renderer, not an Android app, but a clean Kotlin example of how to structure branching narrative content, progression control, and save/restore behavior so the host UI stays replaceable.
