# Project Entry

## Basic Info

- Project name: `Forty-Five`
- Source repository: [https://github.com/blueUserRed/forty-five](https://github.com/blueUserRed/forty-five)
- Author / organization: `blueUserRed`
- License: `GPL-3.0`
- Research note: [research/findings/blueuserred-forty-five.md](../../research/findings/blueuserred-forty-five.md)
- Investigated commit: `9ab0d85eb94876d5a554208460cf91e3fedb5868`
- Last verified: `2026-05-11`
- Activity / maintenance status: fresh at selection and still useful; the repository was last pushed on `2026-05-06`, has moderate niche popularity, and still exposes high-value gameplay/design docs, but some technical docs are explicitly outdated and the full build setup remains manual.

## Short Description

Wild-west deckbuilding roguelite written in Kotlin and libGDX, with a five-slot revolver combat model, trigger-heavy bullet/card effects, ONJ-driven screens and content, and seeded progression-map generation.

## Technical Profile

- Primary category: `gameplay-systems`
- Focus tags: `2d`, `libgdx`, `ui-hud`, `shader`, `save-load`, `procedural-generation`, `asset-pipeline`
- Engine / framework: custom libGDX runtime with Scene2D, Yoga/FlexBox layout, and ONJ-backed UI/content definitions
- Rendering approach: libGDX Scene2D plus a custom post-processing pipeline, shader wrappers, and stylable custom widgets
- Main language(s): Kotlin
- Android target: indirect only; the inspected product is desktop-first, but the libGDX/Kotlin architecture transfers well to Android game development
- Build system: multi-module Gradle Groovy project with `core`, `desktop`, and `onj` modules plus manual texture-packing/build steps

## Why It Matters

- `Forty-Five` is one of the stronger gameplay-systems references in the lab for Kotlin/libGDX projects that need more than a simple sample game.
- Its main value is the combination of explicit combat sequencing, a rich trigger/predicate card-effect model, declarative screen/content definitions, manual resource lifetime discipline, and procedural node-map progression.

## Reusable Ideas

- Gameplay ideas:
  - five-slot revolver-based deckbuilder combat, weighted encounter assignment by biome/progress, and seeded event/node-map progression
- Architecture patterns:
  - `Timeline` DSL for sequencing gameplay and UI work, prototype/runtime split for cards, and explicit encounter setup vs turn-resolution ownership
- Graphics / rendering techniques:
  - ping-pong framebuffer post-processing, reusable shader wrapper/preprocessor flow, and animated radial-slot combat UI
- Input / UI approaches:
  - ONJ-defined screens with templates, styles, named actors, drag-and-drop wiring, and screen-state-driven UI behavior
- Performance or optimization ideas:
  - borrow/get/giveBack asset lifetimes with trimming and leak reporting instead of loose global asset access

## Notable Implementations

- `Timeline.kt` provides a compact action/delay/conditional sequencing DSL used pervasively by combat and UI.
- `GameController.kt` and `GameDirector.kt` keep encounter ownership explicit instead of scattering turn flow across actors.
- `RenderPipeline.kt` and `BetterShader.kt` show post-processing and shader management that stay manageable inside a 2D libGDX project.
- `Revolver.kt` turns a non-grid combat metaphor into a reusable radial layout plus animation component.
- `SaveState.kt` and `MapManager.kt` show schema-checked saves, invalid-save fallback, and progression-map routing.
- `SeededMapGenerator.kt` combines seeded line generation with weighted/fixed events and area placement.
- `ScreenBuilder.kt` and the ONJ files demonstrate a content/UI pipeline that reaches well beyond static layout loading.

## Android Relevance

- Native Android use:
  - no; the inspected repository only exposes a desktop runtime target
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - especially useful as an Android reference for libGDX/Kotlin combat systems, data-driven UI/content, save/progression flow, and asset-lifetime discipline, but direct input/runtime/packaging work would need to be adapted for mobile

## Risks / Limitations

- GPL-3.0 licensing limits direct code reuse.
- The repository is desktop-only, so Android transfer is architectural rather than product-level.
- Full build reproduction is manual and non-self-contained because the external `Onj` repository must be cloned into `onj/`.
- Additional manual asset preparation is required before the game can be run or packaged.
- No automated tests were found.
- `technical_design.md` is valuable but explicitly outdated.

## Notes

Treat `Forty-Five` as a gameplay-systems and content-pipeline reference rather than as a turnkey Android sample. Its strongest reusable value is the sequencing/resource/content architecture around the combat loop, not the checked-in build reproducibility.
