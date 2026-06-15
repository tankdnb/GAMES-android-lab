# Mafiauto

- Project: [amirroid/mafiauto](https://github.com/amirroid/mafiauto)
- Category: `gameplay-systems`
- Status: `accepted`
- License: `MIT`
- Language: `Kotlin`
- Engine / stack: Kotlin Multiplatform + Compose Multiplatform + dedicated Mafia rules engine + SQLDelight + Koin
- Android relevance: direct Android product shell over a shared Kotlin rules engine

## Short Description

`Mafiauto` is a multiplatform Mafia game assistant that automates role assignment, night actions, voting, logs, and win-condition resolution through a shared Kotlin engine.

## Why It Matters

- Shows how to keep a party game's real rules runtime in shared Kotlin instead of burying flow inside screens.
- Preserves clean patterns for phase-state modeling, delayed action resolution, and feature-by-feature UI adaptation.
- Gives the lab a strong non-rendering gameplay reference with direct Android relevance.

## Key Reusable Ideas

- sealed phase-state machine for turn-based or social-deduction games
- `StateFlow`-owned gameplay runtime plus transient message channel
- delayed and ordered action resolution through scheduled actions
- role definitions as capability objects with target rules and win hooks
- domain and repository seam between rules engine and product UI
- feature view models that adapt one shared gameplay runtime into screen-local flows

## Main Caveats

- strongest value is gameplay-state architecture, not graphics or rendering
- README encoding is currently broken in the checked-in repository
- local Gradle discovery in the lab fails because Gradle `9.5.1` now requires Java `17+` while the machine still exposes Java `8`

## Suggested Focus Tags

`android`, `multiplatform`, `ui-hud`, `save-load`, `testing`
