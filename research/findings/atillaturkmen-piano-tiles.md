# Research Note

## Repository Snapshot

- Repository: `atillaturkmen/piano-tiles`
- Source URL: [https://github.com/atillaturkmen/piano-tiles](https://github.com/atillaturkmen/piano-tiles)
- Owner: `atillaturkmen`
- Batch ID: [`BATCH-2026-05-11-Q`](../batches/BATCH-2026-05-11-Q.md)
- Type: `android-game`
- License: `GPL-3.0`
- Selection date: `2026-05-11`
- Last pushed at selection: `2026-04-26`
- Stars at selection: `17`
- Investigated commit: `d9257698ffddd3a5be60f96e558aa4be75d6ad17`
- Research status: `reference-only`
- Build mode: `static-review + gradle-help-failed-java8-needs-java11`
- Catalog card: [catalog/projects/atillaturkmen-piano-tiles.md](../../catalog/projects/atillaturkmen-piano-tiles.md)

## Why This Repository Was Selected

- After refreshing the shortlist, `piano-tiles` offered the best current balance of direct Android relevance, fresh maintenance, explicit licensing, and at least some ecosystem signal among the not-yet-researched candidates.
- The repository is narrow, but it is still useful because it shows a classic pre-Compose Android mini-game built around `SurfaceView`, a manual render thread, tactile feedback, and simple per-difficulty persistence.
- It also complements the lab's stronger Compose and LibGDX references by adding a more old-school Android `Canvas` / `SurfaceHolder` rhythm-game sample.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: Android SDK + `SurfaceView` + manual game thread + Navigation component
- Rendering stack: `Canvas` drawing on `SurfaceView`, lane lines plus `Rect`-based tiles, and a centered replay overlay inflated above the game surface
- Android target: direct single-app Android application
- Build system: single-module Gradle Groovy DSL Android project
- Repository layout summary: one `app/` module with a drawer-based menu shell, a dedicated `GameActivity`, a custom `GameView`, one render thread, one `Tile` model, audio assets, and lightweight SharedPreferences-backed high-score storage
- Source footprint:
  - total files reviewed in repository: `45`
  - Kotlin/Java files reviewed across the repository: `7`
- Test surface:
  - unit-test directories found: `0`
  - instrumentation-test directories found: `0`
- Key modules reviewed:
  - `README.md`
  - `LICENSE`
  - `settings.gradle`
  - `build.gradle`
  - `gradle/wrapper/gradle-wrapper.properties`
  - `app/build.gradle`
  - `app/src/main/AndroidManifest.xml`
  - `app/src/main/java/com/tayyar/tiletap/MainActivity.kt`
  - `app/src/main/java/com/tayyar/tiletap/MainFragment.kt`
  - `app/src/main/java/com/tayyar/tiletap/HighScoresFragment.kt`
  - `app/src/main/java/com/tayyar/tiletap/game/GameActivity.kt`
  - `app/src/main/java/com/tayyar/tiletap/game/GameThread.kt`
  - `app/src/main/java/com/tayyar/tiletap/game/GameView.kt`
  - `app/src/main/java/com/tayyar/tiletap/game/Tile.kt`
  - `app/src/main/res/layout/fragment_main.xml`
  - `app/src/main/res/navigation/navigation.xml`
  - `app/src/main/res/menu/left_menu.xml`
  - `app/src/main/res/layout/centered_image.xml`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeds and reports Gradle `8.11.1` running on Java `1.8.0_321`.
- `cmd /c gradlew.bat help --no-daemon` fails during root-project configuration because `com.android.tools.build:gradle:8.9.1` requires at least Java `11`, while the lab machine still exposes Java `8`.
- The checked-in build scripts also confirm a newer app toolchain than the current machine provides:
  - `build.gradle` pins Kotlin `1.8.22` and AGP `8.9.1`
  - `app/build.gradle` targets `compileSdkVersion 35`, `targetSdkVersion 35`, `minSdkVersion 21`, and Java/Kotlin target `17`
- No automated test directories were found under `app/src/test` or `app/src/androidTest`.
- No runtime launch was attempted.
- Known setup limitations:
  - local Gradle validation in this lab currently stops at the Java runtime floor
  - even after satisfying the Java floor, the repository still offers almost no verification surface beyond manual play because no tests are checked in

## Usefulness Assessment

- Reuse potential: `2`
- Android transfer: `3`
- Implementation depth: `1`
- Code clarity: `2`
- Novelty: `2`
- Overall verdict: `reference-only`
- Why:
  - the repository is directly transferable to Android because it is a native Kotlin game with a custom `SurfaceView` runtime, tactile feedback, and a simple product shell
  - the strongest reusable ideas are speed normalization, touch hit-testing against moving tiles, and difficulty-bucketed high scores
  - it is still too narrow and too architecture-compromised to treat as a primary catalog model: the whole runtime lives in one view, key gameplay state is stored in global mutable companions, no tests exist, `Tile.update()` logs every frame, and the render thread never exits cleanly after stop

## Interesting Findings

### Engine Architecture And Core Loop

- `app/src/main/java/com/tayyar/tiletap/game/GameActivity.kt` keeps the Android shell thin but practical. It reads one-shot configuration from intent extras, scales the chosen speed by `displayMetrics.heightPixels / 1280`, stores those runtime knobs into `GameView` / `Tile` companion state, then mounts the actual `GameView` dynamically into an otherwise empty layout.
- `app/src/main/java/com/tayyar/tiletap/game/GameThread.kt` runs a fixed `60` FPS loop and intentionally shows a half-second warmup where only lane lines and score are drawn before the tiles start moving. That is a compact way to add a tiny pre-start buffer without a separate countdown scene.
- `app/src/main/java/com/tayyar/tiletap/game/GameView.kt` is the true runtime owner. It keeps tile queues, score, audio, vibration, touch state, replay flow, and game-over handling together, which keeps the sample readable for a very small project.
- The same `GameThread.kt` also contains the repository's biggest architectural caveat: the thread runs `while (true)` forever and only checks a `running` flag inside the loop. After `surfaceDestroyed()` sets `running = false`, the thread does not sleep, break, or join; it just busy-spins indefinitely.

### Rendering And Graphics

- `app/src/main/java/com/tayyar/tiletap/game/GameView.kt` and `Tile.kt` render the whole game with plain `Canvas` primitives. Four vertical lane dividers split the screen, and each tile is a `Rect` whose width is always one quarter of the screen and whose height is always one quarter of the screen height, so the board automatically adapts to device size without a separate layout system.
- `Tile.kt` treats each note as a very small data+draw object: row selection determines horizontal bounds once in `init`, and every frame only updates `startY` / `endY` before drawing a solid rectangle. For tiny arcade games, this is a reasonable alternative to sprite-heavy setups.
- The miss-feedback path in `Tile.update()` is unusually explicit: when an untapped tile reaches the bottom, it turns red and flips the shared speed to `-40.0`, pulling the failed note back into view before the session fully ends. It is narrow and a bit hacky, but it is a memorable example of using simple motion reversal instead of a dedicated failure animation system.

### Gameplay Systems

- `app/src/main/java/com/tayyar/tiletap/game/GameView.kt` avoids immediate lane repetition with `do { row = (0..3).random() } while (row == lastRow)`. This tiny rule makes the rhythm pattern feel less monotonous without adding a heavier generator.
- `app/src/main/java/com/tayyar/tiletap/game/Tile.kt` exposes an optional gradual difficulty curve through `speedIncrease`: once enabled, the global speed increases every `60` frames until it reaches `50`, keeping the base game loop tiny while still allowing a more arcade-like escalation mode.
- `GameView.saveIfHighScore()` stores scores by the initial selected speed rather than by a single global leaderboard. That is a simple but useful mobile-game product idea when difficulty presets materially change scoring expectations.

### Input And Controls

- `app/src/main/java/com/tayyar/tiletap/game/GameView.kt` handles `ACTION_DOWN` and `ACTION_POINTER_DOWN`, so the input path is built around raw touch pointers rather than view widgets. That keeps the tap loop direct and avoids translating through multiple Android controls.
- Before hit-testing, the same file snapshots the live `LinkedList<Tile>` into a `CopyOnWriteArrayList`. This is a small but noteworthy defensive seam: touch evaluation walks a stable copy while the render/update loop may still mutate the original queue.
- `app/src/main/java/com/tayyar/tiletap/game/Tile.kt` expands the horizontal hitbox by `screenWidth / 30`, which makes taps more forgiving without changing the drawn tile size. That is a practical mobile-tuning trick for narrow-lane games.
- `GameView.onTouchEvent()` distinguishes success from failure by lane band: if a touch lands within an active tile's vertical span but not on an untapped black tile, the game marks the lane red and ends the run immediately. This keeps rhythm-game punishment logic very explicit.

### UI, HUD, And Menus

- `app/src/main/java/com/tayyar/tiletap/MainFragment.kt` turns the home screen into a single-session configuration screen with initial speed, sound, vibration, and optional speed-increase toggles. It is a simple pattern for tiny arcade games that do not need persistent settings architecture.
- `app/src/main/java/com/tayyar/tiletap/MainActivity.kt`, `navigation.xml`, and `left_menu.xml` build a minimal shell around the game: the navigation drawer exposes only the high-score screen and is automatically locked outside the start destination, which prevents the menu from leaking into gameplay.
- `app/src/main/java/com/tayyar/tiletap/HighScoresFragment.kt` reads SharedPreferences entries, sorts them numerically by speed key, and inflates one row per speed bucket into a vertical table. It is small, but it gives the project a more complete product loop than a bare one-screen prototype.
- `app/src/main/java/com/tayyar/tiletap/game/GameActivity.kt` and `app/src/main/res/layout/centered_image.xml` use a separate centered replay overlay instead of baking restart UI into the `SurfaceView`, which is a clean separation for small custom-drawn games.

### Tooling, Android Integration, Or Other Notable Areas

- `app/src/main/java/com/tayyar/tiletap/game/GameView.kt` initializes `SoundPool` and `Vibrator` only when the corresponding toggles are enabled, then plays a tile note or failure sound directly from gameplay events. That is a very direct but readable audio/haptic path for a tiny offline game.
- `app/src/main/AndroidManifest.xml` keeps the Android shell intentionally simple: portrait-only activities, vibration permission, fullscreen gameplay, and `allowBackup="false"`.
- `MainActivity.dispatchTouchEvent()` hides the keyboard when the user taps outside the start-screen speed field, which is a small but thoughtful polish detail for a game whose only typed input is the pre-game speed value.

## Reusable Takeaways

- Device-height-normalized motion is a cheap way to keep tiny `SurfaceView` arcade games feeling closer across phones with different resolutions.
- If moving gameplay entities are mutated from a render thread, snapshotting them before touch evaluation can simplify hit-testing logic and avoid iterator/concurrency surprises.
- Difficulty-bucketed leaderboards can make more sense than a single all-mode high score when the player is allowed to choose initial speed or other rule-changing presets.
- Tiny Android rhythm or runner prototypes can stay inside one custom view plus one activity shell, but thread shutdown, logging discipline, and global-state control matter quickly even at this scale.

## Evidence Summary

- `game/GameActivity.kt` - Android shell, runtime option injection, display-height speed normalization, fullscreen handling, and replay overlay ownership
- `game/GameThread.kt` - fixed-FPS loop, half-second warmup, and the thread-lifecycle caveat
- `game/GameView.kt` - central runtime owner, tile queue flow, touch handling, audio/vibration toggles, game-over/restart flow, and SharedPreferences high-score writes
- `game/Tile.kt` - lane-bounded tile geometry, optional speed escalation, miss/failure feedback, and forgiving touch hitbox logic
- `MainFragment.kt` - pre-game runtime configuration flow
- `HighScoresFragment.kt` - sorted speed-bucket score table
- `AndroidManifest.xml` and `app/build.gradle` - direct Android app shape, portrait/fullscreen shell, SDK range, and JVM target
- `gradle-wrapper.properties` and root `build.gradle` - Gradle `8.11.1`, AGP `8.9.1`, and the Java-floor mismatch seen during discovery

## Risks Or Limits

- The repository is intentionally narrow: it is a small rhythm-game clone, not a broad architecture or subsystem benchmark.
- No automated test directories were found.
- `GameThread` never exits cleanly after stop, which makes it a weak lifecycle model for production Android code.
- `Tile.update()` logs speed every frame, and several important runtime knobs live in mutable companion objects (`Tile.speed`, `Tile.speedIncrease`, `GameView.score`, `GameView.music`, `GameView.vibration`, `GameView.initialSpeed`).
- GPL-3.0 licensing limits direct code reuse compared with permissive samples.
- Local Gradle discovery in this lab currently fails on the Java floor before deeper build validation can happen.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `reference-only`
- Focus tags: `2d`, `android`, `input`, `ui-hud`, `audio`, `save-load`
- Follow-up needed:
  - if the lab revisits this repository later, focus on the `SurfaceView` thread lifecycle, the screen-height speed normalization approach, or the touch-hit-testing flow around moving tile queues instead of reopening the whole project broadly
