# Letterly Android

- Project: [sridharprasath94/Letterly-Android](https://github.com/sridharprasath94/Letterly-Android)
- Category: `android-game`
- Status: `accepted`
- License: `MIT`
- Language: `Kotlin`
- Engine / stack: Android SDK + Views/XML + Fragments + Navigation + Hilt + Room + Coroutines/Flow
- Android relevance: direct Android word-puzzle product with a modern fragment-based shell
- Investigated commit: `f030ad0443683ca685e22f8d00fe5eacd28be6d1`

## Short Description

`Letterly-Android` is a Wordle-style Android puzzle game with three difficulty modes, Room-backed dictionary validation, resumable game state, statistics tracking, and a use-case-driven domain layer.

## Why It Matters

- Shows a stronger-than-average direct Android puzzle architecture with clear `data` / `domain` / `presentation` boundaries.
- Preserves reusable patterns for guess evaluation, duplicate handling, keyboard-state derivation, and per-mode save/resume flow.
- Gives the lab a solid non-Compose Android reference for a modern casual-game shell.

## Key Reusable Ideas

- domain use cases for guess submission, keyboard updates, game-status checks, and duplicate validation
- parameterized game modes sharing one board/session architecture
- tested two-pass Wordle-style duplicate-letter evaluation
- per-mode active-game persistence and stats persistence
- Room-backed local dictionary plus random-word selection by target length

## Main Caveats

- local test-task discovery still needs a configured Android SDK
- AI hint flow depends on external worker configuration
- this is product-shell architecture, not a reusable rendering/runtime engine

## Suggested Focus Tags

`2d`, `android`, `input`, `ui-hud`, `save-load`, `testing`
