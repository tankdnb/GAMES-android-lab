# Project Entry

## Basic Info

- Project name: `PGSGP`
- Source repository: [https://github.com/StudioAdriatic/PGSGP](https://github.com/StudioAdriatic/PGSGP)
- Author / organization: `StudioAdriatic`
- License: `MIT`
- Research note: [research/findings/studioadriatic-pgsgp.md](../../research/findings/studioadriatic-pgsgp.md)
- Investigated commit: `c07701471b1b6080cc03a9e0474478bfc5544d5c`
- Last verified: `2026-06-04`
- Activity / maintenance status: active at selection; the repository was pushed on `2026-06-03`, and the latest inspected commit added automatic AndroidManifest injection for app ID and permissions in the v2 plugin flow.

## Short Description

Godot 4.x Android Play Games Services plugin with a Kotlin controller layer for sign-in, achievements, leaderboards, events, player stats, player info, and saved games, plus automated export-time manifest and dependency wiring.

## Technical Profile

- Primary category: `library-sdk`
- Focus tags: `android`, `save-load`, `asset-pipeline`, `testing`
- Engine / framework: Godot 4.x Android plugin around Google Play Games Services
- Rendering approach: no custom renderer; the repository keeps Android platform-service integration outside the Godot rendering/runtime core
- Main language(s): Kotlin, Python
- Android target: direct; the repository is specifically for Android Godot exports
- Build system: Gradle Android multi-module build with helper generation scripts and GitHub Actions release workflows

## Why It Matters

- `PGSGP` is a strong reference for Android game-service shipping glue rather than for gameplay or engine design.
- It is especially useful for future work that needs Play Games Services integration, manifest/resource injection, or Android plugin packaging around a shared engine runtime.

## Reusable Ideas

- Gameplay ideas:
  - cloud saves, achievements, leaderboards, events, player stats, and player profile wrappers exposed as a small game-facing API
- Architecture patterns:
  - one Godot plugin facade backed by dedicated feature controllers instead of a monolithic service bridge
- Graphics / rendering techniques:
  - keep platform-service integration entirely outside the renderer and communicate back through engine-friendly signals and serialized payloads
- Input / UI approaches:
  - script-facing signal callbacks and export-time configuration fields instead of requiring downstream Android UI code
- Performance or optimization ideas:
  - generate compatibility metadata from one source so multi-version plugin packaging does not drift across release targets

## Notable Implementations

- `PlayGameServicesGodot.kt` centralizes plugin registration, signals, and activity-result routing.
- Feature-specific controllers wrap Play Games Services clients with coroutine `await()` flows instead of callback-heavy inlined logic.
- `export_plugin.gd` injects Maven dependencies, permissions, and `APP_ID` manifest metadata automatically during Android export.
- `generate_gdap.py` synchronizes legacy `.gdap` packaging with the newer Godot plugin system v2 export plugin.
- The CI/release surface builds against multiple Godot versions and publishes different artifacts for legacy and modern plugin consumers.

## Android Relevance

- Native Android use:
  - direct
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - the code is most directly reusable for Godot Android plugins, but the controller split, service-wrapper style, and export-time manifest/dependency automation also transfer to other Android engine/plugin integrations

## Risks / Limitations

- The repository is tightly scoped to Godot plus Google Play Games Services rather than to broader Android game architecture.
- Several docs and examples are stale relative to the current `init(...)` and `initWithSavedGames(...)` signatures.
- The automated test surface is small compared with the breadth of the exposed feature API.
- Local lab build validation is still blocked by the Java `8` environment, while upstream expects newer Java and standardizes on JDK `17`.

## Notes

This is a useful library-sdk reference for shipping Android game-service integrations cleanly, especially when export packaging and plugin compatibility matter as much as the runtime API itself.
