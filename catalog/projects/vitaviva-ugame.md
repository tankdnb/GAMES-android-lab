# Project Entry

## Basic Info

- Project name: `UGame`
- Source repository: [https://github.com/vitaviva/ugame](https://github.com/vitaviva/ugame)
- Author / organization: `vitaviva`
- License: `Apache-2.0`
- Research note: [research/findings/vitaviva-ugame.md](../../research/findings/vitaviva-ugame.md)
- Investigated commit: `9e44209b8f81b50df1e5d65c6bbe1e5f06935495`
- Last verified: `2026-06-04`
- Activity / maintenance status: stale by code activity; GitHub still shows repository metadata updates, but the last code push was `2020-04-19` and the latest inspected commit only updated `README.md`.

## Short Description

Android-native mini-game modeled after the Douyin/TikTok submarine challenge pattern, built with Camera2 face detection, a `TextureView` preview, layered custom views, bitmap-drawn obstacles, and a small activity/controller game loop.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `2d`, `android`, `input`, `ui-hud`, `collision`
- Engine / framework: custom Android game shell with Camera2, `TextureView`, `FrameLayout`, `Canvas` drawing, `LiveData`, and `Handler` scheduling
- Rendering approach: layered camera preview plus foreground/background custom views with bitmap cropping, animation, and overlay drawing
- Main language(s): Kotlin, Java
- Android target: direct and exclusive; the repository is a single Android application module
- Build system: Gradle Android application on AGP `3.6.1`, Kotlin `1.3.61`, `compileSdkVersion 29`, and Java `8`

## Why It Matters

- `UGame` is valuable because it is a direct Android reference that does not depend on Compose, LibGDX, or a heavyweight engine.
- Its strongest reuse value is the combination of Camera2 face-detection input, layered custom-view rendering, simple controller-owned collision/score logic, and very explicit Android lifecycle/permission handling.

## Reusable Ideas

- Gameplay ideas:
  - face-controlled endless-runner / flappy-style progression where score advances by survival time rather than by a separate point system
- Architecture patterns:
  - one `GameController` owning camera startup, score flow, collisions, and game-state `LiveData`
- Graphics / rendering techniques:
  - bitmap-sliced obstacle pairs, dynamically inserted camera preview, and a small sprite rotation/flash loop for the player
- Input / UI approaches:
  - Camera2 face-rect mapping into player movement, centered score HUD, and blocking replay dialog flow
- Performance or optimization ideas:
  - keep runtime simple with ordinary Android view animation and main-thread polling when the game scope is intentionally small

## Notable Implementations

- `CameraHelper` wraps Camera2 preview, face detection, camera switching, and preview transform logic in one dedicated helper.
- `ForegroundView` translates detected face rectangles into smoothed boat motion and optional debug overlay drawing.
- `BoatView` uses `OverScroller` and short rotation animation to make tracked movement feel smoother.
- `BackgroundView` creates obstacle pairs over time and moves them with `ValueAnimator`, keeping the gameplay loop readable and asset-light.
- `GameController` polls collisions and score every `100` ms and exposes `Start`, `Score`, and `Over` through `LiveData`.
- The layout keeps camera preview, score text, gameplay overlays, and camera-switch control separate and easy to reason about.

## Android Relevance

- Native Android use:
  - yes; Android is the whole product surface
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - especially useful for direct Android mini-games that want camera-driven controls or custom-view gameplay without adopting an external engine

## Risks / Limitations

- The project is stale and tied to older tooling plus `jcenter()`.
- The visible test surface is only template boilerplate.
- The manifest requests more permissions than the runtime actually uses, duplicates the camera permission, and declares the camera feature incorrectly.
- The default selected camera is the back camera, which is a weak default for a face-controlled game and shows some rough edges in the implementation.

## Notes

This is a narrow but worthwhile Android-native reference: not a modern build baseline, but a useful compact example of Camera2-as-input, layered view-based game rendering, and controller-owned game flow in Kotlin.
