# Research Note

## Repository Snapshot

- Repository: `korlibs/korge`
- Source URL: [https://github.com/korlibs/korge](https://github.com/korlibs/korge)
- Owner: `korlibs`
- Batch ID: [`BATCH-2026-05-10-A`](../batches/BATCH-2026-05-10-A.md)
- Type: `engine-framework`
- License: `Other`
- Selection date: `2026-05-10`
- Last pushed at selection: `2026-05-08`
- Stars at selection: `2998`
- Investigated commit: `42a995a0564191fa4b8bda5537abb304672bdda8`
- Research status: `accepted`
- Build mode: `static-review-only`
- Catalog card: [catalog/projects/korlibs-korge.md](../../catalog/projects/korlibs-korge.md)

## Why This Repository Was Selected

- It is one of the highest-signal Kotlin game-engine repositories with ongoing activity.
- The engine has direct Android relevance while still showing general runtime architecture worth studying.
- It provides strong contrast against game-specific repos by exposing reusable engine/runtime decisions.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: KorGE on top of Korlibs
- Rendering stack: KorGE scene graph and `GameWindow` abstractions across platform backends
- Android target: explicit Android host-view support through Android-specific source sets
- Build system: Gradle Kotlin DSL monorepo
- Repository layout summary: large engine monorepo with runtime, core windowing/rendering, Gradle plugin, reload agent, sandbox, and supporting modules
- Key modules reviewed:
  - `korge`
  - `korge-core`
  - `korge-reload-agent`
  - `korge-sandbox`
  - Android source-set variants under `korge` and `korge-core`

## Build And Runtime Notes

- The repository was investigated through static code review only.
- No build or runtime validation was attempted in this batch because the monorepo is large and the main research value was architectural.
- Known setup limitations:
  - large engine monorepo
  - multiple platform targets and plugins increase validation cost

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `3`
- Implementation depth: `3`
- Code clarity: `2`
- Novelty: `3`
- Overall verdict: `accepted`
- Why:
  - the repository contains several strong runtime patterns directly applicable to Kotlin game architecture
  - Android embedding is explicit and not an afterthought
  - the engine demonstrates reusable solutions for scene routing, hot reload, and frame-aware coroutine dispatch

## Interesting Findings

### Engine Architecture And Core Loop

- `korge/src/korlibs/korge/scene/SceneContainer.kt` is a strong scene-routing subsystem with transitions, async `changeTo`, async `pushTo`, history stack support, `back`, `forward`, and reload-event handling.
- `korge/src/korlibs/korge/scene/SceneContainer.kt` uses a dedicated `TransitionView` to render scene swaps, which keeps transition mechanics separate from scene logic.
- `korge/src/korlibs/korge/view/Stage.kt` acts as the fixed-size root container and exposes shared runtime state such as input, injector access, and resize invalidation.

### Rendering And Graphics

- `korge-core/src/korlibs/render/GameWindow.kt` abstracts lifecycle, rendering, input, dialogs, fullscreen state, and other platform-window behavior behind one runtime contract.
- `korge-core/src@android/korlibs/render/DefaultGameWindowAndroid.kt` shows that Android support lives at the window layer and can be embedded without requiring the engine to own an activity outright.

### Gameplay Systems

- This repository is an engine/framework rather than a finished game, so the strongest value is runtime infrastructure rather than gameplay rules.

### Input And Controls

- `korge/src/korlibs/korge/view/Stage.kt` and `korge-core/src/korlibs/render/GameWindow.kt` centralize input and lifecycle concerns at the runtime boundary, which is a good pattern for keeping game code independent of raw Android event plumbing.

### UI, HUD, And Menus

- The scene-container system is useful for menu and flow management because navigation and transitions are first-class runtime features rather than ad hoc screen switches.

### Physics And Collision

- Physics was not a focus of this pass.

### Tooling, Android Integration, Or Other Notable Areas

- `korge/src@android/korlibs/korge/android/KorgeAndroidView.kt` exposes the engine as a reusable Android `View`, including explicit load and unload methods. This is a high-value pattern for hybrid apps or editor-like shells.
- `korge-core/src@android/korlibs/render/DefaultGameWindowAndroid.kt` uses `AndroidGameWindowNoActivity`, which is a strong reference for embedding an engine runtime inside a host app instead of owning the full Android lifecycle.
- `korge-reload-agent/src/main/kotlin/korlibs/korge/reloadagent/KorgeReloadAgent.kt` shows hot-reload support as a separate tooling component instead of entangling it directly with core game code.

## Reusable Takeaways

- Keep screen and scene navigation as a runtime subsystem with history and transition support, not as scattered screen-manager utilities.
- If Android embedding matters, provide a host-`View` integration layer instead of assuming every game owns the whole activity.
- Budget coroutine and callback work per frame to protect frame pacing.
- Keep hot reload and live iteration features isolated from core runtime logic.

## Evidence Summary

- `korge/src/korlibs/korge/scene/SceneContainer.kt` - scene management, history, transitions, reload behavior
- `korge/src/korlibs/korge/view/Stage.kt` - root scene-graph container and shared runtime state
- `korge/src@android/korlibs/korge/android/KorgeAndroidView.kt` - Android `View` embedding and lifecycle
- `korge-core/src/korlibs/render/GameWindow.kt` - cross-platform runtime/window abstraction
- `korge-core/src/korlibs/render/GameWindowCoroutineDispatcher.kt` - per-frame callback budget and queue handling
- `korge-core/src@android/korlibs/render/DefaultGameWindowAndroid.kt` - Android game window implementation
- `korge-reload-agent/src/main/kotlin/korlibs/korge/reloadagent/KorgeReloadAgent.kt` - hot-reload tooling

## Risks Or Limits

- The repository license is reported as `Other`, so reuse terms need direct legal review before code adoption.
- This is a large engine monorepo, so extracting only the desired ideas matters more than copying whole subsystems.
- No build validation was attempted in this batch.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `engine-framework`
- Focus tags: `android`, `multiplatform`, `scene-graph`, `korge`, `performance`
- Follow-up needed:
  - inspect the Gradle plugin and sample/sandbox modules later if the lab wants project-scaffolding and content-pipeline patterns
