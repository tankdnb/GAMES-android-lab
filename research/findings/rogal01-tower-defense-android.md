# Research Note

## Repository Snapshot

- Repository: `rogal01/tower-defense-android`
- Source URL: [https://github.com/rogal01/tower-defense-android](https://github.com/rogal01/tower-defense-android)
- Owner: `rogal01`
- Batch ID: [`BATCH-2026-06-04-AA`](../batches/BATCH-2026-06-04-AA.md)
- Type: `android-game`
- License: `MIT`
- Selection date: `2026-06-04`
- Last pushed at selection: `2026-06-03`
- Stars at selection: `0`
- Default branch at selection: `master`
- Investigated commit: `1f03efb7f778368ed590f6d18628454b14c25a3d`
- Research status: `accepted`
- Build mode: `static-review + gradle-help + app-assemble-dry-run-failed-missing-android-sdk`
- Catalog card: [catalog/projects/rogal01-tower-defense-android.md](../../catalog/projects/rogal01-tower-defense-android.md)

## Why This Repository Was Selected

- `tower-defense-android` was the last remaining candidate in the compact explicit-license shortlist.
- The main question for this batch was whether the repository is only a low-signal portfolio shell or whether it still contains enough reusable Android gameplay and product-architecture ideas for the main catalog.
- The answer is `accepted`: the codebase is rough and overstates its iOS readiness, but it still provides a strong Android-first tower-defense reference with a large shared simulation core, randomized map-path generation, dense progression systems, procedural Canvas rendering, and a notable procedural SFX pipeline.

## Technical Profile

- Main language(s): Kotlin, Swift
- Engine / framework: Android SDK + Kotlin Multiplatform-style shared gameplay core + custom `SurfaceView` / Canvas runtime + partially scaffolded SwiftUI / SpriteKit frontend
- Rendering stack: Android `SurfaceView` render thread with Canvas and procedural `Path`-based entity drawing; iOS-side SpriteKit wrapper is present but not fully integrated into the shared build
- Android target: direct Android app module with `minSdk 26`, `targetSdk 35`, and `compileSdk 35`
- Build system: Gradle `9.3.1` wrapper + AGP `9.1.0` + Kotlin Android `2.2.10` + Kotlin Multiplatform `2.1.0`
- Repository layout summary:
  - `shared/` - gameplay simulation, progression, enemy or tower data, map generation, and platform-agnostic persistence interfaces
  - `app/` - Android frontend, `SurfaceView` game loop, Canvas rendering, menus, audio, and product-shell activities
  - `ios/` - manual iOS setup guide plus SwiftUI and SpriteKit starter files outside the active shared-module build
  - `docs/` - portfolio-facing case-study material
- Source footprint:
  - total files counted in repository: `66`
  - Kotlin, Gradle Kotlin DSL, and Swift files counted in repository: `40`
  - `shared/src/commonMain/kotlin/com/example/myapp/game/GameEngine.kt` alone spans `3148` lines
  - `app/src/main/java/com/example/myapp/game/GameView.kt` spans `2192` lines
- Test surface:
  - no files matched the usual `src/test`, `src/androidTest`, or `*Test*` search patterns
  - no checked-in CI workflows were found
- Key modules reviewed:
  - `README.md`
  - `settings.gradle.kts`
  - `build.gradle.kts`
  - `gradle.properties`
  - `gradle/gradle-daemon-jvm.properties`
  - `shared/build.gradle.kts`
  - `app/build.gradle.kts`
  - `app/src/main/AndroidManifest.xml`
  - `shared/src/commonMain/kotlin/com/example/myapp/game/GameEngine.kt`
  - `shared/src/commonMain/kotlin/com/example/myapp/game/Tower.kt`
  - `shared/src/commonMain/kotlin/com/example/myapp/game/Enemy.kt`
  - `shared/src/commonMain/kotlin/com/example/myapp/game/Projectile.kt`
  - `shared/src/commonMain/kotlin/com/example/myapp/game/Player.kt`
  - `shared/src/commonMain/kotlin/com/example/myapp/game/CampaignLevel.kt`
  - `shared/src/commonMain/kotlin/com/example/myapp/game/SkillTree.kt`
  - `shared/src/commonMain/kotlin/com/example/myapp/game/GamePreferences.kt`
  - `shared/src/commonMain/kotlin/com/example/myapp/game/GameEngineHolder.kt`
  - `shared/src/androidMain/kotlin/com/example/myapp/game/AndroidGamePreferences.kt`
  - `ios/shared/src/iosMain/kotlin/com/example/myapp/game/IosGamePreferences.kt`
  - `app/src/main/java/com/example/myapp/game/GameView.kt`
  - `app/src/main/java/com/example/myapp/game/EntityRenderer.kt`
  - `app/src/main/java/com/example/myapp/MainActivity.kt`
  - `app/src/main/java/com/example/myapp/MainMenuActivity.kt`
  - `app/src/main/java/com/example/myapp/SettingsActivity.kt`
  - `app/src/main/java/com/example/myapp/SoundManager.kt`
  - `app/src/main/java/com/example/myapp/AndroidGameAudio.kt`
  - `ios/IOS-SETUP-GUIDE.md`
  - `ios/app/GameViewModel.swift`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeded. The wrapper reports Gradle `9.3.1`, launcher JVM `1.8.0_321`, and a daemon JVM pinned to Java `21` through `gradle/gradle-daemon-jvm.properties`.
- `cmd /c gradlew.bat help --no-daemon` also succeeded in the lab, which makes this one of the few recent Android repositories in the lab that can at least configure under the current machine by auto-provisioning the daemon JDK.
- `cmd /c gradlew.bat :app:assembleDebug --dry-run --no-daemon` failed because no Android SDK is configured locally:
  - `SDK location not found`
- The active Android build surface is current but noisy:
  - AGP `9.1.0`
  - Java target `17`
  - several deprecated Android Gradle flags in `gradle.properties`
- The repository's multiplatform story is not build-ready from the checked-in default state:
  - `shared/build.gradle.kts` only enables `androidTarget`
  - the iOS target block is commented out
  - `ios/IOS-SETUP-GUIDE.md` explicitly says common code still needs Java-specific APIs replaced before iOS compilation works

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `3`
- Implementation depth: `3`
- Code clarity: `2`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - `tower-defense-android` is a strong Android-first reference for a no-engine tower-defense product shell with a large shareable gameplay core.
  - The most reusable value comes from the way it keeps simulation rules in `shared/`, uses randomized path templates and placement validation inside the runtime, renders all entities procedurally on Canvas, and synthesizes its own SFX at startup.
  - It is held back by monolithic file size, no test coverage, incomplete iOS integration, and portfolio-oriented rough edges, but it still clears the bar for the main catalog.

## Interesting Findings

### Engine Architecture And Core Loop

- `shared/src/commonMain/kotlin/com/example/myapp/game/GameEngine.kt` is the center of gravity for the whole game. One shared runtime owns difficulty modes, campaign flow, towers, enemies, traps, projectiles, achievements, skill tree, bounties, daily challenge, randomizer, endless buffs, save state, and run history instead of scattering those systems across activities.
- `app/src/main/java/com/example/myapp/game/GameView.kt` hosts that shared runtime inside a native Android `SurfaceView` thread and exposes only a small callback seam back to the activity layer for gold, wave, diamonds, game-over, tower selection, campaign victory, and milestone-buff dialogs.
- `shared/src/commonMain/kotlin/com/example/myapp/game/GamePreferences.kt`, `shared/src/androidMain/kotlin/com/example/myapp/game/AndroidGamePreferences.kt`, and `ios/shared/src/iosMain/kotlin/com/example/myapp/game/IosGamePreferences.kt` show a clean platform-storage abstraction that lets the same game core talk to `SharedPreferences` on Android and `NSUserDefaults` on iOS.
- `shared/src/commonMain/kotlin/com/example/myapp/game/GameEngine.kt` keeps several mode layers in one runtime rather than separate mode-specific engines:
  - `applyCampaign(...)`
  - `setupDailyChallenge()`
  - `setupRandomizer()`
  - `pickEndlessBuff(...)`

### Rendering And Graphics

- `app/src/main/java/com/example/myapp/game/GameView.kt` shows a fully custom Android render shell without a third-party engine: one render loop updates the shared runtime, caches terrain decorations and path geometry, and draws the world, HUD, particle effects, previews, and overlays directly on Canvas.
- The same `GameView.kt` contains a few practical rendering-performance ideas worth reusing in other custom-view Android games:
  - pre-allocated `Paint` instances
  - cached `Path` lists for map geometry
  - generated terrain decorations rebuilt only on surface changes
  - adaptive frame pacing through a simple 30 FPS / 60 FPS battery-saver switch
- `app/src/main/java/com/example/myapp/game/EntityRenderer.kt` is a notable code-drawn art reference. Towers, enemies, bosses, player, and the base are rendered procedurally with `Canvas`, `Paint`, and `Path` instead of external sprite assets, which is useful for prototypes or highly parameterized enemy or tower rosters.

### Gameplay Systems

- `shared/src/commonMain/kotlin/com/example/myapp/game/CampaignLevel.kt` and `CampaignData` define a large campaign surface in code: 40 authored levels, per-level allowed towers and powers, map choice, economy multipliers, special rules, hints, and derived 2-star or 3-star thresholds based on an estimated base-score model.
- `shared/src/commonMain/kotlin/com/example/myapp/game/GameEngine.kt` uses randomized waypoint templates per map in `generatePaths(...)`. Instead of one static path, each map family jitters authored route shapes to create run-to-run variation while keeping placement and rendering logic simple.
- `shared/src/commonMain/kotlin/com/example/myapp/game/GameEngine.kt` enforces building rules through geometric checks in `placeTower(...)`, `placeBlockade(...)`, and `placeTrap(...)`. Towers are kept away from the path, while traps and blockades must be close to it, which is a nice reusable pattern for tower-defense placement validation.
- `shared/src/commonMain/kotlin/com/example/myapp/game/Tower.kt` and `Enemy.kt` keep combat mostly data-driven:
  - target priorities cycle through `CLOSE`, `FIRST`, `LAST`, and `STRONG`
  - tower ability names and cooldowns live on `TowerType`
  - resistances and weaknesses are centralized in `EnemyResistances`
  - boss types package minion type, stats, and special ability together
- `shared/src/commonMain/kotlin/com/example/myapp/game/GameEngine.kt` layers long-run product systems directly into gameplay instead of treating them as menu-only extras:
  - tower mastery
  - endless bounty board
  - daily challenge modifier rotation
  - randomizer mode stat scrambling
  - run-history logging

### Input And Controls

- `app/src/main/java/com/example/myapp/game/GameView.kt` handles several touch modes in one place: tower placement, trap placement, blockade placement, long-press tower inspection, drag-to-move hero control, and tap-to-collect supply drops.
- `shared/src/commonMain/kotlin/com/example/myapp/game/Player.kt` keeps movement clamped to the playable region and uses `GameEngineHolder` to query world bounds, which is a pragmatic if tightly coupled way to keep input logic shared across frontends.
- `app/src/main/java/com/example/myapp/MainActivity.kt` maps Android UI controls into domain actions very directly. Tower buttons, powers, upgrades, speed toggles, pause, auto-wave, sell confirmation, and tower abilities all dispatch into the shared runtime instead of duplicating gameplay logic in the activity.

### UI, HUD, And Menus

- `app/src/main/java/com/example/myapp/MainMenuActivity.kt` is a good Android product-shell reference for small or medium game projects. It holds campaign, endless, boss rush, randomizer, survival, arena, ironman, and loadout entry flows plus daily reward, rate prompt, stats, achievements, run history, settings, and localization toggles in one native menu layer.
- `app/src/main/java/com/example/myapp/MainActivity.kt` shows a dense but readable in-run HUD shell around the custom `GameView`: campaign-specific button hiding, endless milestone dialogs, upgrade-cost labels, and safe quit handling stay in the activity while the render surface stays focused on runtime state.
- `app/src/main/java/com/example/myapp/SettingsActivity.kt` adds a very reusable small-product pattern: export the whole save bucket to JSON and allow importing it back through Android document pickers instead of building a heavier backend.

### Physics And Collision

- `shared/src/commonMain/kotlin/com/example/myapp/game/Projectile.kt` uses a deliberately simple deterministic projectile model: direct target-point travel with kill-on-arrival, which is often enough for casual tower-defense combat without a full physics engine.
- `shared/src/commonMain/kotlin/com/example/myapp/game/Tower.kt` and `Enemy.kt` show the same bias toward timer and distance logic over rigid-body simulation. Range checks, attack cooldowns, hit attribution, slows, burns, shields, and elite modifiers are all handled as simple scalar state, which transfers cleanly to Android games that do not need Box2D-level complexity.

### Tooling, Android Integration, Or Other Notable Areas

- `app/src/main/java/com/example/myapp/SoundManager.kt` is one of the strongest subsystem takeaways in this repository. It synthesizes short PCM clips for every SFX type, writes them as cached WAV files, and loads them into `SoundPool`, which is a useful reference when a project wants stylized or procedural effects without shipping a large asset pack.
- `app/src/main/java/com/example/myapp/AndroidGameAudio.kt` keeps the shared game core platform-agnostic by reducing audio to a tiny adapter interface.
- `ios/IOS-SETUP-GUIDE.md` and `ios/app/GameViewModel.swift` are useful mostly as architecture intent rather than production-ready code:
  - iOS targets are manual-enable only
  - `commonMain` still needs Java API cleanup
  - several Swift-side gameplay methods are placeholders
  - audio is still `SilentAudio`

## Reusable Takeaways

- A native Android game can keep almost all gameplay and progression logic in a shared Kotlin runtime while leaving rendering and product chrome in thin platform shells.
- Randomized but authored waypoint templates are a strong middle ground between fully static tower-defense maps and expensive runtime pathfinding.
- Code-drawn enemies and towers can keep a game visually expressive without forcing an art pipeline for every new prototype or gameplay idea.
- Procedural SFX generation into cached WAVs is a practical lightweight audio pipeline for Android games that want a distinct sonic identity without maintaining a large effects library.
- JSON export or import of the whole local save bucket is a useful low-cost feature for advanced players or internal QA on offline-first Android games.

## Evidence Summary

- `shared/src/commonMain/kotlin/com/example/myapp/game/GameEngine.kt` - central runtime, mode orchestration, map generation, placement rules, progression, saves, and run history
- `shared/src/commonMain/kotlin/com/example/myapp/game/CampaignLevel.kt` - campaign authoring model and star-threshold logic
- `shared/src/commonMain/kotlin/com/example/myapp/game/Tower.kt`, `Enemy.kt`, and `Projectile.kt` - data-driven combat primitives
- `app/src/main/java/com/example/myapp/game/GameView.kt` - Android render loop, terrain caching, touch modes, and HUD callbacks
- `app/src/main/java/com/example/myapp/game/EntityRenderer.kt` - full procedural Canvas art layer
- `app/src/main/java/com/example/myapp/MainActivity.kt` and `MainMenuActivity.kt` - native Android product shell and mode setup
- `app/src/main/java/com/example/myapp/SettingsActivity.kt` - settings plus save export/import
- `app/src/main/java/com/example/myapp/SoundManager.kt` - procedural PCM-to-WAV SFX pipeline
- `shared/build.gradle.kts`, `ios/IOS-SETUP-GUIDE.md`, and `ios/app/GameViewModel.swift` - current limits of the multiplatform path

## Risks Or Limits

- The multiplatform claim is only partially realized. iOS targets are commented out in the active shared build, the guide calls out unresolved Java-only APIs in `commonMain`, Swift-side gameplay methods are still stubs, and audio is not implemented on iOS.
- The core runtime is extremely monolithic: `GameEngine.kt` is over `3000` lines and `GameView.kt` is over `2000` lines, which makes reuse possible but extraction costlier.
- The visible automated test surface is effectively absent.
- `loadGame()` only restores a shallow snapshot of counters and player stats; it does not rebuild full tower, enemy, projectile, or in-wave state, so the continue flow is more of a soft resume than a real save-state system.
- Build hygiene is mixed:
  - `gradle.properties` carries several deprecated Android flags
  - Android tasks still need a local SDK
  - `app/src/main/java/com/example/myapp/game/GameEngine.kt` is checked in as an empty `0`-byte file
- The README and docs are openly portfolio-facing, with sections like `Why This Matters To Clients`, so the repository is less neutral and development-focused than stronger engineering baselines in the lab.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `android-game`
- Focus tags: `2d`, `android`, `multiplatform`, `ui-hud`, `audio`, `save-load`, `procedural-generation`
- Follow-up needed:
  - if the lab revisits this repository, rerun Android tasks in an SDK-ready environment, and only revisit the iOS side as a narrow investigation into the shared-core boundary, the SpriteKit adapter plan, or the procedural audio plus persistence seams rather than reopening the whole codebase broadly
