# Beat Feet

- Project: [beat-feet/beat-feet](https://github.com/beat-feet/beat-feet)
- Category: `android-game`
- Status: `accepted`
- License: `GPL-3.0`
- Language: `Kotlin`
- Engine / stack: libGDX + Android SDK + headless song-preprocessing tool
- Android relevance: direct Android rhythm-platformer with reusable audio-to-level-generation and custom-song ingestion patterns

## Short Description

`Beat Feet` is a Kotlin/libGDX Android rhythm-platformer where obstacle courses are generated from analyzed MP3 features instead of being authored manually.

## Why It Matters

- Preserves both runtime gameplay code and the offline pipeline that converts music into level data.
- Separates procedural obstacle geometry from visual theming, which is a strong reusable content-generation pattern.
- Adds a concrete Android reference for custom-song import, cached preprocessing, and rhythm-synced platform gameplay.

## Key Reusable Ideas

- offline MP3 feature extraction into compact JSON gameplay data
- time-to-world scaling for rhythm-driven scrolling levels
- merged obstacle generation from low/mid/high feature bands
- separation between abstract obstacle rectangles and tile/sprite dressing
- warm-up state before starting music to improve sync and perceived polish
- cacheable custom-level ingestion path for user-supplied audio

## Main Caveats

- GPL-3.0 limits direct code reuse in closed-source products
- local Gradle discovery in the lab fails because AGP `7.4.2` needs Java `11+` while the machine still exposes Java `8`
- the visible automated test surface is relatively small compared with the gameplay/runtime surface

## Suggested Focus Tags

`2d`, `android`, `libgdx`, `audio`, `procedural-generation`, `input`, `ui-hud`, `asset-pipeline`
