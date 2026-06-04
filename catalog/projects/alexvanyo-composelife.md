# Project Entry

## Basic Info

- Project name: `ComposeLife`
- Source repository: [https://github.com/alexvanyo/composelife](https://github.com/alexvanyo/composelife)
- Author / organization: `alexvanyo`
- License: `Apache-2.0`
- Research note: [research/findings/alexvanyo-composelife.md](../../research/findings/alexvanyo-composelife.md)
- Investigated commit: `aa25b0f4a35de9bcc893559da4ed83d101177b59`
- Last verified: `2026-06-04`
- Activity / maintenance status: active Android and multiplatform product work; the latest inspected commit is `Update KSP to 2.3.9` from `2026-06-02`, and the repository was pushed again on `2026-06-03`.

## Short Description

Android-first Game of Life simulator and Wear OS watchface built with Jetpack Compose and Kotlin Multiplatform, with a richer-than-usual architecture surface around simulation state, rendering backends, custom navigation, DI, content synchronization, and CI.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `2d`, `android`, `multiplatform`, `shader`, `ui-hud`, `save-load`, `testing`, `performance`
- Engine / framework: Android SDK + Jetpack Compose + Compose Multiplatform + Metro dependency injection + custom Game of Life core
- Rendering approach: Compose UI plus AGSL on Android, SKSL on Skiko, and OpenGL ES for the Wear watchface renderer
- Main language(s): Kotlin
- Android target: direct Android app plus Wear OS watchface and configuration modules, with desktop and web hosts sharing the same simulation and data core
- Build system: Gradle Kotlin DSL monorepo with included convention plugins, Kotlin Multiplatform, Android benchmark/screenshot modules, and a large CI matrix

## Why It Matters

- `ComposeLife` is useful because it is a real Android product shell rather than only a tiny demo. It shows how a Compose-first interactive app can scale across phone, watch, desktop, and web while still keeping simulation, rendering, DI, navigation, and sync concerns explicit.
- Its best value for the lab is not "Game of Life rules" by themselves, but the surrounding architecture: algorithm hot-swapping, GPU-backed cell rendering, custom stateful navigation, activity-scoped updatables, and background content sync.

## Reusable Ideas

- Gameplay ideas:
  - more simulation-product than traditional gameplay; the reusable value is in the simulation shell, grid evolution controls, and watchface time-as-pattern concept
- Architecture patterns:
  - explicit evolving-state model via `TemporalGameOfLifeState`
  - Metro + context-parameter `Ctx` wrappers for large Compose trees
  - state-based navigation with retained entry map and serializable surrogates
- Graphics / rendering techniques:
  - one cell-shape shader concept reused across AGSL, SKSL, and OpenGL
  - watchface rendering built from a cell-mask texture plus shader-shaped cells
- Input / UI approaches:
  - adaptive Compose shell with centralized graph creation and theme control
  - typed navigation state instead of route-string-only flows
- Performance or optimization ideas:
  - `HashLife` memoization
  - rendezvous-buffered simulation stepping
  - GPU-backed cell rendering instead of per-cell UI drawing
  - hash-deduped remote archive synchronization

## Notable Implementations

- `TemporalGameOfLifeState` and `TemporalGameOfLifeStateMutator`
- `ConfigurableGameOfLifeAlgorithm` and `HashLifeAlgorithm`
- Metro plus context-parameter DI pattern from `docs/di.md`
- custom `navigation` module with `MutableBackstackNavigationController`
- AGSL and SKSL cell renderers
- OpenGL ES watchface renderer and `GameOfLifeShape`
- `PatternCollectionRepositoryImpl` plus WorkManager-backed sync scheduling
- deep Android and Wear CI/test matrix

## Android Relevance

- Native Android use:
  - yes; this is a direct Android and Wear OS product
- Kotlin relevance:
  - very high
- Porting or adaptation notes:
  - especially useful for Android teams building simulation-heavy or tool-like game products in Compose, or for teams that need a reference for shared Kotlin modules around rendering, state, sync, and wearable variants

## Risks / Limitations

- The repository is a large monorepo and may be heavier than needed for small games.
- Normal Windows checkout fails on the checked-in `:`-named watchface solution resources.
- Local build validation in this lab still depends on a newer JDK and Android-ready environment.
- Some product details are specific to a Game of Life simulator and watchface rather than a general gameplay engine.

## Notes

`ComposeLife` is a strong main-catalog reference because it combines Android relevance, real public signal, active maintenance, and several reusable architecture ideas that go well beyond a single polished UI sample.
