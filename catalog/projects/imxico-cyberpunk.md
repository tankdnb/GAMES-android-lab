# Project Entry

## Basic Info

- Project name: `Cyberpunk`
- Source repository: [https://github.com/ImXico/cyberpunk](https://github.com/ImXico/cyberpunk)
- Author / organization: `ImXico`
- License: `MIT`
- Research note: [research/findings/imxico-cyberpunk.md](../../research/findings/imxico-cyberpunk.md)
- Investigated commit: `47d9a8130b31ec9bab20708995ee3a2bd93b45e7`
- Last verified: `2026-06-04`
- Activity / maintenance status: historically useful but stale helper library; the latest inspected commit was `Update README libKTX-related section` from `2020-04-15`, and the visible build/CI surface still reflects an older libGDX plus Travis era.

## Short Description

Compact Kotlin helper-library stack for libGDX prototypes, bundling state management, transition effects, camera helpers, Box2D builders, asset managers, text/image alignment helpers, and a tiny profiler wrapper.

## Technical Profile

- Primary category: `library-sdk`
- Focus tags: `libgdx`, `physics`, `audio`, `ui-hud`
- Engine / framework: modular utility library layered on top of libGDX
- Rendering approach: libGDX `Batch`/`Camera`/`Viewport` plus FBO-backed state transitions and simple helper-style 2D alignment utilities
- Main language(s): Kotlin
- Android target: indirect; no Android module is checked in, but the library is directly relevant to older libGDX Android game shells and rapid prototypes
- Build system: Gradle multi-project Groovy DSL with JitPack-oriented publication and legacy Travis CI

## Why It Matters

- `Cyberpunk` is a useful reminder that small helper libraries can still preserve good ideas even when the overall stack is old.
- Its best value for this lab is not breadth but compactness: a readable `StateManager` shell, FBO-based screen transitions, and pixel-first Box2D builders that can be cited later without reopening a huge engine repository.

## Reusable Ideas

- Gameplay ideas:
  - none directly; the value is in reusable runtime helpers rather than shipped gameplay
- Architecture patterns:
  - keep libGDX state flow, camera/viewport ownership, and transition rendering centralized in one tiny manager layer
  - publish helper families as independent modules instead of one all-or-nothing utility jar
- Graphics / rendering techniques:
  - capture current and next states into FBOs and let screen-space transitions render those textures
- Input / UI approaches:
  - give state classes built-in `unproject()` helpers and keep centering/camera-follow math in standalone utilities
- Performance or optimization ideas:
  - hide Box2D unit conversion behind helpers so gameplay code can stay pixel-oriented and readable

## Notable Implementations

- `StateManager`, `StateAdapter`, and the `Transition` types form a compact screen/state shell around plain libGDX primitives rather than a larger scene framework.
- `TransitionFBO` is the most reusable rendering seam in the repository: it wraps current and next state renders into `FrameBuffer`s so transition code stays separate and simple.
- `PhysicsWorld`, `PhysicsUtility`, `BodyBuilder`, `BodyDefBuilder`, and `FixtureDefBuilder` provide a practical pixel-first Box2D wrapper layer with reusable builders and automatic shape cleanup.
- `SoundManager`, `MusicManager`, and `ImageManager` show a deliberately prototype-oriented keyed-registry approach to libGDX assets.
- `ImageHelper` and `TextHelper` keep common HUD/menu alignment calculations out of game screens.

## Android Relevance

- Native Android use:
  - indirect
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - most useful for older or intentionally lightweight libGDX Android game shells that want tiny runtime helpers rather than a full framework

## Risks / Limitations

- The repository is stale and built on an older stack: Kotlin `1.3.61`, libGDX `1.9.10`, Gradle `5.6.1`, `jcenter()`, and Travis `oraclejdk9`.
- The main `StateManager` path has code-level caveats around null-transition handoff and disposing the current state before transition rendering.
- The singleton manager pattern is intentionally game-jam-oriented and does not scale as well as `AssetManager` plus explicit ownership.
- The automated test surface is minimal and does not cover the most important runtime seams.

## Notes

This is a good narrow `library-sdk` reference, not because it is modern or exhaustive, but because it keeps a few still-useful libGDX patterns very small and readable. Treat it as a compact historical helper-library model, not as a production-ready modern baseline.
