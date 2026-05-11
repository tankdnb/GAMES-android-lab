# Research Note

## Repository Snapshot

- Repository: `blueUserRed/forty-five`
- Source URL: [https://github.com/blueUserRed/forty-five](https://github.com/blueUserRed/forty-five)
- Owner: `blueUserRed`
- Batch ID: [`BATCH-2026-05-11-M`](../batches/BATCH-2026-05-11-M.md)
- Type: `gameplay-systems`
- License: `GPL-3.0`
- Selection date: `2026-05-11`
- Last pushed at selection: `2026-05-06`
- Stars at selection: `63`
- Investigated commit: `9ab0d85eb94876d5a554208460cf91e3fedb5868`
- Research status: `accepted`
- Build mode: `static-review + gradle-help + external-onj-checkout-required`
- Catalog card: [catalog/projects/blueuserred-forty-five.md](../../catalog/projects/blueuserred-forty-five.md)

## Why This Repository Was Selected

- The refreshed shortlist still contained `yamin8000/Dooz`, but `forty-five` offered broader expected research yield: a larger gameplay-heavy Kotlin/libGDX codebase, explicit technical-design notes, and multiple reusable systems beyond a single compact Android sample.
- It also balanced freshness and signal well for the niche: recent activity, moderate stars, and a clearly non-trivial gameplay architecture built around deckbuilding, procedural map flow, and custom data/UI tooling.
- The main question for the batch was whether `forty-five` is only an interesting desktop card game or a genuinely strong reference for reusable Kotlin/libGDX combat, screen/content, persistence, and map-generation patterns that can inform Android game work.

## Technical Profile

- Main language(s): Kotlin, Groovy Gradle, ONJ configuration files
- Engine / framework: custom libGDX game runtime with Scene2D, Yoga/FlexBox layout, and an ONJ-backed UI/content DSL
- Rendering stack: libGDX Scene2D + custom post-processing pipeline + shader wrappers + custom styled widgets
- Android target: indirect; the inspected product is desktop-only, but the Kotlin/libGDX architecture transfers well to Android-oriented game development
- Build system: multi-module Gradle Groovy project with `core`, `desktop`, and `onj` modules plus custom texture-packing tasks
- Repository layout summary: `core` contains gameplay, rendering, UI, save, and map logic; `desktop` contains the launcher; `assets` contains config, screens, shaders, and art metadata; `onj` is a bridge module that expects an external checkout; root docs include setup and technical design notes
- Source footprint:
  - total files reviewed in repository: `236`
  - Kotlin/Java files reviewed across the repository: `105`
- Test surface:
  - test files found: `0`
  - meaningful gameplay-specific tests found: `0`
- Key modules reviewed:
  - `readme.md`
  - `technical_design.md`
  - `project_setup_and_build.md`
  - `build.gradle`
  - `settings.gradle`
  - `desktop/build.gradle`
  - `onj/build.gradle`
  - `gradle/wrapper/gradle-wrapper.properties`
  - `core/src/com/fourinachamber/fortyfive/FortyFive.kt`
  - `core/src/com/fourinachamber/fortyfive/utils/Timeline.kt`
  - `core/src/com/fourinachamber/fortyfive/game/GameController.kt`
  - `core/src/com/fourinachamber/fortyfive/game/GameDirector.kt`
  - `core/src/com/fourinachamber/fortyfive/game/SaveState.kt`
  - `core/src/com/fourinachamber/fortyfive/game/card/Card.kt`
  - `core/src/com/fourinachamber/fortyfive/game/card/Effect.kt`
  - `core/src/com/fourinachamber/fortyfive/game/card/PassiveEffect.kt`
  - `core/src/com/fourinachamber/fortyfive/game/enemy/Enemy.kt`
  - `core/src/com/fourinachamber/fortyfive/game/enemy/EnemyBrain.kt`
  - `core/src/com/fourinachamber/fortyfive/map/MapManager.kt`
  - `core/src/com/fourinachamber/fortyfive/map/detailMap/SeededMapGenerator.kt`
  - `core/src/com/fourinachamber/fortyfive/rendering/RenderPipeline.kt`
  - `core/src/com/fourinachamber/fortyfive/rendering/BetterShader.kt`
  - `core/src/com/fourinachamber/fortyfive/screen/ResourceManager.kt`
  - `core/src/com/fourinachamber/fortyfive/screen/general/ScreenBuilder.kt`
  - `core/src/com/fourinachamber/fortyfive/screen/gameComponents/Revolver.kt`
  - `assets/config/cards.onj`
  - `assets/config/encounter_definitions.onj`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeds and reports Gradle `7.5.1` running on Java `1.8.0_321`.
- `cmd /c gradlew.bat help --no-daemon` also succeeds in the lab environment, so the checked-in Gradle configuration can be loaded successfully even on the current Java `8` machine.
- Full build and runtime verification were intentionally not claimed because the repository is not self-contained:
  - `project_setup_and_build.md` explicitly tells contributors to clone [https://github.com/blueUserRed/Onj](https://github.com/blueUserRed/Onj) into the local `onj` directory
  - `settings.gradle` includes `onj`
  - `onj/build.gradle` points `sourceSets.main.java.srcDirs` at `Onj/src/main/kotlin`
  - the inspected clone contains `onj/build.gradle` and an empty `onj/Onj` directory placeholder rather than the actual external sources
- The setup/build docs also require manual asset preparation:
  - create `assets/textures/packed`
  - run the texture-packer Gradle task
  - copy `large_assets` from a current release into `assets/large_assets`
- `build.gradle` still depends on `jcenter()` and older libGDX-era packaging conventions, so even with the external `Onj` checkout present, the build should be treated as a manually prepared desktop project rather than a turnkey reproducible sample.
- No runtime launch was attempted.

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `2`
- Implementation depth: `3`
- Code clarity: `2`
- Novelty: `3`
- Overall verdict: `accepted`
- Why:
  - `forty-five` is one of the stronger gameplay-systems references in the lab for Kotlin/libGDX card combat, content-driven UI, save/progression handling, and map generation
  - the repository contains multiple durable patterns that transfer well even without direct Android support: a timeline DSL, prototype/runtime card model, drag-and-drop screen composition, explicit asset borrowing, config-driven encounters, and seeded road-map generation
  - it is not a turnkey build or direct mobile-runtime reference because the inspected product is desktop-only, GPL-licensed, manually assembled, and partially dependent on an external `Onj` checkout

## Interesting Findings

### Engine Architecture And Core Loop

- `core/src/com/fourinachamber/fortyfive/FortyFive.kt` acts as a compact game shell that stages startup in a deliberate order: ONJ namespaces, logging, user prefs, sound, encounter definitions, map config, savefiles, graphics config, resources, a background service thread, and card preparation. It also centralizes screen transitions and swaps render pipelines together with screen instances.
- `core/src/com/fourinachamber/fortyfive/utils/Timeline.kt` is one of the most reusable subsystems in the repository. It exposes a small DSL for sequencing gameplay and animation work with immediate actions, main-thread actions, delays, conditional includes, runtime action injection, and shared storage. This is a strong reference for orchestration-heavy Android/libGDX combat flows.
- `core/src/com/fourinachamber/fortyfive/game/GameController.kt` uses `Timeline` as the core sequencing primitive for the encounter loop instead of scattering gameplay timing across individual actors. Combat, parries, draws, damage, revolver rotation, popups, and status-effect aftermath are all composed as explicit timeline fragments.
- `core/src/com/fourinachamber/fortyfive/game/GameDirector.kt` separates encounter setup from turn resolution. It loads enemy prototypes, applies encounter modifiers, injects tutorial text, and chooses map encounters through biome/progress/weight filtering rather than hard-wiring them into the map layer.

### Rendering And Graphics

- `core/src/com/fourinachamber/fortyfive/rendering/RenderPipeline.kt` builds a custom 2D post-processing chain around ping-pong framebuffers. Orb trails are accumulated into one framebuffer pair, then blurred and composited back into the main output; separate late tasks inject fade-to-black and screen-shake shader passes. This is a good reference for effect stacking on top of Scene2D/libGDX without overloading every actor.
- `core/src/com/fourinachamber/fortyfive/rendering/BetterShader.kt` wraps shader programs with auto-bound uniforms such as time, cursor position, resolution, and pre-bound textures. It also loads shader code through a custom preprocessor. That keeps gameplay/UI code from manually rebinding the same low-level uniforms everywhere.
- `core/src/com/fourinachamber/fortyfive/screen/gameComponents/Revolver.kt` turns the game's five-slot combat metaphor into a reusable radial-layout component. Cards are owned by animated slots, can be pre-placed for transitions, rotate left/right with synchronized visual movement, and support shader overlays such as frost effects.

### Gameplay Systems

- `core/src/com/fourinachamber/fortyfive/game/card/Card.kt` and `core/src/com/fourinachamber/fortyfive/game/card/Effect.kt` split data prototypes from live runtime cards. Effects are trigger-driven, can target bullets through selectors or popups, can cache affected-card sets, and emit `Timeline` fragments instead of mutating state synchronously. This is a strong pattern for expandable card games and other trigger-heavy ability systems.
- `core/src/com/fourinachamber/fortyfive/game/card/PassiveEffect.kt` shows a second effect layer for stateful passive behaviors that react to controller predicates becoming active or inactive, not just one-off triggers.
- `core/src/com/fourinachamber/fortyfive/game/enemy/Enemy.kt` and `core/src/com/fourinachamber/fortyfive/game/enemy/EnemyBrain.kt` combine data-backed enemies with a mix of scripted and probabilistic AI. The brains can emit shown or hidden actions, coordinate around other enemies already choosing attacks, and switch into special phases such as burning or inferno behavior.
- `assets/config/cards.onj` and `assets/config/encounter_definitions.onj` keep a large amount of gameplay content declarative: card descriptions, triggers, costs, rarities, tutorial text, forced tutorial hands, biome filters, progress ranges, and encounter weights all live outside Kotlin classes.
- `core/src/com/fourinachamber/fortyfive/map/detailMap/SeededMapGenerator.kt` builds road maps through seeded line generation, intersection repair, border-area placement, weighted optional events, fixed dead-end events, distance-to-end tagging, and procedural decorations. It is a useful reference for lightweight node-map progression systems rather than tile-world generation only.

### Input And Controls

- `core/src/com/fourinachamber/fortyfive/screen/general/ScreenBuilder.kt` wires drag-and-drop groups, keyboard input maps, behaviors, templates, and named actors from ONJ screen files. This separates interaction binding from individual widgets and makes it easier to keep UI and gameplay wiring data-driven.
- The inspected runtime is desktop-first, but the drag-and-drop revolver flow is still relevant for Android adaptation because the placement logic is separated cleanly from combat resolution in `GameController.kt` and `Revolver.kt`.

### UI, HUD, And Menus

- `core/src/com/fourinachamber/fortyfive/screen/general/ScreenBuilder.kt` plus `technical_design.md` show a substantial Scene2D/Yoga-based UI layer on top of libGDX. Screens can define templates, styling rules, screen states, controllers, named actors, drag-and-drop behavior, and per-screen asset usage in ONJ instead of hard-coding every menu in Kotlin.
- The styling system described in `technical_design.md` is especially reusable: styled actors expose properties to a `StyleManager`, ONJ style objects can carry priorities and conditions, and screen state can gate layout/style changes without imperative widget-by-widget updates.

### Physics And Collision

- This repository is not a physics-focused reference. Its main value is in sequencing, UI composition, data-driven content, combat rules, save/progression flow, and procedural map structure rather than in physical simulation.

### Tooling, Android Integration, Or Other Notable Areas

- `core/src/com/fourinachamber/fortyfive/screen/ResourceManager.kt` is a high-value subsystem. Assets must be explicitly borrowed before access, are type-checked on retrieval, can be given back independently, and can be trimmed when prepared-but-unborrowed. Shutdown logging reports still-loaded resources as possible leaks. This is a strong discipline pattern for memory-sensitive libGDX or Android game code.
- `core/src/com/fourinachamber/fortyfive/game/SaveState.kt` keeps savefiles schema-checked and versioned, falls back to a default save when parsing or validation fails, tracks multiple deck layouts, and preserves run statistics and map position separately from permanent progression. The tutorial also uses explicit branching between per-run and permanent state.
- `core/src/com/fourinachamber/fortyfive/map/MapManager.kt` ties together ONJ schema validation, detail-map loading, regeneration fallback for invalid maps, static-map copying, and screen routing for encounters, shops, dialog, healing, and title/credits flow.
- `project_setup_and_build.md` and `technical_design.md` are both valuable even with caveats. The build/setup note documents the manual external-module and asset steps clearly, while the design note preserves a map of the repository's intended architecture even though parts are now outdated.

## Reusable Takeaways

- A small timeline DSL can dramatically simplify complex turn/combat/UI sequencing compared with directly chaining callbacks across actors and controllers.
- Deckbuilder or ability-driven games benefit from a clear split between data prototypes, runtime instances, trigger-driven effects, and passive predicate-based effects.
- Data-driven UI can go beyond simple layout files: this repository shows ONJ-driven screens, styles, templates, input maps, and controller bindings on top of a normal libGDX stack.
- Manual borrow/get/giveBack asset lifetimes are a useful pattern when Android memory pressure or libGDX asset leaks are a real concern.
- Lightweight node-map progression can stay both procedural and inspectable by combining seeded line generation with weighted/fixed event placement and explicit biome/progress encounter assignment.

## Evidence Summary

- `FortyFive.kt`, `Timeline.kt`, `GameController.kt`, `GameDirector.kt` - startup flow, screen transitions, encounter orchestration, and timeline-driven core loop
- `RenderPipeline.kt`, `BetterShader.kt`, `Revolver.kt` - post-processing, shader abstraction, and the central revolver combat UI metaphor
- `Card.kt`, `Effect.kt`, `PassiveEffect.kt`, `Enemy.kt`, `EnemyBrain.kt` - runtime card/effect model, passive abilities, enemy AI, and combat-state ownership
- `cards.onj`, `encounter_definitions.onj`, `technical_design.md` - data-driven content model and documented architecture concepts
- `SaveState.kt`, `MapManager.kt`, `SeededMapGenerator.kt` - persistence, map routing, seeded progression-map generation, and invalid-map recovery
- `ResourceManager.kt`, `ScreenBuilder.kt`, `project_setup_and_build.md`, `onj/build.gradle` - asset lifetime discipline, ONJ screen pipeline, and the external build/setup caveat

## Risks Or Limits

- The repository is GPL-3.0 licensed, which limits direct code reuse for some downstream projects even if the ideas remain valuable.
- The inspected product is desktop-only; Android relevance is architectural rather than runtime-native.
- Full build reproduction is manual and not self-contained because the `Onj` sources are expected to be cloned separately into the repository.
- The build/setup process also depends on manual asset preparation and desktop-oriented packaging steps.
- No automated test surface was found.
- `technical_design.md` is explicitly marked outdated, so it is useful as an architectural map but should not override current code state.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `gameplay-systems`
- Focus tags: `2d`, `libgdx`, `ui-hud`, `shader`, `save-load`, `procedural-generation`, `asset-pipeline`
- Follow-up needed:
  - if the lab revisits this repository later, focus on either the `Timeline` orchestration layer, the ONJ-driven screen/content pipeline, or the seeded map/encounter flow instead of reopening the entire project blindly
  - a build-focused follow-up should be done only in an environment prepared with the external `Onj` checkout, packed textures, and copied `large_assets`
