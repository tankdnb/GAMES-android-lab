# GamesHubAndroid

- Project: [masafykun/GamesHubAndroid](https://github.com/masafykun/GamesHubAndroid)
- Category: `reference-only`
- Status: `reference-only`
- License: `MIT`
- Language: `Kotlin`
- Engine / stack: Android SDK + Jetpack Compose + Navigation Compose
- Android relevance: direct Android mini-game bundle with a Compose-only product shell
- Investigated commit: `8764e9562643605ca99d9ec9600e82a4b680e534`

## Short Description

`GamesHubAndroid` is a Kotlin/Compose Android app that bundles roughly one hundred mini-games behind a searchable catalog, featured lists, and per-game navigation.

## Why It Matters

- Shows a direct Android approach for a many-mini-game launcher/catalog without bringing in a separate engine.
- Preserves compact Compose-native examples for simple puzzle, touch, and Canvas game screens.
- Helps the lab compare “large breadth, low shared-core depth” repositories against stronger accepted architecture references.

## Key Reusable Ideas

- in-memory mini-game registry powering featured rows, search, and navigation
- one-app Compose shell for launching many tiny self-contained game screens
- simple `LaunchedEffect` tick loops for small Canvas-based mini-games
- readable single-file gameplay logic examples such as the 2048 move/merge implementation

## Main Caveats

- architecture is heavily hardcoded around one registry list and one giant manual dispatch
- no meaningful test surface was found during the static review
- better used as a comparison sample than as a primary architecture baseline

## Suggested Focus Tags

`2d`, `android`, `input`, `ui-hud`
