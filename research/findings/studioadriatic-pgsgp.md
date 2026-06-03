# Research Note

## Repository Snapshot

- Repository: `StudioAdriatic/PGSGP`
- Source URL: [https://github.com/StudioAdriatic/PGSGP](https://github.com/StudioAdriatic/PGSGP)
- Owner: `StudioAdriatic`
- Batch ID: [`BATCH-2026-06-04-D`](../batches/BATCH-2026-06-04-D.md)
- Type: `library-sdk`
- License: `MIT`
- Selection date: `2026-06-04`
- Last pushed at selection: `2026-06-03`
- Stars at selection: `50`
- Investigated commit: `c07701471b1b6080cc03a9e0474478bfc5544d5c`
- Research status: `accepted`
- Build mode: `static-review + gradle-help-failed-java8-needs-java11`
- Catalog card: [catalog/projects/studioadriatic-pgsgp.md](../../catalog/projects/studioadriatic-pgsgp.md)

## Why This Repository Was Selected

- It was the last remaining candidate in the explicit-license shortlist and still had direct Android game-production relevance despite not being a game or engine by itself.
- The repository looked useful as a Kotlin-side reference for shipping Google Play Games Services inside Android Godot projects, especially around sign-in, achievements, leaderboards, saved games, and export-time manifest wiring.
- The main question for this pass was whether `PGSGP` was too narrow for the lab. It turned out to be narrow but still worth keeping because its Android bridge, packaging automation, and service-surface design are directly reusable.

## Technical Profile

- Main language(s): Kotlin, Python
- Engine / framework: Godot 4.x Android plugin around Google Play Games Services
- Rendering stack: Godot engine runtime; this repository supplies the Android plugin and export bridge rather than a renderer
- Android target: direct; the repository exists specifically to ship Play Games Services inside Android Godot exports
- Build system: Gradle Android multi-module build with helper scripts and GitHub Actions release automation
- Repository layout summary: `app/` contains the Kotlin Android plugin, `godot-lib/` tracks Godot Android AAR templates, `demo/` shows the Godot-side integration path, and `docs/` plus scripts cover installation, packaging, and release flow
- Source footprint:
  - total files reviewed in repository: `81`
  - Kotlin/Java/Gradle files reviewed across the repository: `28`
- Test surface:
  - test files found: `3`
  - meaningful controller/helper/model tests found: `3`
- Key modules reviewed:
  - `AGENTS.md`
  - `README.md`
  - `build.gradle`
  - `settings.gradle`
  - `app/build.gradle`
  - `godot-lib/build.gradle`
  - `docs/installation.md`
  - `docs/getting-started.md`
  - `docs/configuration.md`
  - `docs/api-reference.md`
  - `docs/examples.md`
  - `docs/gdap-automation.md`
  - `docs/troubleshooting.md`
  - `Changelog.md`
  - `generate_gdap.py`
  - `GodotPlayGamesServices.gdap`
  - `demo/addons/GodotPlayGamesServices/export_plugin.gd`
  - `demo/Main.gd`
  - `app/src/main/java/com/studioadriatic/gpgs/PlayGameServicesGodot.kt`
  - `app/src/main/java/com/studioadriatic/gpgs/signin/SignInController.kt`
  - `app/src/main/java/com/studioadriatic/gpgs/utils/AuthenticationHelper.kt`
  - `app/src/main/java/com/studioadriatic/gpgs/savedgames/SavedGamesController.kt`
  - `app/src/main/java/com/studioadriatic/gpgs/achievements/AchievementsController.kt`
  - `app/src/main/java/com/studioadriatic/gpgs/leaderboards/LeaderboardsController.kt`
  - `app/src/main/java/com/studioadriatic/gpgs/events/EventsController.kt`
  - `app/src/main/java/com/studioadriatic/gpgs/stats/PlayerStatsController.kt`
  - `app/src/main/java/com/studioadriatic/gpgs/accountinfo/PlayerInfoController.kt`
  - `app/src/test/java/com/studioadriatic/gpgs/signin/SimpleSignInControllerTest.kt`
  - `app/src/test/java/com/studioadriatic/gpgs/utils/AuthenticationHelperTest.kt`
  - `app/src/test/java/com/studioadriatic/gpgs/model/ModelClassesTest.kt`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeds and reports Gradle `8.2` on the current lab machine.
- `cmd /c gradlew.bat help --no-daemon` fails because the lab machine still resolves the Android Gradle Plugin classpath as a Java `8` consumer while `com.android.tools.build:gradle:8.2.0` only exposes Java `11`-compatible variants.
- The inspected repository itself clearly expects a newer toolchain than the lab machine:
  - external `AGENTS.md` says to compile with JDK `17`
  - `app/build.gradle` pins `sourceCompatibility`, `targetCompatibility`, and Kotlin `jvmTarget` to `17`
  - CI workflows also use JDK `17`
- No runtime launch was attempted.

## Usefulness Assessment

- Reuse potential: `2`
- Android transfer: `3`
- Implementation depth: `2`
- Code clarity: `3`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - `PGSGP` is not broad enough to act as a primary game or engine reference, but it is a strong Android service-integration reference.
  - The repository cleanly separates Godot-facing plugin APIs from feature controllers and backs them with packaging automation that future Android game plugins can reuse.
  - Its best value is in the shipping glue: export-time dependency injection, manifest generation, Play Games Services client wrapping, and versioned Godot plugin compatibility.

## Interesting Findings

### Service Bridge Architecture

- `app/src/main/java/com/studioadriatic/gpgs/PlayGameServicesGodot.kt` is the central bridge class. It extends `GodotPlugin`, exposes Godot-callable methods with `@UsedByGodot`, emits Godot signals, and routes Android activity results back into the appropriate service flows.
- The repository keeps one controller per major Play Games area: sign-in, achievements, leaderboards, events, player stats, player info, and saved games. That split makes the Android service surface easier to test and evolve than a monolithic plugin class.
- The bridge deliberately converts richer Play Games client responses into simple JSON payloads and Godot signals instead of forcing GDScript callers to understand Android client objects directly.

### Saved Games And Data Surfaces

- `SavedGamesController.kt` is a useful reference for wrapping cloud-save flows behind a smaller feature API. It handles open, conflict policy, load, commit/update, delete, and snapshot-picker activity-result handoff inside one controller instead of leaking those steps through the whole plugin.
- `PlayerInfoController.kt` and `PlayerStatsController.kt` flatten platform models into serializable data classes, which is a good pattern whenever Android-side service models need to cross an engine or scripting boundary.
- `AuthenticationHelper.kt` centralizes the sign-in-state check and safely degrades to `false` on exceptions. That is small, but it keeps every controller from re-implementing the same availability/auth probe.

### Android Export, Packaging, And Compatibility

- `demo/addons/GodotPlayGamesServices/export_plugin.gd` is one of the strongest reusable ideas in the repository. The plugin injects Maven dependencies, required permissions, and the `com.google.android.gms.games.APP_ID` manifest metadata automatically during Android export instead of requiring manual Gradle or manifest edits in downstream Godot projects.
- `generate_gdap.py` keeps three packaging surfaces synchronized: the root `.gdap`, the demo `.gdap`, and the dependency list embedded inside `export_plugin.gd`. That is a solid pattern for avoiding drift when one plugin must support both legacy and newer host-plugin systems.
- `app/build.gradle` conditionally adds `src/compat/java` when the resolved Godot AAR version is below `4.2`, while `Changelog.md` and the release workflow document the shift to Godot plugin system v2 for `4.2+`. This is a strong compatibility-management pattern for long-lived Android engine plugins.
- `app/src/compat/java/org/godotengine/godot/plugin/UsedByGodot.kt` shows a tiny but practical compatibility shim: keep one local annotation stub so older Godot plugin surfaces can compile without forking the whole plugin codebase.

### Build, Release, And Test Discipline

- The CI surface is stronger than the small codebase suggests. The workflows build against a matrix of Godot versions, run lint/test/build steps, and package different release artifacts for pre-`4.2` and `4.2+` Godot consumers.
- The release flow is not just Android-library publishing. It also produces Godot-consumable plugin artifacts, including legacy `.gdap` support and newer addon zip packaging, from one repository.
- The checked-in test surface is small but non-zero. The repository at least validates the auth helper exception path, sign-in controller creation surface, and model serialization assumptions.

### Documentation Drift And API Risks

- The repository has meaningful documentation drift. `docs/README.md`, `docs/api-reference.md`, `docs/examples.md`, `docs/configuration.md`, and `docs/troubleshooting.md` still show old `init(true, false, false, "")` style examples, while the Kotlin code now exposes `init(requestEmail, requestProfile, requestToken)` and `initWithSavedGames(saveGameName, requestEmail, requestProfile, requestToken)`.
- `demo/Main.gd` also keeps an outdated commented example for `initWithSavedGames(...)` with the old parameter order and count.
- Several public API parameters appear legacy or currently unused in behavior: `requestEmail`, `requestProfile`, `requestToken`, and the internal `enableSaveGamesFunctionality` only flow through initialization signatures without much evidence of downstream effect in the reviewed Kotlin logic.
- `Changelog.md` claims the typo-named model file was renamed, but the repository still contains `app/src/main/java/com/studioadriatic/gpgs/model/Achivemements.kt`. That mismatch is minor, but it reinforces the documentation-maintenance drift.

## Reusable Takeaways

- When bridging Android platform services into an engine or scripting runtime, keep one small plugin facade and split feature work into dedicated controllers.
- Prefer export-time dependency and manifest injection over telling downstream game teams to hand-edit Android packaging files.
- If one plugin must support several host-plugin generations, generate the compatibility metadata from one source instead of maintaining separate copies by hand.
- Treat Android service wrappers as shipping glue, not as an afterthought. The packaging and release surface can be as important as the API surface itself.

## Evidence Summary

- `PlayGameServicesGodot.kt` - main Godot bridge, signal surface, and Android activity-result routing
- `SignInController.kt`, `AchievementsController.kt`, `LeaderboardsController.kt`, `EventsController.kt`, `PlayerStatsController.kt`, `PlayerInfoController.kt`, `SavedGamesController.kt` - controller-per-feature Play Games Services wrappers
- `AuthenticationHelper.kt` - centralized signed-in check and failure fallback
- `export_plugin.gd` - Android export dependency/permission/manifest injection for Godot plugin system v2
- `generate_gdap.py` and `GodotPlayGamesServices.gdap` - legacy plugin metadata generation and dependency synchronization
- `.github/workflows/*.yml` and `.github/versions.json` - Godot-version matrix build/release discipline
- `docs/*.md` and `demo/Main.gd` - current documentation drift around public initialization signatures

## Risks Or Limits

- The repository is narrow and strongly Godot-specific. Its value is highest for engine-plugin or Android service-wrapper work, not for general gameplay architecture.
- Documentation is partially stale, especially around initialization signatures and examples.
- The visible automated test surface is shallow for a plugin with several Android client wrappers.
- Local build confirmation in the lab is still blocked by the machine's Java `8` runtime, while the inspected repository expects newer Java and CI standardizes on JDK `17`.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `library-sdk`
- Focus tags: `android`, `save-load`, `asset-pipeline`, `testing`
- Follow-up needed:
  - if the lab revisits this repository, rerun Gradle discovery and selected tests in a JDK `17` environment
  - the best narrow revisit targets would be the export-plugin manifest/dependency injection path, the saved-games wrapper, or the documentation/API drift
