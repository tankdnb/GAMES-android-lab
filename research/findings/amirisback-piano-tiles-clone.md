# Findings: `amirisback/piano-tiles-clone`

## Repository Snapshot

- Repository: `amirisback/piano-tiles-clone`
- Source URL: `https://github.com/amirisback/piano-tiles-clone`
- Owner: `amirisback`
- Batch ID: `BATCH-2026-07-11-A`
- Type: `android-game`
- License: `Apache-2.0`
- Selection date: `2026-07-11`
- Last pushed at selection: `2023-04-09`
- Stars at selection: `27`
- Investigated commit: `f8c1838ca8d381747331aa70e3c8035491c6a84a`
- Research status: `reference-only`
- Build mode: `static-review + gradle-version + gradle-help-failed-no-jdk-tools`
- Catalog card: [card](../../catalog/projects/amirisback-piano-tiles-clone.md)

## Why This Repository Was Selected

- It was the only remaining queued candidate in the compact explicit-license backlog after `BATCH-2026-07-10-B`.
- It has direct Android relevance, visible Kotlin/Java game code, explicit Apache-2.0 metadata, and enough public signal to justify a focused comparison pass.
- The expected value was not a single polished architecture, but a side-by-side view of several small Piano Tiles implementations.

## Technical Profile

- Main language(s): Kotlin, Java
- Engine / framework: Android SDK with several independent app modules
- Rendering stack: mixed custom `SurfaceView`, bitmap-backed `Canvas` in `ImageView`, and direct `ImageView` layout mutation
- Android target: direct Android app modules
- Build system: Gradle Kotlin DSL, Gradle wrapper `7.5`, Android Gradle Plugin `7.4.2`, Kotlin Android plugin `1.6.10`
- Repository layout summary: root aggregator project with six Android app modules: `atillaturkmen`, `frostygum`, `gianmartind`, `jghjianghan`, `mihaimaximfii`, and `obedkristiaji`.
- Key files reviewed: root `README.md`, `LICENSE`, `settings.gradle.kts`, root and module Gradle scripts, `buildSrc`, `.github/workflows/detekt-analysis.yml`, representative runtime files from all six modules, and the `jghjianghan` engine/mode split in detail.

## Build And Runtime Notes

- The repository was inspected statically first.
- `cmd /c gradlew.bat --version` succeeded locally and reported Gradle `7.5` running on Java `1.8.0_321`.
- `cmd /c gradlew.bat help --no-daemon` failed during `buildSrc:compileKotlin` because the lab machine exposes a Java runtime without the JDK tools required by Kotlin compilation.
- Runtime launch was not attempted because the repository contains several independent Android apps, no tests, and the local Gradle surface is already blocked by the missing JDK tools.
- The only visible GitHub workflow is a Detekt SARIF scan using `detekt-analysis.yml`; no build/test workflow was found.

## Usefulness Assessment

- Reuse potential: `2`
- Android transfer: `3`
- Implementation depth: `2`
- Code clarity: `1`
- Novelty: `1`
- Overall verdict: `reference-only`
- Why: the repository is directly Android-relevant and useful as a comparative archive of rhythm-game implementation tactics, but it is an aggregator of cloned student-style implementations, overlaps with the already researched `atillaturkmen/piano-tiles`, has no tests, and exposes multiple lifecycle/threading risks.

## Interesting Findings

### Multi-Implementation Comparison

- `settings.gradle.kts` wires six Android app modules under one root project.
- The README explicitly frames the repository as a clone collection inspired by several external Piano Tiles projects.
- This makes the repository valuable for comparing implementation tradeoffs across the same simple game: custom surface loop, bitmap canvas in an `ImageView`, direct `ImageView` spawning, tilt input, and multiple score/persistence styles.

### SurfaceView Runtime

