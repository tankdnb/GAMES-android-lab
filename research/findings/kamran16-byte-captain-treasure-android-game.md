# Findings: `KAMRAN16-byte/Captain-Treasure-Android-Game`

## Repository Snapshot

- Repository: `KAMRAN16-byte/Captain-Treasure-Android-Game`
- Source URL: `https://github.com/KAMRAN16-byte/Captain-Treasure-Android-Game`
- Owner: `KAMRAN16-byte`
- Batch ID: `BATCH-2026-07-10-B`
- Type: `android-game`
- License: `MIT`
- Selection date: `2026-07-10`
- Last pushed at selection: `2026-06-04`
- Stars at selection: `0`
- Investigated commit: `ac9d241721eca7f1aff3503272556ed67e3420de`
- Research status: `reference-only`
- Build mode: `static-review + gradle-version + gradle-help-failed-java8-needs-java11`
- Catalog card: [card](../../catalog/projects/kamran16-byte-captain-treasure-android-game.md)

## Why This Repository Was Selected

- It was the strongest remaining queued candidate after `Koishi-Satori/KStg`: a fresh MIT-licensed direct Android Jetpack Compose micro-game.
- It was selected before `amirisback/piano-tiles-clone` because it is much fresher and directly Android/Kotlin/Compose, even though its public signal is lower.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: Android SDK + Jetpack Compose + Material 3
- Rendering stack: Compose layout tree with Material buttons, text state, and icon controls
- Android target: direct Android app module
- Build system: Gradle Kotlin DSL, Gradle wrapper `8.2`, Android Gradle Plugin `8.2.0-rc01`, Kotlin Android plugin `1.9.0`
- Repository layout summary: root README/LICENSE plus nested `CaptainTreasure/` Android project, single `:app` module, one meaningful game file in `MainActivity.kt`, template unit/instrumentation tests.
- Key files reviewed: `README.md`, `LICENSE`, `CaptainTreasure/settings.gradle.kts`, root and app Gradle scripts, `AndroidManifest.xml`, `MainActivity.kt`, template tests, wrapper properties.

## Build And Runtime Notes

- The repository was inspected statically first.
- `cmd /c gradlew.bat --version` succeeded locally and reported Gradle `8.2` running on Java `1.8.0_321`.
- `cmd /c gradlew.bat help --no-daemon` failed during Android Gradle Plugin resolution because AGP `8.2.0-rc01` requires Java `11` compatible variants, while the lab machine exposes Java `8`.
- Runtime launch was not attempted because the static surface is very small and local Gradle configuration is blocked by the lab JVM floor.

## Usefulness Assessment

- Reuse potential: `1`
- Android transfer: `3`
- Implementation depth: `1`
- Code clarity: `1`
- Novelty: `1`
- Overall verdict: `reference-only`
- Why: the repository is directly Android-relevant and easy to read, but it is a one-screen Compose prototype with all gameplay state and logic concentrated in `MainActivity.kt`, no reusable domain layer, no meaningful tests, and very limited technical depth.

## Interesting Findings

### Gameplay Systems

- `MainActivity.kt` implements a tiny risk/reward loop around treasure collection and ship health.
- Each direction button calls the same event function with a direction label.
- A random boolean decides between treasure gain and storm damage.
- The repair button converts one treasure into `+10` HP when the game is still active.
- Reset returns treasure, direction, event, HP, and game-over text to their initial values.

This loop is useful as a very small teaching baseline for state mutation in a casual game, not as copy-ready architecture.

### Input And Controls

- The control model is deliberately simple: four Material buttons for cardinal movement plus `Repair` and `Reset`.
- The direction controls share one mutation function, which keeps the visible branching small.
- The UI disables gameplay only indirectly through `hp > 0` and empty game-over text checks; there is no typed game-state model.

### UI, HUD, And Menus

- `Captain_Treasure()` displays all game state as text rows: treasure count, HP, direction, event, and game-over label.
- The layout uses centered `Column` and `Row` groups with fixed spacers.
- Material icons make the buttons readable, but the UI is not adaptive beyond Compose's basic layout behavior.

### Android Platform Integration

- `MainActivity` is a standard single-activity Compose host.
- The manifest is minimal and launcher-only.
- `minSdk = 24`, `targetSdk = 35`, and `compileSdk = 35`.
- No persistence, lifecycle game pause/resume handling, audio, haptics, sensors, navigation, or platform-specific game services were found.

### Build, Release, And Testing

- The checked-in wrapper is complete enough for `gradlew.bat --version`.
- The app build uses AGP `8.2.0-rc01`, Kotlin `1.9.0`, Java/Kotlin target `1.8`, Compose compiler extension `1.5.1`, and Compose BOM `2023.08.00`.
- Only default template tests were found:
  - `ExampleUnitTest.kt` asserts `2 + 2 == 4`
  - `ExampleInstrumentedTest.kt` checks the package name
- No CI workflow, release metadata, game-rule tests, or UI tests were found.

## Reusable Takeaways

- Tiny Compose game prototypes can start with a few `remember { mutableStateOf(...) }` fields and button-driven events when the goal is teaching or sketching, but this pattern should be refactored before a game grows.
- Even very small games benefit from naming the domain function clearly; the generic `function(...)` name here is a useful cautionary counterexample.
- Random event games should isolate randomness behind a testable seam before promotion into a reusable architecture.
- Button-grid controls are enough for turn-like micro-games, but direct mutation from the UI should be kept out of larger catalog-quality projects.

## Evidence Summary

- `CaptainTreasure/app/src/main/java/com/kam/captaintreasure/MainActivity.kt` - entire gameplay loop, Compose UI, state mutation, direction controls, repair/reset actions
- `CaptainTreasure/app/build.gradle.kts` - Android/Compose dependency and SDK configuration
- `CaptainTreasure/settings.gradle.kts` - single-module project structure
- `CaptainTreasure/app/src/main/AndroidManifest.xml` - single launcher activity
- `CaptainTreasure/app/src/test/java/com/kam/captaintreasure/ExampleUnitTest.kt` - template unit test
- `CaptainTreasure/app/src/androidTest/java/com/kam/captaintreasure/ExampleInstrumentedTest.kt` - template instrumentation test
- `CaptainTreasure/gradle/wrapper/gradle-wrapper.properties` - Gradle `8.2` wrapper

## Risks Or Limits

- All gameplay logic is in one file and partly in one poorly named top-level function.
- Game state is represented as unrelated mutable Compose states rather than a cohesive model.
- Randomness is not injectable, so the core loop is not testable as written.
- HP repair can increase from `90` to `100`, but the guard is loose enough that future value changes could over-heal unless capped.
- The README contains mojibake in the inspected Windows console output.
- The repository has zero public ecosystem signal at selection time.
- Local Gradle configuration requires a newer JVM than the lab's Java `8` runtime.

## Catalog Decision

- Keep in main catalog: `yes, as reference-only`
- Primary category: `reference-only`
- Focus tags: `2d`, `android`, `input`, `ui-hud`
- Follow-up needed: only if future work needs a minimal Compose micro-game teaching sample or a cautionary one-screen prototype comparison. Do not reopen broadly for architecture research.
