# Research Note

## Repository Snapshot

- Repository: `Mesabloo/hm-defense`
- Source URL: [https://github.com/Mesabloo/hm-defense](https://github.com/Mesabloo/hm-defense)
- Owner: `Mesabloo`
- Batch ID: [`BATCH-2026-06-04-P`](../batches/BATCH-2026-06-04-P.md)
- Type: `android-game`
- License: `BSD-3-Clause`
- Selection date: `2026-06-04`
- Last pushed at selection: `2025-01-16`
- Stars at selection: `38`
- Investigated commit: `a4446660141e78829aa573af2e66de3329a19d00`
- Research status: `reference-only`
- Build mode: `static-review + gradle-help`
- Catalog card: [catalog/projects/mesabloo-hm-defense.md](../../catalog/projects/mesabloo-hm-defense.md)

## Why This Repository Was Selected

- `hm-defense` was the stronger remaining candidate in the current explicit-license shortlist after `libgdx/gdx-liftoff`.
- Compared with the fresher but zero-star `edezadev/la-bomba`, it promised a clearer runtime/UI surface, a more readable Kotlin codebase, and stronger expected reuse value around libGDX-era Android-friendly game structure.
- The main question for this batch was whether the repository still deserved a main-catalog slot as an Android game reference, or whether it should be kept only as a comparison sample. Static review points to the latter.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: custom libGDX game shell with Scene2D UI, Box2D world glue, and an LWJGL desktop launcher
- Rendering stack: libGDX Scene2D + custom deferred `Batcher` + texture atlases + Box2D debug rendering
- Android target: planned in the README, but no Android module is checked in; the inspected tree only contains `core` and `desktop`
- Build system: multi-module Gradle Groovy DSL build with `core` plus `desktop`, Java `11` targets, Kotlin `1.6.0`, and libGDX `1.11.0`
- Repository layout summary: root Gradle workspace, `core` gameplay/runtime/UI/assets module, `desktop` launcher module, and a small `docs` folder
- Source footprint:
  - total files counted in repository: `199`
  - Kotlin/Java/build-script files counted in repository: `114`
- Test surface:
  - Kotlin files matching common test naming patterns: `0`
  - meaningful automated assertion-heavy tests found: `0`
- Key modules reviewed:
  - `README.md`
  - `docs/Gameplay.md`
  - `settings.gradle`
  - `build.gradle`
  - `core/build.gradle`
  - `desktop/build.gradle`
  - `gradle.properties`
  - `core/src/kotlin/fr/mesabloo/heavymachdefense/MainGame.kt`
  - `core/src/kotlin/fr/mesabloo/heavymachdefense/screens/AbstractScreen.kt`
  - `core/src/kotlin/fr/mesabloo/heavymachdefense/screens/StageScreen.kt`
  - `core/src/kotlin/fr/mesabloo/heavymachdefense/world/GameWorld.kt`
  - `core/src/kotlin/fr/mesabloo/heavymachdefense/world/UIWorld.kt`
  - `core/src/kotlin/fr/mesabloo/heavymachdefense/data/GameSave.kt`
  - `core/src/kotlin/fr/mesabloo/heavymachdefense/internal/Batcher.kt`
  - `core/src/kotlin/fr/mesabloo/heavymachdefense/managers/assets/StageAssetsManager.kt`
  - `core/src/kotlin/fr/mesabloo/heavymachdefense/ui/stage/BuildQueue.kt`
  - `core/src/kotlin/fr/mesabloo/heavymachdefense/ui/stage/Radar.kt`
  - `core/src/kotlin/fr/mesabloo/heavymachdefense/ui/stage/slots/SlotKinds.kt`
  - `desktop/src/kotlin/fr/mesabloo/heavymachdefense/desktop/DesktopLauncher.kt`
  - `core/assets/data/build-info.json`
  - `core/assets/data/upgrades.json`

## Build And Runtime Notes

- The repository was investigated through static review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeds after downloading Gradle `6.7.1`; the launcher JVM in this lab is still Java `8`.
- `cmd /c gradlew.bat help --no-daemon` also succeeds and configures the checked-in modules cleanly.
- The checked-in build itself targets Java `11` in both `core/build.gradle` and `desktop/build.gradle`.
- The important build conclusion is structural, not environmental:
  - the repository does not include any Android module today
  - `desktop` is the only runnable host checked into the tree
  - the README still lists Android and iOS installation sections as TODO-only placeholders
- No live runtime launch was attempted.

## Usefulness Assessment

- Reuse potential: `2`
- Android transfer: `1`
- Implementation depth: `2`
- Code clarity: `2`
- Novelty: `2`
- Overall verdict: `reference-only`
- Why:
  - the repository contains a few compact libGDX/Scene2D ideas worth preserving, especially around HUD composition, data-driven build metadata, a radar tied to a scrolling battlefield, and a tiny z-sorted deferred batcher
  - however, the checked-in runtime is unfinished, the advertised Android target is not actually present, the visible code activity is stale in practice, and there is no real verification surface
  - it is more useful as a comparison sample for old-school libGDX UI/runtime structure than as a primary Android baseline

## Interesting Findings

### Engine Architecture And Core Loop

- `MainGame.kt` keeps the app shell small: preload managers, initialize Box2D, and swap screens instead of mixing startup, UI, and stage-specific logic together.
- `AbstractScreen.kt` is the more reusable seam. It gives each screen one `UIWorld`, separate background and foreground groups, an `InputMultiplexer`, and tween-driven transition overlays rather than letting every screen reassemble those concerns.
- `StageScreen.kt` builds the actual game shell around a scrollable battlefield plus a fixed HUD. The battlefield lives in a `ScrollPane` over `Terrain`, while build slots, gauges, queue, menus, and radar stay in fixed screen-space actors.
- `UIWorld.kt` keeps the visible UI surface intentionally smaller than the world height and flushes a custom batch after Scene2D draw calls. That is a useful small-engine pattern when a game needs normal actor composition plus some explicit render ordering control.
- `GameWorld.kt` is intentionally thin. It steps Box2D, mirrors body positions back into Scene2D actors, and relies on the stage/UI layer to own most visible gameplay structure.

### Rendering And Graphics

- `Batcher.kt` is the cleanest rendering-specific takeaway in the repository. It queues sprites, textures, regions, and fonts with explicit z-indices, sorts only at flush time, and gives the project a tiny alternative to immediate actor-order-only drawing.
- `StageAssetsManager.kt` keeps atlases and textures grouped by gameplay domain instead of scattering asset-string lookups across screens. For a medium-size libGDX project, that centralization is still a practical pattern.
- `Radar.kt` is a compact and reusable HUD idea: it mirrors a `ScrollPane` viewport into a tiny radar, tracks ally/enemy bases by scanning battlefield actors, and draws the visible window outline independently from main-world rendering.
- The rendering stack is readable, but it is also incomplete. Much of the visible game is still static stage composition and asset presentation rather than a fully realized battlefield simulation.

### UI, HUD, And Menus

- `StageScreen.kt` shows a dense Scene2D HUD shell with gauges, build queues, side-slot panels, scrollable terrain, radar, modal system menu, and tweened upgrade-menu transitions all inside one screen.
- The machine and special side menus are data-aware rather than hardcoded to one slot. `MachineBuildSlot` and `SpecialBuildSlot` derive labels, costs, icons, and enabled state from `GameSave` plus JSON-backed definitions.
- `BuildQueue.kt` is a useful small-product pattern for time-based production UI: queue entries animate into place, track elapsed build time, and expose per-kind counts back to slot widgets.
- The biggest UI caveat is also one of the biggest runtime caveats: the queue reaches `"TODO: create machine in world"` instead of finishing the gameplay loop, so this shell is better studied as UI composition than as a finished game flow.

### Physics And Collision

- `GameWorld.kt` shows the intended physics seam clearly: Box2D owns body motion, Scene2D actors mirror body positions, and border contacts are observed centrally through a `ContactListener`.
- The project uses Box2D mostly as a world/placement layer in the inspected revision. There is no rich collision-response or gameplay-verified physics subsystem here yet.
- `createTerrainBody(...)` and the battlefield-body sync pattern still matter as a reusable libGDX baseline for games that want stage actors and Box2D bodies to coexist without a full ECS.

### Persistence And Data

- `GameSave.kt` is a useful snapshot of how the repository models progression: typed upgrade maps, slot inventories, special counts, credits, completed stages, and named save metadata live in one serializable structure.
- `build-info.json`, `upgrades.json`, and `special-info.json` separate balance data from slot UI and build-time logic, which is still one of the cleaner patterns in the repo.
- The build and upgrade system is more data-driven than the runtime maturity might suggest. That makes the repository more useful for economy/HUD reference work than for full gameplay reference work.

### Tooling And Content Pipeline

- The `core` / `desktop` split is small but sensible: assets live in `core/assets`, and `desktop` simply points its runtime working directory there.
- `StageAssetsManager.kt` plus the JSON data files show a lightweight content-pipeline pattern where atlases, textures, and gameplay tables are centralized without introducing extra authoring tooling.
- The project is also a cautionary tooling example: a repository can still feel moderately organized while lacking the target platform module it claims to aim for.

## Reusable Takeaways

- A `ScrollPane`-backed battlefield plus fixed HUD layer is still a workable pattern for portrait libGDX strategy or defense games.
- A tiny deferred z-sorted batcher can extend Scene2D without forcing a whole renderer rewrite.
- Radar/minimap features can be built by observing the same actor tree the UI already owns instead of introducing a second world representation.
- JSON-backed build and upgrade tables age better than hardcoded slot logic, even in a partially finished project.
- Repo descriptions and actual code state diverge often enough that Android relevance should always be verified from module layout, not from README intent.

## Evidence Summary

- `MainGame.kt`, `AbstractScreen.kt`, `StageScreen.kt`, `UIWorld.kt`, `GameWorld.kt` - core runtime shell, screen ownership, battlefield-vs-HUD split, and actor-synced Box2D stepping
- `Batcher.kt`, `Radar.kt`, `StageAssetsManager.kt` - z-sorted deferred drawing, minimap viewport mirroring, and centralized stage assets
- `BuildQueue.kt`, `MachineBuildSlot`, `SpecialBuildSlot` - production queue UI, slot derivation from save/data state, and side-menu composition
- `GameSave.kt`, `build-info.json`, `upgrades.json` - typed save/progression state and data-driven balance definitions
- `README.md`, `core/build.gradle`, `desktop/build.gradle`, `settings.gradle` - desktop-only checked-in host surface despite README claims about future Android support

## Risks Or Limits

- No Android module is checked in, so the repository is not a direct Android runtime reference today.
- The latest inspected commit in the clone is `2022-06-23`, which makes the runtime feel much staler than the repository metadata alone suggested at selection time.
- `BuildQueue.kt` still ends with `"TODO: create machine in world"`, so one of the most visible gameplay loops is unfinished.
- `TurretBuildSlot.updateBuildingNumber()` is still `TODO("Not yet implemented")`.
- No meaningful automated test surface was found.
- The repository is better for reading HUD/runtime ideas than for copying as a foundation.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `reference-only`
- Focus tags: `2d`, `libgdx`, `physics`, `ui-hud`, `save-load`, `asset-pipeline`
- Follow-up needed:
  - if the lab revisits this repository, do it only as a scoped pass around Scene2D/HUD composition, the JSON economy layer, or a future Android module if one ever lands
  - do not reopen it as a broad Android baseline; the checked-in tree is desktop-first and unfinished
