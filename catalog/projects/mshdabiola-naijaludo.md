# Project Entry

## Basic Info

- Project name: `Naijaludo`
- Source repository: [https://github.com/mshdabiola/Naijaludo](https://github.com/mshdabiola/Naijaludo)
- Author / organization: `mshdabiola`
- License: `GPL-3.0`
- Research note: [research/findings/mshdabiola-naijaludo.md](../../research/findings/mshdabiola-naijaludo.md)
- Investigated commit: `013e99dca4a65709d5cf81995ba8c384e6a48ba9`
- Last verified: `2026-06-04`
- Activity / maintenance status: active small project; the inspected default `develop` branch still had code pushes in late `2025`, GitHub metadata remained fresh in `2026`, and the repository exposes a serious CI/release workflow for its scale.

## Short Description

Android-first Kotlin Multiplatform Ludo product with a shared board-game rules engine, Compose feature shell, persistent save/meta state, desktop and WASM targets, and stronger-than-usual workflow discipline for a small public game repository.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `2d`, `android`, `multiplatform`, `ui-hud`, `input`, `ai`, `networking`, `save-load`, `testing`
- Engine / framework: Kotlin Multiplatform + Jetpack Compose + Compose Desktop + WASM + Koin + DataStore
- Rendering approach: Compose-rendered board-game UI with device-specific layouts and board-skin injection
- Main language(s): Kotlin
- Android target: direct Android app with `GooglePlay` and `FossReliant` variants
- Build system: Gradle `8.13` wrapper + AGP `8.8.1` + Kotlin `2.1.10`

## Why It Matters

- `Naijaludo` is worth keeping because it combines several ideas that are often scattered across separate references in this lab:
  - a standalone shared board-game core
  - a productized Android Compose shell
  - save/resume and meta-game persistence
  - multiplayer seams
  - screenshot/baseline-profile workflow discipline
- It is especially useful as a reference for Android board or turn-based casual games that need more than just a toy UI demo.

## Reusable Ideas

- Gameplay ideas:
  - indexed Ludo/race-game board model, staged counter-to-pawn turn flow, and compact heuristic AI
- Architecture patterns:
  - shared rules engine in its own module, feature-level orchestration in `ViewModel`, and subclass-based achievement/meta logging
- Graphics / rendering techniques:
  - Compose board shell with device-form-factor layouts and injected board-skin configuration
- Input / UI approaches:
  - dialog-driven setup/restart flow, lifecycle-aware pause/resume, and simple remote command protocol strings
- Performance or optimization ideas:
  - baseline-profile generation, screenshot regression workflow, and broad CI verification for a small game product

## Notable Implementations

- `LudoGame.kt` centralizes the playable rules engine instead of burying rules inside UI code.
- `RandomComputerPlayer.kt` shows a compact heuristic AI for a deterministic dice/board game.
- `GameViewModel.kt` owns save/resume, remote command handling, dialogs, and product flow above the shared rules core.
- `LogLudo.kt` layers achievements and meta logging onto the base game through an explicit seam.
- `StoreImpl.kt` and `CurrentState.kt` show a practical all-in-one save shell for settings, cosmetics, save slots, and meta progression.

## Android Relevance

- Native Android use:
  - yes, direct Android product with feature flavors and shipping-oriented workflow
- Kotlin relevance:
  - very high
- Porting or adaptation notes:
  - strongest as a reference for board-game cores, Android Compose product shells, meta progression, and workflow discipline; revisit multiplayer carefully because the checked-in Android DI binding currently points at a stub implementation

## Risks / Limitations

- Android multiplayer wiring looks inconsistent: the Koin Android module binds a stub `P2pManager`, while a richer Wi-Fi P2P implementation exists elsewhere in the tree.
- AI logic is useful but not pristine; visible `bug` / `Todo` markers remain in the active implementation.
- The README license text drifts from the actual repository metadata.
- GPL-3.0 licensing makes it a stronger architecture reference than a copy-paste implementation source for many downstream teams.

## Notes

`Naijaludo` is one of the stronger direct Android board-game references in the lab so far. Its biggest value is not the Ludo theme itself, but the way it splits rules, product orchestration, persistence, and workflow discipline into understandable pieces that can be reused in future Android game projects.
