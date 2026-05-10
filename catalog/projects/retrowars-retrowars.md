# Project Entry

## Basic Info

- Project name: `Super Retro Mega Wars`
- Source repository: [https://github.com/retrowars/retrowars](https://github.com/retrowars/retrowars)
- Author / organization: `retrowars`
- License: `GPL-3.0`
- Research note: [research/findings/retrowars-retrowars.md](../../research/findings/retrowars-retrowars.md)
- Investigated commit: `766e1376b745604d0350344cc194e87642263737`
- Last verified: `2026-05-10`

## Short Description

Android-first libGDX multiplayer arcade game that shares one product shell across several retro minigames and includes LAN/public-server networking support.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `2d`, `android`, `libgdx`, `networking`, `input`, `ui-hud`
- Engine / framework: libGDX with Android/desktop/server modules
- Rendering approach: shared libGDX screens, HUD, Scene2D menus, and per-minigame game-state modules
- Main language(s): Kotlin, Java
- Android target: direct Android app with Android-specific local-network and share hooks
- Build system: Gradle Groovy multi-module project

## Why It Matters

- It is a good reference for structuring multiple minigames inside one Android game shell.
- Multiplayer, HUD, Android platform hooks, and a shared game screen are all implemented in one coherent codebase.

## Reusable Ideas

- Gameplay ideas:
  - data-driven minigame registry and compact per-game state holders
- Architecture patterns:
  - shared `GameScreen` shell for camera, HUD, music, score, and network concerns
- Graphics / rendering techniques:
  - HUD-aware viewport that reserves control space instead of taking over the full screen
- Input / UI approaches:
  - declarative soft-controller layouts with button or gesture-only modes
- Performance or optimization ideas:
  - most value here is architecture rather than raw optimization

## Notable Implementations

- `RetrowarsGame` centralizes navigation and menu music.
- `GameScreen` absorbs common runtime concerns for all minigames.
- `Games` keeps minigame registration data-driven.
- `SoftController` validates and instantiates on-screen controls from serialized layouts.
- `RetrowarsClient` marshals network updates back onto the libGDX main thread.
- `RetrowarsServer` supports local, private-room, and public-room topologies.

## Android Relevance

- Native Android use:
  - yes
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - especially useful as a reference for multiplayer shell architecture, Android LAN play, and shared mode/minigame products

## Risks / Limitations

- `GPL-3.0` restricts direct code reuse in proprietary games.
- Build validation was inconclusive because the Gradle discovery attempt timed out.
- Some takeaways are specifically multiplayer-oriented.

## Notes

This is one of the stronger direct Android game references in the repository so far.
