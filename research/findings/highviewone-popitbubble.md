# HighviewOne/PopItBubble

- Repository: [HighviewOne/PopItBubble](https://github.com/HighviewOne/PopItBubble)
- Repository type: `android-game`
- Final status: `accepted`
- Reviewed on: `2026-06-15`
- License: `MIT`
- Stars at review: `0`
- Last pushed at review: `2026-06-12`
- Default branch: `master`
- Investigated commit: `8d2e15f16e6cfd64e4cb9ca259b504981fff311d`
- Build mode: `static-review + missing-windows-gradlew-bat`

## What This Repository Is

`PopItBubble` is a compact Android-native sensory/fidget game built around one custom `View`, generated pop sounds, haptic feedback, and a small persistence/settings shell.

The checked-in tree is small but real:

- a single Android app module with no external engine
- one custom-rendered gameplay surface in `BubbleGridView`
- a lightweight activity shell for challenge mode, theme/size switching, and reset flow
- a dedicated `SoundManager` that synthesizes and caches pop sounds at runtime
- JVM tests for geometry helpers and Espresso tests for the basic product flow

## Why It Is Interesting For The Lab

- It is a direct Android reference for shipping a tactile toy-like game without Compose or libGDX.
- The repository shows how far a single well-structured custom `View` can go before needing a heavier engine layer.
- It preserves a useful cluster of Android-native patterns: Canvas gradients, multi-touch popping, low-latency `SoundPool`, lightweight persistence, and focused UI/instrumentation tests.

## Architecture Snapshot

### 1. One custom `View` owns nearly all gameplay rendering and hit detection

- `app/src/main/java/com/popitbubble/BubbleGridView.kt` is the core of the project.
- It stores a flat list of `Bubble` objects with row/column, center, radius, color, pop state, and animation scale.
- `onSizeChanged()` rebuilds the full bubble layout and background gradient, while `onDraw()` renders every bubble with circles, radial gradients, highlights, and rim strokes.
- This is a good Android-native reference for a tiny game where the entire playfield can stay inside one Canvas-driven view instead of introducing a scene graph or entity runtime.

### 2. Rendering quality comes from cached shader setup rather than bitmap assets

- `BubbleGridView` prepares inflated/popped shaders per color and reuses them while drawing.
- The 3D silicone look is created from `RadialGradient`, shared highlights, drop shadows, and separate popped-vs-inflated draw branches.
- The useful idea is not only visual polish, but the practical pattern: generate a small palette of reusable shader resources once, then keep per-frame draw work simple.

### 3. Input model is intentionally simple but supports real multi-touch sweeping

- `onTouchEvent()` handles both `ACTION_DOWN` and `ACTION_MOVE`.
- The view iterates all active pointers and calls `checkTouchAt()` for each one, which then scans bubbles and uses `GridMath.isTouching(...)`.
- This makes the game feel tactile without building a more complex gesture stack.
- For small board sizes, the linear scan is a reasonable tradeoff and easier to maintain than premature spatial indexing.

### 4. Product shell logic stays in `MainActivity`, while the playfield stays reusable

- `app/src/main/java/com/popitbubble/MainActivity.kt` owns challenge mode, timer start/stop, best-time persistence, menu commands, and completion celebration flow.
- `BubbleGridView` exposes `onPopListener` and `onAllPoppedListener`, so the activity can react without reaching into render internals.
- That event seam is worth reusing: even in a tiny Android game, the gameplay surface and the app/product shell stay partially decoupled.

### 5. Geometry math is extracted into a pure helper for fast JVM testing

- `app/src/main/java/com/popitbubble/GridMath.kt` holds bubble radius, center, touch-hit, and color-adjustment helpers.
- `app/src/test/java/com/popitbubble/GridMathTest.kt` validates those calculations on the JVM.
- This is a modest but valuable pattern for Android mini-games: keep small deterministic geometry or rules helpers outside framework-heavy classes so they are cheap to test.

### 6. Audio is synthesized in-process instead of bundled as assets

- `app/src/main/java/com/popitbubble/SoundManager.kt` builds a `SoundPool`, generates several WAV variations, caches them under the app cache directory, and plays them with randomized pitch/volume.
- The pop sounds combine white noise, tonal body, and a click transient.
- This is a strong reusable idea for casual/mobile games: tiny procedural audio can keep APK size down while still giving the interaction a distinct feel.

### 7. Settings and challenge persistence are intentionally tiny but complete

- `app/src/main/java/com/popitbubble/Prefs.kt` wraps `SharedPreferences` for sound, haptics, grid size, theme, and best time.
- `SettingsActivity.kt` only toggles sound/haptics, while `MainActivity` handles challenge mode and best-time updates.
- The result is a compact product shell that still covers the persistence basics expected from a polished Android micro-game.

## Reusable Technical Ideas

- custom `Canvas` game surface with all playfield rendering in one Android `View`
- cached radial-gradient and highlight resources for 3D bubble-style rendering
- multi-pointer drag-to-pop handling through direct `MotionEvent` pointer iteration
- event seam between gameplay surface and activity-owned challenge/product shell
- pure geometry/color helper extraction for fast JVM unit tests
- runtime-generated `SoundPool` effects cached on device instead of bundled assets
- minimal `SharedPreferences` wrapper for challenge/meta settings in a toy-sized game

## Android Relevance

Android relevance is **direct**.

Why it matters:

- the repository is a real Android app with no cross-platform indirection
- it shows a practical custom-`View` approach that still feels current and polished
- it is useful as a counterbalance to the lab's many Compose/libGDX/KMP references

Why it is narrower than a larger architecture sample:

- most of the value is concentrated in one gameplay surface and a tiny activity shell
- there is no separate game-core module, engine layer, or broader content pipeline

## Build And Verification Notes

- The repository includes `gradlew` but does not include `gradlew.bat`, so the normal Windows wrapper-based Gradle discovery path cannot run in this lab.
- The checked-in docs and CI expect JDK `17` and use `./gradlew` on Linux in GitHub Actions.
- `app/build.gradle` targets Android SDK `35`, Kotlin `1.9.22`, and AGP `8.2.0`.
- The visible automated verification surface is healthy for a tiny Android game:
  - `GridMathTest.kt` covers pure geometry/color helpers
  - `BubblePopTest.kt` covers counter updates, reset flow, challenge visibility, and basic pop behavior
  - `.github/workflows/android.yml` runs unit tests, debug assembly, and lint on push/PR

## Risks And Caveats

- The checked-in `README.md` has visible UTF-8/encoding corruption in this environment, including emoji and some text snippets.
- The project is intentionally narrow: it is a polished micro-game, not a reusable engine or a deep gameplay-systems sample.
- Bubble hit detection currently uses a simple linear scan across all bubbles, which is appropriate here but not a scalable pattern for denser boards or larger worlds.
- The absence of `gradlew.bat` makes Windows-side wrapper validation weaker than the Linux CI path advertised in the repository.

## Verdict

Keep `HighviewOne/PopItBubble` as `accepted`.

It is a strong `android-game` reference for the lab because it preserves a direct Android custom-`View` rendering path, tactile multi-touch input, procedural low-latency audio, lightweight persistence, and a healthier test/CI surface than most tiny toy-game repositories.
