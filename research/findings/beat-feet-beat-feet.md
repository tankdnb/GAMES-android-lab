# beat-feet/beat-feet

- Repository: [beat-feet/beat-feet](https://github.com/beat-feet/beat-feet)
- Repository type: `android-game`
- Final status: `accepted`
- Reviewed on: `2026-06-15`
- License: `GPL-3.0`
- Stars at review: `81`
- Last pushed at review: `2026-06-13`
- Default branch: `master`
- Investigated commit: `2a6a1d92a6b82456174a8048305211581ebe5f57`
- Build mode: `static-review + gradle-version + gradle-help-failed-java8-needs-java11`

## What This Repository Is

`Beat Feet` is a Kotlin/libGDX Android rhythm-platformer where obstacle layouts are generated from analyzed music features instead of being authored by hand.

The repository is more useful than a normal small game sample because it preserves both sides of the pipeline:

- the Android/libGDX runtime that turns song features into a scrolling platform level
- a separate headless preprocessing tool that extracts features from MP3 files and stores compact JSON level data

## Why It Is Interesting For The Lab

- It is a direct Android game with a real shipped-product shape rather than only an engine experiment.
- It shows a reusable pattern for converting audio analysis into gameplay geometry.
- It keeps content preprocessing outside the gameplay runtime, which is a valuable pattern for mobile performance and asset-pipeline design.
- It also includes a custom-level ingestion flow, so the repo covers both built-in assets and user-supplied content.

## Architecture Snapshot

### 1. Screen-owned runtime shell

- `core/src/com/serwylo/beatgame/BeatFeetGame.kt` keeps the application shell small: shared assets, renderer globals, locale setup, and screen routing.
- `core/src/com/serwylo/beatgame/screens/PlatformGameScreen.kt` owns most gameplay runtime concerns: state transitions, music playback sync, camera motion, obstacle generation, collision checks, HUD, and endgame overlays.
- The runtime is explicitly stateful with `PENDING`, `PAUSED`, `WARMING_UP`, `PLAYING`, `DYING`, and `WINNING`, which makes the timing model easier to reuse than an ad hoc frame loop.

### 2. Audio-to-level preprocessing pipeline

- `song-extract/src/com/serwylo/beatgame/SongExtractApplication.kt` is a headless LibGDX tool that scans a source MP3 directory and writes per-track JSON feature files.
- `song-extract/build.gradle` wires that tool into `:song-extract:processSongs`, targeting `songs/original` as source and `android/assets/songs/data` as output.
- `core/src/com/serwylo/beatgame/audio/AudioIO.kt` keeps runtime loading separate from extraction and caches generated data when custom songs need analysis on-device.

### 3. Feature extraction rather than raw waveform gameplay

- `core/src/com/serwylo/beatgame/audio/fft/FFT.kt` decodes MP3 to PCM, slices fixed windows, runs FFT, and derives frequency-value windows.
- `core/src/com/serwylo/beatgame/audio/playground/AudioAnalysis.kt` smooths time series, finds local maxima, and emits normalized `Feature` ranges with strength, start time, and duration.
- `core/src/com/serwylo/beatgame/audio/features/LevelData.kt` stores only what the runtime needs: duration plus low/mid/high feature bands and a height map.

### 4. Geometry and visual theming stay separate

- `PlatformGameScreen.generateObstacles(...)` maps timed song features into obstacle rectangles, merges nearby compatible buildings, and snaps output to tile-scale constraints.
- `core/src/com/serwylo/beatgame/entities/ObstacleBuilder.kt` turns those abstract obstacle rectangles into themed buildings, walls, props, and narrow hazards.
- This separation is one of the strongest reusable ideas in the repo: procedural structure generation is decoupled from sprite composition and art dressing.

### 5. Built-in, remote, and custom level seams

- `core/src/com/serwylo/beatgame/levels/Level.kt` defines a common level interface over built-in, remote, legacy-custom, and current custom levels.
- `core/src/com/serwylo/beatgame/levels/customLevels.kt` handles MP3 import, title extraction, file copying into a game-owned folder, and migration from the legacy single-custom-song model.
- The custom-level flow uses cached JSON feature files so repeated play does not require re-analysis every time.

## Reusable Technical Ideas

- rhythm level generation via offline feature extraction instead of runtime audio analysis
- mapping song time to world distance through a stable horizontal scale constant
- merging nearby procedural obstacle candidates before visual instantiation
- keeping geometry generation separate from visual tile/sprite composition
- using a warm-up phase before music start so motion and audio remain synchronized
- limiting collision checks to nearby visible obstacles instead of scanning the whole level
- supporting user-imported custom songs through a separate cacheable preprocessing path

## Android Relevance

Android relevance is **direct**.

Why it matters:

- the reviewed host is an Android launcher, not only a desktop sample
- the runtime shape is compatible with Android asset packaging and custom file import
- the preprocessing split is especially relevant for mobile performance and storage tradeoffs

Why it is still broader than one product:

- the audio-to-geometry pipeline can transfer into runners, rhythm games, and music-reactive content systems
- the custom-level import path is useful as a reference for user-generated content on Android

## Build And Verification Notes

- `cmd /c gradlew.bat --version` succeeds and reports Gradle `7.5`, Kotlin `1.6.21`, and the lab JVM as Java `8`.
- `cmd /c gradlew.bat help --no-daemon` fails while resolving `com.android.tools.build:gradle:7.4.2` because the local lab machine still exposes only Java `8`, while that Android Gradle Plugin path now requires Java `11+`.
- The failure shape looks environmental rather than like a confirmed repository-specific build break.
- The repository also includes at least one meaningful test seam: `core/test/com/serwylo/beatgame/I18nTests.kt` plus a custom `GdxTestRunner`.

## Risks And Caveats

- License is `GPL-3.0`, so direct code reuse into closed-source products would need care even though architectural ideas remain useful.
- The build is from an older but coherent libGDX/AGP generation, so some tooling details are dated.
- The FFT and feature extraction code is compact and practical, but it is heuristic rather than a sophisticated modern DSP pipeline.
- The inspected automated test surface is narrower than the gameplay/runtime surface.

## Verdict

Keep `beat-feet/beat-feet` as `accepted`.

It is one of the stronger direct-Android additions in the lab because it combines a real libGDX mobile game shell, a reusable audio-feature preprocessing pipeline, a clear procedural obstacle-generation model, and a custom-content import path that is directly relevant to future Android game experimentation.