- `atillaturkmen/src/main/java/com/github/atillaturkmen/GameView.kt` and `GameThread.kt` preserve a compact `SurfaceView` implementation.
- `GameThread` targets 60 FPS, locks the `SurfaceHolder` canvas, and delegates update/draw to `GameView`.
- `GameView` stores live tiles in a `LinkedList<Tile>` and snapshots them into a `CopyOnWriteArrayList` for touch iteration.
- It avoids spawning the next tile in the same lane as the previous tile and uses `SoundPool` plus optional vibration for feedback.
- The major caution is thread lifecycle: the loop is `while (true)` and only checks `running` around work, so the thread is not cleanly terminated.

### Bitmap-Backed ImageView Runtimes

- `frostygum/src/main/java/com/github/frostygum/view/FragmentPianoTilesGame.kt` and `obedkristiaji/src/main/java/com/github/obedkristiaji/view/GameFragment.kt` draw into a mutable `Bitmap` through a `Canvas`, then display it in an `ImageView`.
- Their thread classes move `Rect` instances downward, add new rectangles at the top, and notify the UI through handlers or presenters.
- The pattern is easy to understand for small games and can be ported into teaching samples, but it is weaker than a properly lifecycle-owned `View` or Compose frame loop for production Android games.

### Tile Generation And Difficulty

- `frostygum/util/PianoGenerator.kt` creates lane-based piano notes and avoids repeating the previous lane.
- `frostygum/view/PianoThread.kt` adds a bonus-level concept every five levels and treats bonus notes differently from normal fail conditions.
- `obedkristiaji/view/PianoThread.kt` increases score by level and moves tiles based on the selected difficulty.
- `mihaimaximfii/GameActivity.kt` uses a `Timer` plus `Handler` pair: one schedule moves tiles and another schedule spawns tiles.
- The direct `ImageView` spawning approach in `mihaimaximfii` is useful as a contrast, but it scales poorly compared with a custom drawing surface.

### Mode-Specific Game Engine Split

- The strongest reusable subsystem is under `jghjianghan/src/main/java/com/github/jghjianghan/view/engines/`.
- `GameEngine`, `Tile`, `TileOrchestrator`, and `TileDrawer` split display ownership, tile data, update logic, and drawing behavior.
- `GameplayFragment` selects `ClassicGameEngine`, `ArcadeGameEngine`, `RainingGameEngine`, or `TiltGameEngine` based on `GameMode`.
- The fragment waits for `ImageView` layout dimensions before constructing the engine, which avoids zero-size bitmap/canvas initialization.
- `UIThreadWrapper` bridges background tile-orchestrator threads back onto the main thread for redraw and stop/disable-pause events.

### Input And Sensors

- Tap modes use lane/tile hit testing against rectangles.
- `gianmartind/SensorThread.java` polls roll thresholds to accept left/right sensor interactions.
- `jghjianghan/tilt/TiltTileOrchestrator.kt` moves a green player circle with accelerometer data and auto-clicks falling tiles when the circle overlaps them.
- The tilt variant is the most distinctive reusable idea in the batch: it adapts a tap rhythm game into a sensor-driven avoidance/collection mode.

### Audio And Persistence

- `jghjianghan/model/audio/PianoPlayer.kt` loads notes into `SoundPool` and plays the next note from the selected song.
- `atillaturkmen/GameView.kt` uses `SoundPool` for tile/fail feedback.
- `mihaimaximfii/GameActivity.kt` uses `MediaPlayer` for note playback.
- `jghjianghan/model/SharedPrefWriter.kt`, `obedkristiaji/storage/GameStorage.kt`, and `mihaimaximfii/MyPreferences.kt` show several small high-score/settings persistence variants.
- `gianmartind/DBHandler.java` uses SQLite for scores, but also exposes risky raw query string concatenation and a cursor lifecycle bug in `getScoreCount()`.

## Reusable Takeaways

