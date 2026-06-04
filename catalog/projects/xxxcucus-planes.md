# Project Entry

## Basic Info

- Project name: `Planes`
- Source repository: [https://github.com/xxxcucus/planes](https://github.com/xxxcucus/planes)
- Author / organization: `xxxcucus`
- License: `MIT`
- Research note: [research/findings/xxxcucus-planes.md](../../research/findings/xxxcucus-planes.md)
- Investigated commit: `41485900b8d7e236ab5c6e498be11fe1b47088ac`
- Last verified: `2026-06-04`
- Activity / maintenance status: active at selection; GitHub showed a fresh push on `2026-06-03`, and the inspected default-branch commit was also from the same day.

## Short Description

Android battleship-variant game in a mixed-generation monorepo, with a current Kotlin Compose app, a legacy Android app with real tests, a portable board-game rules core, and a polling-based multiplayer plus chat shell.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `2d`, `android`, `networking`, `input`, `ui-hud`, `testing`
- Engine / framework: Android SDK + Jetpack Compose + Hilt + Retrofit + Room + DataStore + Media3 in the current app, with older Android views/fragments and C++ / Qt desktop implementations preserved in the same repo
- Rendering approach: Compose `Canvas` board rendering with responsive portrait/landscape layouts in the current Android app
- Main language(s): Kotlin primary, plus legacy Java and C++
- Android target: direct; Android app with public Google Play and F-Droid references
- Build system: two Android app roots, `kotlin/PlanesCompose` on Gradle Kotlin DSL and `kotlin/PlanesAndroid` on older Groovy DSL, plus desktop CMake projects

## Why It Matters

- `Planes` is a useful Android product-shell reference because it keeps pure board-game rules, a richer-than-usual mobile feature shell, and a visible rewrite history in one repository.
- Its strongest value is not the board-game idea itself, but the way game rules, multiplayer/chat flow, local storage, tutorials, and release assets are separated and preserved across generations of the app.

## Reusable Ideas

- Gameplay ideas:
  - plane-placement board game with a reusable head-orientation inference AI and asynchronous turn reconciliation
- Architecture patterns:
  - plain Kotlin rules core wrapped by Android-hosted single-player and multiplayer shells, with Hilt-provided round singletons
- Graphics / rendering techniques:
  - symbolic Compose `Canvas` board rendering driven by compact integer annotations rather than heavyweight sprite systems
- Input / UI approaches:
  - tap-select, long-press rotate, and drag-to-move board editing; drawer-routed multi-feature shell around gameplay
- Performance or optimization ideas:
  - keep remote multiplayer/chat polling lightweight while caching messages and unread state locally with Room and preferences in DataStore

## Notable Implementations

- `PlaneRound` and `ComputerLogic` keep board rules and AI portable outside the UI layer.
- `MultiplayerRound` reuses the same game core while adding asynchronous round-end reconciliation.
- `PlaneGridViewModel` mirrors only the board state the Compose UI needs.
- `ChatUserListViewModel` plus Room-backed repositories keep polled chat usable without making every screen talk directly to the backend.
- `VideoModelRepository` and raw assets ship in-app tutorials together with public YouTube references.
- `fastlane` plus Play metadata show real release discipline instead of a code-only sample.

## Android Relevance

- Native Android use:
  - yes; this is a direct Android game and not only a desktop-first codebase
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - especially useful for Android board games or small asynchronous multiplayer/social products that need account/chat/tutorial/product-shell structure around a relatively compact rules core

## Risks / Limitations

- The current Compose rewrite has placeholder tests only.
- The checked-in Compose build currently lacks wrapper files, so fresh-clone build reproducibility is weak.
- The repo is split across multiple generations, which creates drift between current code, legacy tests, and README-level claims.
- Multiplayer is turn-based polling over REST, not a real-time networking reference.

## Notes

Treat `Planes` as both a direct Android game reference and a migration reference. The most reusable value is the separation between portable rules, Android UI shell, local persistence, and backend polling across several generations of the same product.
