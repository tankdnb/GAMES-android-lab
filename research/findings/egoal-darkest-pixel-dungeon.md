# Research Note

## Repository Snapshot

- Repository: `egoal/darkest-pixel-dungeon`
- Source URL: [https://github.com/egoal/darkest-pixel-dungeon](https://github.com/egoal/darkest-pixel-dungeon)
- Owner: `egoal`
- Batch ID: [`BATCH-2026-05-10-K`](../batches/BATCH-2026-05-10-K.md)
- Type: `android-game`
- License: `GPL-3.0`
- Selection date: `2026-05-10`
- Last pushed at selection: `2025-04-30`
- Stars at selection: `115`
- Investigated commit: `604d16a2b3e39c39e7f26c3a09e7b377584fc6c8`
- Research status: `accepted`
- Build mode: `static-review + gradle-discovery-attempt-timeout`
- Catalog card: [catalog/projects/egoal-darkest-pixel-dungeon.md](../../catalog/projects/egoal-darkest-pixel-dungeon.md)

## Why This Repository Was Selected

- It offered the best balance among the current unresearched shortlist between direct Android relevance, still-recent maintenance, and dense gameplay-system yield.
- Compared with `minigdx/minigdx`, `zeganstyl/thelema-engine`, `mimoguz/tripeaks-gdx`, `kotcity/kotcity`, and backlog fallback `sreich/ore-infinium`, it was the strongest next fit for the lab's goal of extracting reusable ideas from Kotlin Android game code rather than only from framework code.
- It is especially useful because it combines custom Android input/runtime plumbing, procedural dungeon generation, AI state flow, save-slot architecture, and layered in-game UI inside one complete Kotlin roguelike codebase.

## Technical Profile

- Main language(s): Kotlin, Java
- Engine / framework: custom Android game stack built around the `Noosa` runtime in `SPD-classes`
- Rendering stack: custom OpenGL scene graph, tilemap batching, sprite layers, Android touch input bridge, and game-specific scene/window composition
- Android target: direct Android application module in `core/` plus shared runtime/library module in `SPD-classes/`
- Build system: multi-module Gradle Groovy DSL project with root build, `core` app module, and `SPD-classes` library module
- Repository layout summary: gameplay logic, dungeon generation, scenes, windows, and save flow live in `core/`, while reusable rendering/input/persistence primitives such as `Game`, `Touchscreen`, `Tilemap`, and `Bundle` live in `SPD-classes/`
- Source footprint:
  - total files reviewed in repository: `1402`
  - Kotlin/Java files reviewed across the repository: `1026`
- Key modules reviewed:
  - `build.gradle`
  - `settings.gradle`
  - `gradle.properties`
  - `core/build.gradle`
  - `SPD-classes/build.gradle`
  - `gradle/wrapper/gradle-wrapper.properties`
  - `SPD-classes/src/main/java/com/watabou/noosa/Game.java`
  - `SPD-classes/src/main/java/com/watabou/input/Touchscreen.java`
  - `SPD-classes/src/main/java/com/watabou/utils/Bundle.java`
  - `SPD-classes/src/main/java/com/watabou/noosa/Tilemap.java`
  - `core/src/main/java/com/egoal/darkestpixeldungeon/actors/Actor.kt`
  - `core/src/main/java/com/egoal/darkestpixeldungeon/actors/mobs/Mob.kt`
  - `core/src/main/java/com/egoal/darkestpixeldungeon/Database.kt`
  - `core/src/main/java/com/egoal/darkestpixeldungeon/levels/RegularLevel.kt`
  - `core/src/main/java/com/egoal/darkestpixeldungeon/levels/diggers/LevelDigger.kt`
  - `core/src/main/java/com/egoal/darkestpixeldungeon/Dungeon.kt`
  - `core/src/main/java/com/egoal/darkestpixeldungeon/GamesInProgress.kt`
  - `core/src/main/java/com/egoal/darkestpixeldungeon/scenes/InterlevelScene.kt`
  - `core/src/main/java/com/egoal/darkestpixeldungeon/scenes/GameScene.java`
  - `core/src/main/java/com/egoal/darkestpixeldungeon/actors/hero/Hero.kt`
  - `core/src/main/java/com/egoal/darkestpixeldungeon/actors/buffs/Pressure.kt`
  - `core/src/main/java/com/egoal/darkestpixeldungeon/actors/hero/perks/HeroPerk.kt`
  - `core/src/main/java/com/egoal/darkestpixeldungeon/QuickSlot.java`
  - `core/src/main/java/com/egoal/darkestpixeldungeon/items/Generator.kt`
  - `core/src/main/java/com/egoal/darkestpixeldungeon/windows/WndHero.kt`
  - `core/src/main/java/com/egoal/darkestpixeldungeon/windows/WndJournal.kt`

## Build And Runtime Notes

- The repository was investigated primarily through static code review plus lightweight Gradle discovery.
- `build.gradle` confirms Kotlin `1.5.20` and Android Gradle Plugin `4.0.1`.
- `core/build.gradle` confirms the direct Android application target with `compileSdkVersion 27`, `minSdkVersion 15`, `targetSdkVersion 23`, and `kotlinx-serialization-json 1.3.3`.
- `SPD-classes/build.gradle` confirms a shared Android library module with `compileSdkVersion 31`, `minSdkVersion 15`, and `targetSdkVersion 23`.
- `gradle/wrapper/gradle-wrapper.properties` pins Gradle `6.6.1` through a mirrored distribution URL.
- `cmd /c gradlew.bat help --no-daemon` timed out in the current lab environment even after clearing a transient wrapper lock, so no confident build-pass or build-fail verdict was recorded beyond "Gradle discovery did not complete."
- No runtime launch was attempted.
- Known setup limitations:
  - the toolchain surface is legacy and mixed across modules, so modern Android assumptions should not be projected onto this repository
  - no real `src/test` or `src/androidTest` tree was found; only `PotionTestPaper.kt` and `TestLevel.kt` exist inside main sources

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `3`
- Implementation depth: `3`
- Code clarity: `2`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - this is one of the clearest direct Android gameplay references in the catalog for old-school roguelike architecture written largely in Kotlin
  - the codebase is valuable not because it is modern, but because it shows many durable gameplay patterns in one place: runtime shell, touch handling, generation, AI, persistence, and UI layering
  - GPL licensing, older Android targets, and limited automated verification reduce copy-paste reuse, but the design ideas are still high-yield

## Interesting Findings

### Android Runtime Shell, Input, And Scene Loop

- `SPD-classes/src/main/java/com/watabou/noosa/Game.java` is a strong reference for a custom Android/GL shell. It buffers raw `MotionEvent` objects, translates them through the internal touch pipeline, and coordinates the render/update loop at the runtime boundary instead of scattering input handling across gameplay scenes.
- `SPD-classes/src/main/java/com/watabou/input/Touchscreen.java` centralizes multi-touch dispatch. That separation keeps Android pointer mechanics out of scene logic and makes gesture/touch handling reusable across windows and game scenes.
- `core/src/main/java/com/egoal/darkestpixeldungeon/scenes/InterlevelScene.kt` handles threaded interlevel transitions such as descending, ascending, continuing, or restoring from backup, then switches scenes safely after background work completes. This is a durable pattern for heavy save/load transitions on mobile devices.
- `core/src/main/java/com/egoal/darkestpixeldungeon/scenes/GameScene.java` builds the runtime scene out of explicit terrain, water, custom tiles, cell selectors, logs, resume indicators, and UI layers. It exposes focused update hooks such as `updateMap`, `updateMap(cell)`, `discoverTile`, `selectItem`, and `selectCell` instead of forcing full scene rebuilds for every change.

### Turn Scheduling, AI State, And Progression

- `core/src/main/java/com/egoal/darkestpixeldungeon/actors/Actor.kt` is one of the highest-value files in the repository. It implements a time-based actor scheduler with `actPriority`, a global actor set, `fixTime()`, and `process()` flow that can wait for sprite movement to finish before the next logical action runs.
- `core/src/main/java/com/egoal/darkestpixeldungeon/actors/mobs/Mob.kt` keeps enemy behavior as a serializable state machine with modes such as `SLEEPING`, `WANDERING`, `HUNTING`, `FLEEING`, `PASSIVE`, and `FOLLOW_HERO`. That makes AI state part of persistence rather than only transient combat logic.
- `core/src/main/java/com/egoal/darkestpixeldungeon/Database.kt` moves mob balance, resistances, loot, and abilities into structured data lines rather than burying everything inside one class hierarchy. This lowers the cost of tuning large content sets in a long-lived game.
- `core/src/main/java/com/egoal/darkestpixeldungeon/actors/buffs/Pressure.kt` is a notable mechanics reference: it models psychological pressure levels such as `CONFIDENT`, `NORMAL`, `NERVOUS`, and `COLLAPSE`, then feeds those states back into damage, accuracy, evasion, charging, and even death conditions.
- `core/src/main/java/com/egoal/darkestpixeldungeon/actors/hero/perks/HeroPerk.kt` provides a compact perk container with upgrade, downgrade, remove, and bundle-persistence support rather than scattering perk logic across many hero methods.
- `core/src/main/java/com/egoal/darkestpixeldungeon/actors/hero/Hero.kt` coordinates cross-floor hero continuity such as inventory, search/rest flow, revive handling, followers, and other state that must survive level transitions cleanly.

### Procedural Dungeon Generation And Content Economy

- `core/src/main/java/com/egoal/darkestpixeldungeon/levels/RegularLevel.kt` assembles dungeon floors through weighted diggers, secret and special rooms, water, grass, traps, merchants, and item placement. It is a strong reference for procedural floor assembly that keeps several independent content systems in balance.
- `core/src/main/java/com/egoal/darkestpixeldungeon/levels/diggers/LevelDigger.kt` shows a useful generation pattern where the floor emerges from a sequence of digger strategies plus loop-closure rules around overlapping walls and doors. This makes layout logic easier to extend than one monolithic generator.
- `core/src/main/java/com/egoal/darkestpixeldungeon/items/Generator.kt` balances item generation through category chance decay, unique artifact handling, and stash/recover state. It is a good example of keeping loot progression fair without a large external live-ops system.

### Persistence, Save Slots, And Recoverability

- `SPD-classes/src/main/java/com/watabou/utils/Bundle.java` is a major reusable subsystem. It provides custom persistence built around JSON with optional GZIP compression and class-name or alias-based serialization of `Bundlable` objects.
- `core/src/main/java/com/egoal/darkestpixeldungeon/Dungeon.kt` separates whole-game and current-level persistence. Methods such as `saveAll`, `saveGame`, `saveLevel`, `loadGame`, `loadLevel`, `loadBackupGame`, and `loadBackupLevel` keep failure recovery and partial reloads manageable.
- `core/src/main/java/com/egoal/darkestpixeldungeon/GamesInProgress.kt` implements six save slots, separate `slotX.dat` and `slotX-depthY.dat` files, and backup files. It also generates preview information for save slots without booting the whole live game.
- `core/src/main/java/com/egoal/darkestpixeldungeon/QuickSlot.java` keeps quickslot state even for consumed stackable items through zero-quantity placeholders. That is a subtle but useful UX pattern when players expect hotbar continuity after using the last charge or copy of an item.

### Rendering And In-Game UI

- `SPD-classes/src/main/java/com/watabou/noosa/Tilemap.java` optimizes tile rendering with buffered positions, partial `updateVertices` calls, visible-range checks, and a cached VBO path. It is a practical reference for old but still relevant 2D tile rendering performance work.
- `core/src/main/java/com/egoal/darkestpixeldungeon/windows/WndHero.kt` provides a tabbed hero sheet split into `stats`, `buffs`, `perks`, and `details`, which is a concise example of dense RPG UI on a mobile-sized surface.
- `core/src/main/java/com/egoal/darkestpixeldungeon/windows/WndJournal.kt` shows a journal/catalog flow with depth-aware records and drill-down windows instead of flat one-screen lists.

## Reusable Takeaways

- A direct Android game can keep platform input manageable by buffering raw `MotionEvent` data once, translating it into a reusable touch dispatcher, and only then feeding gameplay scenes.
- Long-lived roguelikes benefit from splitting persistence into global game state, per-level state, slot previews, and backup files instead of forcing one opaque save blob.
- Procedural level generation becomes more maintainable when diggers, room injectors, hazards, merchants, and item/monster economy are layered as cooperating systems rather than one generator method.
- Data-backed AI and content tables can coexist with hand-authored classes, giving a project room to scale content without abandoning readable source-level behavior code.

## Evidence Summary

- `build.gradle`, `core/build.gradle`, `SPD-classes/build.gradle`, and `gradle/wrapper/gradle-wrapper.properties` - confirmed the Android build surface, Kotlin/AGP versions, and Gradle wrapper baseline
- `Game.java` and `Touchscreen.java` - confirmed the custom Android runtime shell and buffered touch pipeline
- `Tilemap.java` - confirmed partial tile-buffer updates and visible-range tile rendering optimizations
- `Actor.kt` and `Mob.kt` - confirmed the time-based scheduler plus serializable mob-state flow
- `Database.kt`, `RegularLevel.kt`, `LevelDigger.kt`, and `Generator.kt` - confirmed the data-backed content model, procedural floor assembly, and loot balancing strategy
- `Bundle.java`, `Dungeon.kt`, `GamesInProgress.kt`, and `QuickSlot.java` - confirmed the JSON/GZIP persistence model, split save architecture, backups, slot previews, and placeholder-friendly hotbar behavior
- `InterlevelScene.kt` and `GameScene.java` - confirmed threaded transitions, layered scene composition, and incremental map/UI update hooks
- `Hero.kt`, `Pressure.kt`, `HeroPerk.kt`, `WndHero.kt`, and `WndJournal.kt` - confirmed cross-floor hero continuity, pressure mechanics, perk persistence, and dense mobile UI patterns

## Risks Or Limits

- The repository is GPL-3.0 licensed, so direct code reuse needs stronger legal caution than several other catalog entries.
- The Android target surface is old: the inspected revision still targets `minSdkVersion 15` and `targetSdkVersion 23`, with mixed `compileSdkVersion 27` and `31` between modules.
- The automated test surface is effectively absent, so most confidence comes from static reading rather than repository tests.
- Some files show legacy encoding or mojibake symptoms, and the codebase mixes older Java/Kotlin styles, which lowers clarity compared with more modern samples.
- Gradle discovery did not complete in the current lab environment, so this repository should not be treated as a verified build reference.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `android-game`
- Focus tags: `2d`, `android`, `roguelike`, `procedural-generation`, `save-load`, `input`, `ui-hud`, `performance`
- Follow-up needed:
  - if the lab revisits this repository later, focus on one subsystem such as the actor scheduler, procedural dungeon pipeline, or split save-slot architecture
  - if future build validation matters, rerun Gradle discovery in a cleaner environment instead of treating the current timeout as repository breakage
