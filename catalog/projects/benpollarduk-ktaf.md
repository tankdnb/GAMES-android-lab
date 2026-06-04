# Project Entry

## Basic Info

- Project name: `Ktaf`
- Source repository: [https://github.com/benpollarduk/ktaf](https://github.com/benpollarduk/ktaf)
- Author / organization: `benpollarduk`
- License: `MIT`
- Research note: [research/findings/benpollarduk-ktaf.md](../../research/findings/benpollarduk-ktaf.md)
- Investigated commit: `d98b84e69eb79aafdb5fa32be2ad4935a63a4519`
- Last verified: `2026-06-04`
- Activity / maintenance status: modest but real maintenance for a niche JVM framework; the repository was pushed on `2025-05-08`, GitHub still showed an update timestamp on `2025-10-11`, and the latest inspected commit was `Update main-release.yml`.

## Short Description

Kotlin text-adventure framework built around room graphs, exits, items, command interpretation, conversations, and swappable presentation hosts for console, Swing, and Ktor-delivered HTML.

## Technical Profile

- Primary category: `library-sdk`
- Focus tags: `ui-hud`, `input`, `asset-pipeline`, `testing`
- Engine / framework: custom Kotlin JVM text-adventure framework
- Rendering approach: frame-oriented runtime with interchangeable ANSI-console and HTML builders plus example Swing and Ktor hosts
- Main language(s): Kotlin
- Android target: indirect; no Android module is included, but the parser runtime, room/item/conversation systems, and host-IO seam transfer well to narrative-heavy or exploration-heavy Android games
- Build system: Gradle multi-project JVM build with publishing, docs, release, and test automation

## Why It Matters

- `Ktaf` is a useful reference for teams that want authored exploration content, parser-style interaction, and host UI concerns to stay separate instead of being fused into one app shell.
- Its best value for this lab is not direct Android code reuse, but the way it packages room graphs, conversations, command parsing, frame building, and host adapters into a coherent Kotlin library.
- It also complements `Ktvn` well: `Ktvn` covers branching visual-novel flow, while `Ktaf` covers parser-driven text adventure flow.

## Reusable Ideas

- Gameplay ideas:
  - coordinate-authored room graphs, reciprocal exit linking, parser-driven item use, and paragraph-based NPC conversations
- Architecture patterns:
  - one central runtime plus interchangeable `IOConfiguration` hosts and frame-builder families
- Graphics / rendering techniques:
  - keep the core runtime frame-oriented and let each host render scene/map/help/conversation frames in its own way
- Input / UI approaches:
  - layered interpreters with contextual command help derived from the current room or conversation state
- Performance or optimization ideas:
  - normalize content-authoring helpers and parser targets once in the framework instead of re-solving them in every host app

## Notable Implementations

- `Game`, `GameExecutor`, and `GameTemplate` keep content instantiation, runtime ownership, and concrete execution separate.
- `RegionMaker` and `OverworldMaker` let authored worlds be defined by coordinates and then normalized into linked regions automatically.
- `Room`, `Item`, and `Conversation` provide a compact reusable model for exploration, interactions, and dialogue.
- `InputInterpreter` composes specialized interpreters instead of implementing one giant parser.
- `FrameBuilderCollection` plus the ANSI and HTML builders give the framework a clear presentation seam.
- `GameCatalogResolver` can discover packaged `GameTemplate` implementations from jars.

## Android Relevance

- Native Android use:
  - indirect
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - most useful for Android games that need command parsing, exploration graphs, dialogue flow, or a replaceable runtime/UI boundary rather than a graphics-heavy engine baseline

## Risks / Limitations

- The repository is JVM-only in the checked-in state and ships no Android host implementation.
- The framework is intentionally text-adventure-specific, so its direct transfer value is narrower than broader gameplay or rendering engines.
- The Ktor example host uses singleton state and polling loops, which is acceptable for a demo shell but not a strong production-server baseline.
- Local lab build validation is currently blocked because the configured build plugins now require at least JDK `11` while the machine remains on Java `8`.

## Notes

This is a good `library-sdk` reference to keep alongside `Ktvn`: not because both do narrative work, but because they solve different narrative game shapes and show two different ways to separate content, runtime flow, and host UI.