- For simple rhythm games, the most reusable abstraction is lane-owned tile generation plus a small orchestrator that owns spawn, movement, hit testing, and fail conditions.
- A mode-specific engine split can keep variants such as classic, arcade, raining, and tilt understandable without turning every rule into flags in one loop.
- `ImageView` plus mutable `Bitmap` is a quick prototyping surface, but a custom `View`, `SurfaceView`, or Compose frame loop usually gives cleaner lifecycle ownership.
- Sensor-driven variants can refresh a familiar tap game by mapping accelerometer position to collision with falling notes.
- Side-by-side clone collections are useful for comparing tradeoffs, but their code should be treated as reference material rather than as a production baseline.

## Evidence Summary

- `settings.gradle.kts` - six-module Android app aggregator
- `buildSrc/src/main/kotlin/ProjectSetting.kt` - shared SDK and application metadata
- `.github/workflows/detekt-analysis.yml` - static-analysis-only workflow
- `atillaturkmen/src/main/java/com/github/atillaturkmen/GameView.kt` - `SurfaceView` runtime, tile list, touch hit testing, sound/vibration
- `atillaturkmen/src/main/java/com/github/atillaturkmen/GameThread.kt` - manual 60 FPS canvas loop and thread-lifecycle caveat
- `frostygum/src/main/java/com/github/frostygum/util/PianoGenerator.kt` - lane generation and bonus-level note setup
- `frostygum/src/main/java/com/github/frostygum/view/PianoThread.kt` - thread-based tile motion and level scaling
- `obedkristiaji/src/main/java/com/github/obedkristiaji/view/PianoThread.kt` - difficulty-scaled tile loop and score handling
- `mihaimaximfii/src/main/java/com/github/mihaimaximfii/GameActivity.kt` - direct `ImageView` spawning with `Timer`/`Handler` scheduling
- `gianmartind/src/main/java/com/github/gianmartind/presenter/PlayThread.java` - Java lane/event spawning loop
- `gianmartind/src/main/java/com/github/gianmartind/presenter/SensorThread.java` - sensor threshold polling
- `gianmartind/src/main/java/com/github/gianmartind/DBHandler.java` - SQLite score storage and cursor/query risks
- `jghjianghan/src/main/java/com/github/jghjianghan/view/GameplayFragment.kt` - mode selection, lifecycle hooks, sensor registration
- `jghjianghan/src/main/java/com/github/jghjianghan/view/engines/GameEngine.kt` - bitmap-backed canvas engine base
- `jghjianghan/src/main/java/com/github/jghjianghan/view/engines/*TileOrchestrator.kt` - classic, arcade, raining, and tilt mode update loops
- `jghjianghan/src/main/java/com/github/jghjianghan/model/audio/PianoPlayer.kt` - note playback through `SoundPool`

## Risks Or Limits

- The repository is an aggregator of other Piano Tiles clones, not a single coherent product architecture.
- `atillaturkmen/piano-tiles` was already researched separately, so one module duplicates prior lab coverage.
- No test files were found.
- The visible CI only runs a Detekt scan and marks scan/report steps as `continue-on-error`.
- Many runtime loops use raw `Thread`, `Timer`, mutable flags, and handler messages instead of lifecycle-aware coroutines or a clearly stoppable frame loop.
- Several modules mutate UI or game state through presenters/fragments with limited separation between rendering and rules.
- Some audio resources are loaded through `SoundPool` or `MediaPlayer`, but release/lifecycle cleanup is not consistently visible in the inspected files.
- Local Gradle configuration requires a full JDK, while the lab machine currently exposes only Java `8` runtime tools.

## Catalog Decision

- Keep in main catalog: `yes, as reference-only`
- Primary category: `reference-only`
- Focus tags: `2d`, `android`, `input`, `audio`, `save-load`, `ui-hud`
- Follow-up needed: only if future work needs a deeper comparison of Piano Tiles implementations. Prefer focusing on `jghjianghan` mode orchestration, tilt input, or the contrast between `SurfaceView`, bitmap-backed `ImageView`, and direct view-spawning approaches.
