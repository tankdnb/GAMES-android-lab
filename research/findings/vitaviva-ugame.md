# Research Note

## Repository Snapshot

- Repository: `vitaviva/ugame`
- Source URL: [https://github.com/vitaviva/ugame](https://github.com/vitaviva/ugame)
- Owner: `vitaviva`
- Batch ID: [`BATCH-2026-06-04-L`](../batches/BATCH-2026-06-04-L.md)
- Type: `android-game`
- License: `Apache-2.0`
- Selection date: `2026-06-04`
- Last pushed at selection: `2020-04-19`
- Stars at selection: `159`
- Default branch at selection: `master`
- Investigated commit: `9e44209b8f81b50df1e5d65c6bbe1e5f06935495`
- Research status: `accepted`
- Build mode: `static-review + gradle-help + app-unit-test-dry-run-failed-missing-android-sdk`
- Catalog card: [catalog/projects/vitaviva-ugame.md](../../catalog/projects/vitaviva-ugame.md)

## Why This Repository Was Selected

- `ugame` was the last remaining verified candidate in the compact explicit-license shortlist.
- Even though the repository is old by last code push, it still has stronger public signal than the fresh low-star noise currently outside the queue and adds a distinct Android-native reference the lab did not yet have: a Camera2 face-detection game built from custom `View` / `FrameLayout` layers rather than from Compose or LibGDX.
- The main question for this pass was whether the repository is still substantial enough to keep as a main catalog entry. The answer is yes, because it contains a compact but very direct Android game shell with reusable camera, overlay, collision, and host-lifecycle patterns.

## Technical Profile

- Main language(s): Kotlin, Java
- Engine / framework: custom Android-native game shell with `TextureView`, `FrameLayout`, `Canvas` drawing, Camera2 face detection, and `LiveData`-driven UI state
- Rendering stack: Camera2 preview on `AutoFitTextureView` below layered overlay views; obstacles are custom-drawn bitmaps inside `View` subclasses and the player boat is an animated `AppCompatImageView`
- Android target: direct and exclusive; the repository is a single Android app module
- Build system: Gradle Android application using AGP `3.6.1`, Kotlin `1.3.61`, and Java `8`
- Repository layout summary:
  - root Android project with one `app/` module
  - `cam/` contains Camera2 preview, face detection, and transform logic
  - `bg/` contains obstacle spawning and movement
  - `fg/` contains the boat/player and foreground overlay logic
  - `GameController.kt` and `FullscreenActivity.kt` own the game loop, score flow, lifecycle wiring, and host UI
- Source footprint:
  - total files counted in repository: `49`
  - Kotlin/Java/Gradle/XML files counted in repository: `24`
- Test surface:
  - test files found: `2`
  - meaningful automated tests found: `0`
- Key modules reviewed:
  - `README.md`
  - `LICENSE`
  - `build.gradle`
  - `settings.gradle`
  - `gradle.properties`
  - `app/build.gradle`
  - `app/src/main/AndroidManifest.xml`
  - `app/src/main/res/layout/activity_fullscreen.xml`
  - `app/src/main/java/com/my/ugame/FullscreenActivity.kt`
  - `app/src/main/java/com/my/ugame/GameController.kt`
  - `app/src/main/java/com/my/ugame/PermissionUtils.kt`
  - `app/src/main/java/com/my/ugame/bg/BackgroundView.kt`
  - `app/src/main/java/com/my/ugame/bg/Bar.kt`
  - `app/src/main/java/com/my/ugame/fg/ForegroundView.kt`
  - `app/src/main/java/com/my/ugame/fg/Boat.kt`
  - `app/src/main/java/com/my/ugame/cam/CameraHelper.kt`
  - `app/src/main/java/com/my/ugame/cam/AutoFitTextureView.java`
  - `app/src/test/java/com/my/ugame/ExampleUnitTest.kt`
  - `app/src/androidTest/java/com/my/ugame/ExampleInstrumentedTest.kt`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeds and downloads/configures Gradle `5.6.4` on Java `8`.
- `cmd /c gradlew.bat help --no-daemon` succeeds.
- `cmd /c gradlew.bat :app:testDebugUnitTest --dry-run --no-daemon` fails because no Android SDK is configured in the lab environment:
  - `SDK location not found. Define location with an ANDROID_SDK_ROOT environment variable or by setting the sdk.dir path...`
- The checked-in build surface is old but coherent:
  - AGP `3.6.1`
  - Kotlin `1.3.61`
  - `compileSdkVersion 29`
  - `minSdkVersion 21`
  - `targetSdkVersion 29`
  - Java/Kotlin target `1.8`
- The latest inspected commit message is `Update README.md`, which confirms that code activity is stale even if the repository metadata still receives GitHub-side updates.
- No runtime launch was attempted.

## Usefulness Assessment

- Reuse potential: `2`
- Android transfer: `3`
- Implementation depth: `2`
- Code clarity: `3`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - `ugame` is narrow and stale, but it is also a concise, readable, direct Android reference for Camera2-driven input, layered `View` rendering, obstacle animation, and activity-owned game flow.
  - The repository is especially valuable because it broadens the lab's Android-native references beyond Compose and LibGDX with a custom `View` / `TextureView` stack that still feels game-specific rather than purely educational.

## Interesting Findings

### Engine Architecture And Core Loop

- `FullscreenActivity.kt` keeps the host shell simple: the activity owns full-screen chrome, injects a `TextureView` camera preview into the root layout at runtime, wires a `GameController`, and translates `LiveData<GameState>` into score text or replay dialogs.
- `GameController.kt` is the main runtime seam. It coordinates camera startup, foreground/background start-stop, score progression, collision checks, and activity lifecycle cleanup instead of spreading that work across views.
- The game loop is intentionally lightweight. Scoring and collision evaluation happen through a recurring main-thread `Handler.postDelayed` every `100` ms, which is enough for this mini-game and easy to adapt to other compact Android arcade shells.
- The state surface is intentionally tiny: `Start`, `Score`, and `Over` are all the UI needs, and that makes the activity/controller boundary very readable.

### Rendering And Graphics

- The repository uses a layered Android rendering stack instead of an engine surface. The root view contains score text, a `BackgroundView`, a `ForegroundView`, and a camera preview `TextureView` inserted dynamically underneath them.
- `BackgroundView.kt` spawns upper/lower obstacle pairs over time and moves them leftward with `ValueAnimator`, which is a practical pattern for obstacle-heavy Android mini-games that do not need a separate render thread.
- `Bar.kt` shows a compact bitmap-slicing trick: one source bitmap is cropped differently for top and bottom barriers, and the bottom version is generated by rotating the image `180` degrees rather than keeping separate assets.
- `Boat.kt` keeps the player sprite simple but expressive: two bitmap frames flash on a timer, and the view rotates based on movement slope for a lightweight sense of motion.

### Input And Controls

- The repository's main distinctive idea is camera-driven control. `CameraHelper.kt` uses Camera2 face detection, maps detected face rectangles into preview coordinates, and calls back into the foreground layer with normalized face bounds.
- `ForegroundView.kt` converts the first detected face rectangle into target `x` / `y` coordinates for the boat and also keeps a debug face rectangle overlay, which is useful both for gameplay and for tuning face mapping.
- `BoatView.smoothMoveTo(...)` uses `OverScroller` plus a short rotation animation instead of snapping directly to face coordinates. That gives the game a smoother, more readable control feel than raw face-position tracking would.
- `PermissionUtils.kt` keeps permission flow explicit and self-contained, which is still a useful pattern for Android game features that depend on camera or other runtime permissions.

### UI, HUD, And Menus

- `activity_fullscreen.xml` shows a compact but effective Android game HUD: one centered score text layer, one gameplay background layer, one foreground/player layer, and one bottom control strip for switching cameras.
- `FullscreenActivity.startGame()` uses `LiveData` observation to keep score and game-over flow declarative from the activity side. For a small Android game, that is often clearer than having custom views own all UI updates themselves.
- The replay loop is intentionally minimal: on `GameState.Over`, the activity shows a blocking dialog and either restarts the controller or exits the activity.

### Physics And Collision

- `GameController.isCollision(...)` is a straightforward AABB overlap test, which is exactly enough for this game's obstacle and boat geometry.
- `BackgroundView._createBars(...)` derives each new obstacle pair from the previous pair by nudging the top-bar height up or down by a fixed step while preserving a constant gap. That is a compact obstacle-generation rule worth reusing in other endless-runner or flappy-style Android games.
- The obstacle motion path is view-driven rather than physics-engine-driven, but the combination of deterministic leftward animation plus controller-side collision polling is a useful simple pattern for small Android arcade games.

### Android Platform Integration

- `CameraHelper.kt` is the strongest Android-specific seam in the repo. It manages Camera2 selection, preview size choice, aspect-ratio correction, face-detection enablement, coordinate transforms, repeat-preview requests, and camera switching in one dedicated helper.
- `AutoFitTextureView.java` is lifted from AOSP Camera2 samples and gives the game a clean aspect-ratio-preserving preview surface.
- The game is very Android-native in architecture: no engine abstraction layer, direct runtime permissions, direct `AlertDialog` replay flow, direct `Handler` scheduling, and direct `TextureView` / `FrameLayout` layering.
- The repository is also a useful warning example: the manifest declares broader permissions than the actual runtime requests use, duplicates the camera permission, and declares `uses-feature` with the wrong camera string. That is a reminder to keep Android manifest surfaces tighter in production game code.

### Build, Release, And Testing

- `gradlew help` still configures successfully in the inspected clone, which is useful because many newer Android repos in the lab now fail much earlier on JVM floors alone.
- The visible test surface is effectively just Android Studio template boilerplate: `ExampleUnitTest.kt` and `ExampleInstrumentedTest.kt`. There is no meaningful gameplay, camera, or rendering regression coverage.
- The build remains tied to `jcenter()` and older Android tooling, which is an important maintenance risk even though the code is still readable and the repository remains useful as a reference.

## Reusable Takeaways

- A direct Android mini-game does not need a heavy engine to be worth studying; `TextureView`, layered `FrameLayout` views, `LiveData`, and a small controller loop can already produce a readable game shell.
- Camera2 face detection can serve as a first-class game input source if the repository keeps preview, transform, and game-movement responsibilities separated.
- Endless-runner obstacles can be implemented cleanly with ordinary Android view animation when the motion and collision surfaces are kept simple.
- Even compact Android game samples benefit from a dedicated controller layer instead of putting camera, collision, score, and replay flow directly in the activity.

## Evidence Summary

- `FullscreenActivity.kt` and `GameController.kt` - host shell, score/game-over state flow, camera/bootstrap coordination, and controller-owned game loop
- `BackgroundView.kt` and `Bar.kt` - timed obstacle spawning, bitmap-sliced top/bottom barriers, and leftward animation
- `ForegroundView.kt` and `Boat.kt` - face-rect-to-boat mapping, smoothing, sprite flashing, and movement-based rotation
- `CameraHelper.kt` and `AutoFitTextureView.java` - Camera2 setup, face detection, preview transforms, and camera switching
- `AndroidManifest.xml` and `PermissionUtils.kt` - runtime permission flow plus Android-specific manifest caveats
- `app/build.gradle` plus the template tests - build health and the absence of real automated verification

## Risks Or Limits

- The repository is stale by code activity; the latest inspected commit only updated the README.
- The visible automated test surface is placeholder-only.
- The Android build depends on AGP `3.6.1`, Kotlin `1.3.61`, `jcenter()`, and an SDK-ready environment, so it should be treated as a pattern reference more than as a modern build baseline.
- The manifest surface is sloppy for production reuse: duplicated camera permission, unrelated extra permissions, and an incorrect camera `uses-feature` declaration.
- The default selected camera is `LENS_FACING_BACK`, which is odd for a face-controlled game and suggests some implementation rough edges around the intended front-camera flow.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `android-game`
- Focus tags: `2d`, `android`, `input`, `ui-hud`, `collision`
- Follow-up needed:
  - if the lab revisits this repository, do it in an Android SDK-ready environment and isolate one seam such as the Camera2 face-mapping flow, the layered custom-view rendering stack, or the controller-owned collision/score loop instead of reopening the whole app broadly
