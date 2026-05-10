# Project Entry

## Basic Info

- Project name: `Neon`
- Source repository: [https://github.com/mariodujic/Neon](https://github.com/mariodujic/Neon)
- Author / organization: `mariodujic`
- License: `MIT`
- Research note: [research/findings/mariodujic-neon.md](../../research/findings/mariodujic-neon.md)
- Investigated commit: `bb633bc8cad5ad6dc0d8e787d0c3241f63adb3c2`
- Last verified: `2026-05-10`
- Activity / maintenance status: recently active at selection; the repository last pushed on `2025-11-22`, and `.github/workflows/android-ci.yml` shows an active JDK `17` CI test workflow.

## Short Description

Android shoot-em-up built entirely with Jetpack Compose, using controller-owned gameplay state, a small timed-job scheduler, touch-hold movement buttons, staged enemy waves, bosses, and lightweight unit-test coverage.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `2d`, `android`, `input`, `ui-hud`, `collision`, `audio`, `testing`
- Engine / framework: Android SDK + Jetpack Compose + coroutines
- Rendering approach: Compose `Image`/`Canvas` world layers with animated gradients, Coil GIF explosions, and ExoPlayer music
- Main language(s): Kotlin
- Android target: direct portrait Android application with Compose UI
- Build system: single-module Android Gradle app

## Why It Matters

- This repository is a useful reference because it shows how a small mobile action game can be structured in pure Compose without immediately collapsing into one giant UI file.
- Its main value is not engine sophistication. It is the clear separation between UI rendering and controller-owned gameplay responsibilities such as wave progression, lasers, collisions, pickups, boss patterns, pause flow, and transient state restoration.

## Reusable Ideas

- Gameplay ideas:
  - typed stage scripts, `StageBreak` transitions, targeted boss shots, wall-with-gap boss lasers, and simple pickup-driven weapon/shield upgrades
- Architecture patterns:
  - `rememberGameState()` as a controller assembly root, `tinker` as a tiny periodic job scheduler, and callback-based controller coordination instead of direct cross-object mutation
- Graphics / rendering techniques:
  - sprite-per-composable layering, canvas stars, animated radial shield glow, and GIF-based explosion effects inside a Compose scene
- Input / UI approaches:
  - hold-to-move touch buttons via `awaitRelease()`, HUD separate from world rendering, and dialog-route pause flow
- Performance or optimization ideas:
  - keep domain models separate from UI DTOs and schedule only the controllers that currently have active work

## Notable Implementations

- `rememberGameState` wires ship, lasers, enemies, boosters, explosions, minerals, stars, stage progression, and pause lifecycle into one controller graph.
- `tinker` plus `RepeatTime` gives the game a tiny reusable timing primitive for repeated, once-only, or disabled work.
- `StageController` combines time expiry with "field clear" gating via `StageBreak`.
- `ShipController` centralizes movement, collisions, powerup timers, and HP changes.
- `EnemyFactory` and the boss classes keep wave formations and attack patterns data-driven but easy to read.

## Android Relevance

- Native Android use:
  - yes; this is a direct Android app written around Compose UI and touch controls
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - especially useful as a reference when building smaller Android games directly in Compose rather than with LibGDX, KorGE, or a custom GL runtime

## Risks / Limitations

- Best treated as a compact action-game sample, not a high-scale performance baseline.
- No durable save/load system beyond transient state restoration.
- Local build verification in the lab currently needs Java `11+`.

## Notes

This repository is most valuable when the lab wants Compose-native ideas for mobile game structure, touch controls, stage scripting, and lightweight gameplay-controller testing on Android.
