# Project Entry

## Basic Info

- Project name: `Darkest Pixel Dungeon`
- Source repository: [https://github.com/egoal/darkest-pixel-dungeon](https://github.com/egoal/darkest-pixel-dungeon)
- Author / organization: `egoal`
- License: `GPL-3.0`
- Research note: [research/findings/egoal-darkest-pixel-dungeon.md](../../research/findings/egoal-darkest-pixel-dungeon.md)
- Investigated commit: `604d16a2b3e39c39e7f26c3a09e7b377584fc6c8`
- Last verified: `2026-05-10`
- Activity / maintenance status: last push recorded at selection on `2025-04-30`.

## Short Description

Kotlin Android roguelike with a custom `Noosa` runtime, buffered multi-touch input, digger-based procedural dungeon generation, split save-slot persistence, and dense in-game RPG UI flows.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `2d`, `android`, `roguelike`, `procedural-generation`, `save-load`, `input`, `ui-hud`, `performance`
- Engine / framework: custom Android/`Noosa` runtime plus game-specific roguelike systems
- Rendering approach: custom OpenGL scene graph, tilemap batching, layered scene composition, and incremental map/UI refresh
- Main language(s): Kotlin, Java
- Android target: direct Android application module with shared runtime library
- Build system: multi-module Gradle project with `core` app and `SPD-classes` runtime library

## Why It Matters

- This repository is a strong direct Android gameplay reference for the lab because it exposes many reusable ideas in one older but still practical codebase: touch runtime plumbing, turn scheduling, procedural floor generation, save slots, backup recovery, layered scenes, and compact RPG UI.
- Its value is less about modern Android tooling and more about durable game-design implementation patterns that remain relevant when building mobile roguelikes or other menu-heavy 2D games.

## Reusable Ideas

- Gameplay ideas:
  - pressure-driven hero state, data-backed mob abilities/loot, digger-based floor generation, and inventory/quickslot continuity through long dungeon runs
- Architecture patterns:
  - custom Android touch runtime shell, time-based actor scheduler, split game-vs-level persistence, and save-slot previews/backups
- Graphics / rendering techniques:
  - visible-range tile rendering, partial tile-buffer updates, layered terrain/water/UI scenes, and targeted map refresh hooks instead of full redraw logic everywhere
- Input / UI approaches:
  - centralized multi-touch dispatcher, tabbed hero sheet, journal/catalog navigation, and dense mobile-friendly in-game windows
- Performance or optimization ideas:
  - cached tile VBO path, incremental scene updates, and separated level-save files rather than one monolithic snapshot

## Notable Implementations

- `Game` buffers Android `MotionEvent` input and feeds it through a reusable touch pipeline.
- `Actor` runs a time-based scheduler that can wait for sprite motion before resolving the next logical action.
- `RegularLevel` and `LevelDigger` layer several procedural floor-building strategies instead of relying on one generator pass.
- `Bundle`, `Dungeon`, and `GamesInProgress` separate object persistence, whole-run saves, current-level saves, backups, and slot previews.
- `Tilemap` and `GameScene` keep rendering and map/UI refresh incremental rather than full-scene brute force.

## Android Relevance

- Native Android use:
  - yes; the repository is built as a direct Android game with custom touch/runtime handling
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - best used as an idea library for runtime shell, persistence, generation, and UI patterns rather than as a modern drop-in Android build baseline

## Risks / Limitations

- GPL-3.0 licensing restricts direct reuse more than several other catalog entries.
- The Android toolchain surface is old and should not be treated as a current best-practice build baseline.
- Automated tests are effectively absent, so confidence comes mostly from static reading.

## Notes

This repository is especially useful when the lab wants concrete ideas for Android roguelike runtime design, procedural dungeon assembly, split save architecture, and compact menu-heavy RPG UI without relying on a heavyweight engine framework.
