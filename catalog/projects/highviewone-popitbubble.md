# PopItBubble

- Project: [HighviewOne/PopItBubble](https://github.com/HighviewOne/PopItBubble)
- Category: `android-game`
- Status: `accepted`
- License: `MIT`
- Language: `Kotlin`
- Engine / stack: Android SDK + custom `View` / Canvas + `SoundPool` + `SharedPreferences`
- Android relevance: direct Android-native micro-game with a custom rendering and input surface
- Investigated commit: `8d2e15f16e6cfd64e4cb9ca259b504981fff311d`

## Short Description

`PopItBubble` is an Android sensory/fidget game that renders a pop-it board with custom Canvas gradients, multi-touch popping, generated pop sounds, haptics, and a small challenge/settings shell.

## Why It Matters

- Shows a clean direct-Android path for a polished tactile micro-game without needing Compose or libGDX.
- Preserves reusable patterns for custom `View` rendering, low-latency audio, and lightweight product-shell persistence.
- Gives the lab a compact native-shell reference that complements the larger engine and gameplay-system entries.

## Key Reusable Ideas

- one custom `View` owning full playfield rendering and touch handling
- cached radial-gradient shader setup for 3D bubble-like Canvas visuals
- multi-pointer drag-to-pop handling over a compact grid
- event seam between the gameplay surface and the activity-owned challenge shell
- pure geometry helper extraction for fast JVM tests
- runtime-generated and cached `SoundPool` effects instead of bundled audio assets

## Main Caveats

- architecture is intentionally small and concentrated in one gameplay view
- Windows wrapper validation is limited because `gradlew.bat` is not checked in
- checked-in README encoding is visibly broken in this environment

## Suggested Focus Tags

`2d`, `android`, `input`, `ui-hud`, `audio`, `testing`
