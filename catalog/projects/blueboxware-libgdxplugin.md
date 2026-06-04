# Project Entry

## Basic Info

- Project name: `LibGDXPlugin`
- Source repository: [https://github.com/BlueBoxWare/LibGDXPlugin](https://github.com/BlueBoxWare/LibGDXPlugin)
- Author / organization: `Blue Box Ware`
- License: `Apache-2.0`
- Research note: [research/findings/blueboxware-libgdxplugin.md](../../research/findings/blueboxware-libgdxplugin.md)
- Investigated commit: `8174244ab8d4943811bfe73336b6fe60f4a9a11f`
- Last verified: `2026-06-04`
- Activity / maintenance status: active plugin project with a fresh `1.29` release and latest inspected commit `Version 1.29` from `2026-05-29`, focused on gdxAI behavior-tree support, IntelliJ compatibility, and K2/EDT stability.

## Short Description

Kotlin-heavy IntelliJ / Android Studio plugin for libGDX projects, adding inspections, asset-aware navigation, custom asset-file editors, previews, and Android/libGDX-specific correctness checks.

## Technical Profile

- Primary category: `tooling-pipeline`
- Focus tags: `android`, `libgdx`, `editor-tools`, `asset-pipeline`, `ui-hud`, `testing`
- Engine / framework: IntelliJ Platform plugin specialized for libGDX workflows
- Rendering approach: IDE-native preview surfaces, GrammarKit-backed parsers/PSI, and semantic editors for Skin, atlas, bitmap-font, JSON, and behavior-tree files
- Main language(s): Kotlin, Java
- Android target: indirect but strong; the plugin is aimed directly at IntelliJ and Android Studio users building libGDX games, and includes Android-manifest inspections for libGDX-specific pitfalls
- Build system: Gradle Kotlin DSL with JetBrains IntelliJ Platform and GrammarKit plugins

## Why It Matters

- This repository is a strong reminder that game-production leverage is not only in engine code. IDE tooling that understands assets, manifests, and libGDX conventions can remove a lot of recurring mistakes and search friction from Android game teams.
- It is especially valuable for the lab because it combines several durable ideas in one place: typed asset references, project-local file-type overrides, semantic UI-asset editors, Android/libGDX inspections, and a real regression suite for a niche game-development plugin.

## Reusable Ideas

- Gameplay ideas:
  - none directly; the repository is tooling-first rather than gameplay-first
- Architecture patterns:
  - split domain plugin features into references, file-type support, inspections, UI helpers, settings, and actions
  - treat custom asset formats as PSI-backed languages rather than as plain text
  - persist project-local file-type overrides when extension-based detection is not enough
- Graphics / rendering techniques:
  - render sharp nearest-neighbor previews for atlas regions and tinted drawables inside IDE documentation popups
- Input / UI approaches:
  - semantic completion for scene2d Skin files based on real class fields, atlas regions, fonts, enums, and existing resource definitions
  - context-aware screen scaffolding only when the project and target directory are appropriate
- Performance or optimization ideas:
  - domain lint for expensive libGDX patterns such as flushes inside loops
  - repeated recent maintenance around EDT-safety and K2 compatibility

## Notable Implementations

- `plugin.xml` registers a wide but coherent IntelliJ extension surface across Java/Kotlin references, custom file types, inspections, debugger renderers, documentation previews, and actions.
- `AssetReferenceProvider.kt`, `KotlinReferenceContributor.kt`, `FileReference.kt`, and `AnnotationUtils.kt` turn `@GDXAssets` and `Skin` / `TextureAtlas` string calls into typed PSI references with completion, navigation, and rename support.
- `SkinCompletionContributor.kt` provides one of the stronger domain-specific completion systems in the lab, including atlas regions, booleans, enums, fonts, parent styles, and tinted drawables.
- `OpenGLESDirectiveInspection.kt` and the related XML inspections encode real Android/libGDX manifest correctness checks.
- `TreeCompletionContributor.kt` and `TreeUnknownClassInspection.kt` show newer support for gdxAI behavior-tree authoring with semantic completion and validation.
- `TestInspections.kt` and `TestAssetUtils.kt` give the plugin a real fixture-driven regression surface instead of only smoke tests.

## Android Relevance

- Native Android use:
  - indirect; this repository does not ship an Android runtime or game
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - most useful when we need reference patterns for Android Studio and IntelliJ support around libGDX assets, manifests, and editor ergonomics rather than for runtime/gameplay architecture

## Risks / Limitations

- IDE-specific value; not a runtime or engine baseline
- Android value is through tooling and lint, not through shipped Android gameplay code
- The checked-in wrapper surface lacks `gradlew.bat`, so Windows-side local build ergonomics are rougher than usual
- Meaningful local build verification still needs `JDK 17+`, and the checked-in toolchain now targets `21`

## Notes

`LibGDXPlugin` deserves to stay in the main catalog because a public library of Android game ideas is weaker if it ignores tooling. This repository is a strong reference for how Kotlin game projects can get better semantic editing, asset navigation, Android correctness checks, and plugin-level regression coverage around a specific framework ecosystem.
