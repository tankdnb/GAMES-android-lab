# Project Entry

## Basic Info

- Project name: `La Bomba`
- Source repository: [https://github.com/edezadev/la-bomba](https://github.com/edezadev/la-bomba)
- Author / organization: `edezadev`
- License: `Apache-2.0`
- Research note: [research/findings/edezadev-la-bomba.md](../../research/findings/edezadev-la-bomba.md)
- Investigated commit: `eee85afa520e9e3fc5685931123d71377ee4482f`
- Last verified: `2026-06-04`
- Activity / maintenance status: active at selection; GitHub showed a fresh push on `2026-06-03`, and the inspected default-branch commit from the clone was also from the same day, although the public signal and test surface remain very small.

## Short Description

Android Material 3 party-game app where players configure penalties, players, topics, and a countdown timer, then play local pass-the-device rounds backed by anonymous Firebase auth and per-user Firestore content.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `android`, `ui-hud`, `audio`, `networking`, `save-load`
- Engine / framework: Android SDK + Material Design 3 + Firebase Firestore/Auth/Analytics + Google Mobile Ads + Media3 ExoPlayer
- Rendering approach: standard Android views, fragments, RecyclerView, ViewPager2, and Material bottom sheets instead of a custom renderer
- Main language(s): Kotlin
- Android target: direct; Android-only application
- Build system: single-module Gradle Kotlin DSL Android app with AGP `8.13.2`, Kotlin `2.3.20`, and `compileSdk 35`

## Why It Matters

- `La Bomba` is a useful direct-Android reference for small social or party-game products that need a real app shell more than a heavy engine runtime.
- Its strongest value is the product flow: anonymous Firebase bootstrap, cloud-backed custom content, a fragment-hosted setup wizard, timer-driven rounds, and a replay path that preserves only tied players.

## Reusable Ideas

- Gameplay ideas:
  - timer-driven local pass-the-device rounds with optional punishments, tied-player rematches, and custom user-authored topics
- Architecture patterns:
  - one base activity for lifecycle/UI chrome, one setup wizard, one process-global session model, and thin Firebase data managers for user-owned content
- Graphics / rendering techniques:
  - use standard Android UI layers when the game does not need a separate rendering runtime
- Input / UI approaches:
  - fragment-by-fragment setup flow, bottom-sheet-based content editing, and explicit loser selection after each round
- Performance or optimization ideas:
  - Firestore local cache plus background topic pagination keeps cloud-backed content lightweight for phones

## Notable Implementations

- `FirebaseAuthManager` creates anonymous users and seeds default penalty data automatically.
- `TopicDbManager.getListPagesListener(...)` paginates topic data into pages in a background coroutine before posting back to the UI.
- `BaseActivity` centralizes edge-to-edge behavior, fullscreen flags, loading dialogs, and double-back exit handling.
- `StartGameActivity` couples timer length to specific countdown audio and round transitions.
- `ResultsActivity` supports tied-player rematches and prunes non-tied players from the stored player list.
- `AdsManager` keeps the game flow non-blocking even when no ad is loaded.

## Android Relevance

- Native Android use:
  - yes; this is a direct Android app, not a desktop-first port
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - especially useful for Android party, quiz, or casual-social products that need setup UX, cloud-backed user content, and lifecycle-safe session handling more than they need low-level rendering patterns

## Risks / Limitations

- The repository has almost no public signal and no meaningful automated test surface.
- The app is local multiplayer in practice, not a remote real-time multiplayer architecture sample.
- `GameSession` is a mutable global singleton, which is fine for a small app but weak for larger products.
- `SETUP.md` still claims `Java 8+`, while the real build now needs at least Java `11`.
- The manifest still uses a sample AdMob app ID, so the monetization wiring should be treated as a pattern, not as production-ready configuration.

## Notes

Treat `La Bomba` as a direct Android product-shell reference. Its most reusable value is the way cloud-backed setup content, a guided configuration flow, timed rounds, and small-session UX stay readable in one Kotlin codebase.
