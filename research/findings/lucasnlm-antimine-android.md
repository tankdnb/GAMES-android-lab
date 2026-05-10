# Research Note

## Repository Snapshot

- Repository: `lucasnlm/antimine-android`
- Source URL: [https://github.com/lucasnlm/antimine-android](https://github.com/lucasnlm/antimine-android)
- Owner: `lucasnlm`
- Batch ID: [`BATCH-2026-05-10-A`](../batches/BATCH-2026-05-10-A.md)
- Type: `android-game`
- License: `GPL-3.0`
- Selection date: `2026-05-10`
- Last pushed at selection: `2025-08-02`
- Stars at selection: `781`
- Investigated commit: `86400370a7b7bd8e27ccc6520065c6b68d64b8f2`
- Research status: `accepted`
- Build mode: `static-review + gradle-discovery-attempt-timeout`
- Catalog card: [catalog/projects/lucasnlm-antimine-android.md](../../catalog/projects/lucasnlm-antimine-android.md)

## Why This Repository Was Selected

- It is a Kotlin Android game with direct production-grade relevance instead of a tutorial or toy sample.
- The repository is large enough to contain reusable systems, but still practical for a first full workflow rehearsal.
- It promised a useful mix of gameplay logic, Android integration, rendering, and persistence in one codebase.

## Technical Profile

- Main language(s): Kotlin, C++
- Engine / framework: Android app modules with a custom LibGDX rendering layer and native Simon Tatham generator integration
- Rendering stack: LibGDX stage/actor rendering embedded into an Android app
- Android target: direct Android app, including phone, Wear OS, and Android Auto support
- Build system: Gradle Kotlin DSL
- Repository layout summary: multi-module Android project with gameplay logic in `common`, rendering in `gdx`, native generation in `sgtatham`, and additional Android form-factor modules such as `wear` and `auto`
- Key modules reviewed:
  - `common`
  - `gdx`
  - `sgtatham`
  - `external`
  - `wear`
  - `auto`

## Build And Runtime Notes

- The repository was primarily inspected statically.
- A Gradle discovery command was attempted via `.\gradlew.bat help`, but it timed out before producing a reliable lightweight validation result.
- No runtime launch was attempted.
- Known setup limitations:
  - multi-module Android Gradle startup cost is non-trivial
  - native and Android-specific modules make quick build validation expensive for research batches

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `3`
- Implementation depth: `3`
- Code clarity: `2`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - the repository contains reusable Android game architecture, not just gameplay content
  - it shows strong separation between platform UI, gameplay logic, native helpers, and rendering
  - multiple findings are directly transferable into future Kotlin Android games

## Interesting Findings

### Engine Architecture And Core Loop

- `common/src/main/java/dev/lucasnlm/antimine/common/level/logic/GameController.kt` keeps the game flow in a pure Kotlin coordinator instead of burying it inside Android UI classes.
- `common/src/main/java/dev/lucasnlm/antimine/common/level/logic/GameController.kt` uses `plantMinesExcept` to create the board lazily on first open, which is a strong pattern for games where the first interaction must stay safe.
- `common/src/main/java/dev/lucasnlm/antimine/common/level/logic/GameController.kt` tries a native no-guess generator first under a timeout, then falls back to repeated solvable random generation and solver verification. This is a strong resilience pattern for expensive procedural generation.
- `common/src/main/java/dev/lucasnlm/antimine/common/level/logic/MinefieldCreatorImpl.kt` holds the pure Kotlin generation path, keeping the fallback independent from the native integration.
- `common/src/main/java/dev/lucasnlm/antimine/common/level/logic/MinefieldCreatorNativeImpl.kt`, `sgtatham/src/main/java/dev/lucasnlm/antimine/sgtatham/SgTathamMines.kt`, and `sgtatham/src/main/cpp/sgtatham.cpp` show a clean Kotlin-to-native boundary for specialized board generation.

### Rendering And Graphics

- `gdx/src/main/java/dev/lucasnlm/antimine/gdx/stages/MinefieldStage.kt` adapts rendering to the visible area instead of assuming a fixed fullscreen canvas, which matters for Android windowing and split-screen scenarios.
- `gdx/src/main/java/dev/lucasnlm/antimine/gdx/actors/AreaActor.kt` centralizes cell drawing and area-shape joining, which is useful for tile-based board rendering with theming and merged visual states.

### Gameplay Systems

- `common/src/main/java/dev/lucasnlm/antimine/common/level/repository/MinefieldRepositoryImpl.kt` computes board sizing and difficulty-specific board setup in a repository layer, keeping gameplay configuration separate from rendering.
- `common/src/main/java/dev/lucasnlm/antimine/common/level/viewmodel/GameState.kt` exposes game-state transitions in a form usable by UI layers without leaking engine-specific structures.

### Input And Controls

- Input was not the main focus of this pass, but the repository clearly supports multiple control styles from the product layer and keeps game actions routed through `GameController.kt` instead of hardwiring them into the renderer.

### UI, HUD, And Menus

- `gdx/src/main/java/dev/lucasnlm/antimine/gdx/stages/MinefieldStage.kt` and `gdx/src/main/java/dev/lucasnlm/antimine/gdx/actors/AreaActor.kt` together show a reusable pattern for placing a custom board UI inside a standard Android application shell.

### Physics And Collision

- No significant physics or collision systems were relevant in this repository.

### Tooling, Android Integration, Or Other Notable Areas

- `external/src/main/java/dev/lucasnlm/external/model/CloudSave.kt` confirms the project has explicit cloud-save model handling instead of treating persistence as local-only state.
- The presence of top-level `wear` and `auto` modules shows unusually strong Android adaptation depth for a Kotlin game repository and makes the project more valuable than a phone-only sample.

## Reusable Takeaways

- Use a pure Kotlin gameplay core even when the game depends on Android UI and native helpers.
- For expensive procedural generation, combine a preferred high-quality path with timeout and fallback logic instead of blocking the user on one algorithm.
- Keep binary save/load formats explicit and versionable rather than relying on ad hoc JSON for hot gameplay state.
- Treat non-phone Android targets as first-class modules when the product needs them.

## Evidence Summary

- `common/src/main/java/dev/lucasnlm/antimine/common/level/logic/GameController.kt` - gameplay orchestration and board-creation fallback chain
- `common/src/main/java/dev/lucasnlm/antimine/common/level/logic/MinefieldCreatorImpl.kt` - pure Kotlin generator
- `common/src/main/java/dev/lucasnlm/antimine/common/level/logic/MinefieldCreatorNativeImpl.kt` - native-backed generator wrapper
- `common/src/main/java/dev/lucasnlm/antimine/common/io/serializer/SaveFileSerializer.kt` - binary persistence format
- `common/src/main/java/dev/lucasnlm/antimine/common/level/repository/MinefieldRepositoryImpl.kt` - board sizing and configuration
- `gdx/src/main/java/dev/lucasnlm/antimine/gdx/stages/MinefieldStage.kt` - visible-area aware board stage
- `gdx/src/main/java/dev/lucasnlm/antimine/gdx/actors/AreaActor.kt` - themed board-cell rendering
- `external/src/main/java/dev/lucasnlm/external/model/CloudSave.kt` - cloud-save model
- `sgtatham/src/main/java/dev/lucasnlm/antimine/sgtatham/SgTathamMines.kt` - JVM/native bridge
- `sgtatham/src/main/cpp/sgtatham.cpp` - native generator implementation

## Risks Or Limits

- `GPL-3.0` limits direct reuse for proprietary projects.
- The strongest logic is puzzle-specific, so not every subsystem generalizes to non-board games.
- Build validation was inconclusive because the Gradle discovery attempt timed out.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `android-game`
- Focus tags: `2d`, `android`, `libgdx`, `save-load`, `procedural-generation`
- Follow-up needed:
  - inspect the `wear`, `auto`, and preferences/control modules later if the lab wants deeper form-factor UX patterns
