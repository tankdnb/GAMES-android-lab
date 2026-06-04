# Research Note

## Repository Snapshot

- Repository: `Juanoff/roulette-android-app`
- Source URL: [https://github.com/Juanoff/roulette-android-app](https://github.com/Juanoff/roulette-android-app)
- Owner: `Juanoff`
- Batch ID: [`BATCH-2026-06-04-AH`](../batches/BATCH-2026-06-04-AH.md)
- Type: `android-game`
- License: `MIT`
- Selection date: `2026-06-04`
- Last pushed at selection: `2026-05-28`
- Stars at selection: `0`
- Default branch at selection: `main`
- Investigated commit: `0a4a45d6260fb5140ecda5f363b97410714c85cd`
- Research status: `accepted`
- Build mode: `static-review + gradle-help + app-unit-test-dry-run-failed-missing-android-sdk`
- Catalog card: [catalog/projects/juanoff-roulette-android-app.md](../../catalog/projects/juanoff-roulette-android-app.md)

## Why This Repository Was Selected

- `roulette-android-app` was the next direct Android candidate in the carry-over exact-license shortlist after the stronger engine-focused `PlanetEngine` batch was closed.
- The main question for this batch was whether the repository is only a visually polished Compose demo or whether it still contains reusable Android game-product patterns worth keeping in the main catalog.
- The answer is `accepted`: the codebase is small and narrow, but it still provides a clean reference for custom Compose Canvas rendering, resumable finite animation state, configuration-driven gameplay setup, and a compact MVVM game shell.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: Android SDK + Jetpack Compose + Material 3 + AndroidX Lifecycle/ViewModel + Hilt + Coroutines/StateFlow
- Rendering stack: Compose layout primitives plus a custom Canvas wheel built from `drawArc` and `nativeCanvas` label drawing
- Android target: direct single-module Android app with `minSdk 26`, `targetSdk 37`, and `compileSdk 37`
- Build system: Gradle `9.5.1` wrapper + AGP `9.2.1` + Kotlin `2.3.21` + Java toolchain `21`
- Repository layout summary:
  - `app/` - full Android application, including screen shell, wheel rendering, view-model state, and domain use cases
  - `gradle/` - wrapper, version catalog, and daemon JDK provisioning metadata
  - `screenshots/` - product screenshots referenced from the README
- Source footprint:
  - total files counted in repository: `63`
  - Kotlin/Kotlin DSL files counted in repository: `30`
- Test surface:
  - files matching `*Test.kt`: `2`
  - both visible tests are template-level examples rather than real gameplay or UI verification
- Key modules reviewed:
  - `README.md`
  - `settings.gradle.kts`
  - `build.gradle.kts`
  - `gradle/libs.versions.toml`
  - `gradle/gradle-daemon-jvm.properties`
  - `app/build.gradle.kts`
  - `app/src/main/AndroidManifest.xml`
  - `app/src/main/java/com/juanoff/rouletteapp/MainActivity.kt`
  - `app/src/main/java/com/juanoff/rouletteapp/RouletteApplication.kt`
  - `app/src/main/java/com/juanoff/rouletteapp/ui/viewmodel/RouletteViewModel.kt`
  - `app/src/main/java/com/juanoff/rouletteapp/ui/roulette/RouletteRoute.kt`
  - `app/src/main/java/com/juanoff/rouletteapp/ui/roulette/RouletteScreen.kt`
  - `app/src/main/java/com/juanoff/rouletteapp/ui/components/RouletteWheel.kt`
  - `app/src/main/java/com/juanoff/rouletteapp/ui/components/RouletteSectorView.kt`
  - `app/src/main/java/com/juanoff/rouletteapp/ui/components/SectorCountSelector.kt`
  - `app/src/main/java/com/juanoff/rouletteapp/ui/components/SpinButton.kt`
  - `app/src/main/java/com/juanoff/rouletteapp/core/animation/RouletteAnimationStateCalculator.kt`
  - `app/src/main/java/com/juanoff/rouletteapp/core/util/AnimationDurationCalculator.kt`
  - `app/src/main/java/com/juanoff/rouletteapp/core/constants/RouletteDefaults.kt`
  - `app/src/main/java/com/juanoff/rouletteapp/domain/usecase/GenerateRouletteSectorsUseCase.kt`
  - `app/src/main/java/com/juanoff/rouletteapp/domain/usecase/GenerateSpinAngleUseCase.kt`
  - `app/src/main/java/com/juanoff/rouletteapp/domain/usecase/CalculateRouletteResultUseCase.kt`
  - `app/src/main/java/com/juanoff/rouletteapp/ui/preview/RoulettePreview.kt`
  - `app/src/test/java/com/juanoff/rouletteapp/ExampleUnitTest.kt`
  - `app/src/androidTest/java/com/juanoff/rouletteapp/ExampleInstrumentedTest.kt`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeded and reported Gradle `9.5.1`.
- The same discovery output shows an important build detail: the wrapper still launches from the lab's Java `8` runtime, but the checked-in `gradle/gradle-daemon-jvm.properties` automatically provisions a compatible Java `21` daemon for actual build work.
- `cmd /c gradlew.bat help --no-daemon` succeeded locally.
- `cmd /c gradlew.bat :app:testDebugUnitTest --dry-run --no-daemon` failed because the current lab environment has no configured Android SDK:
  - `SDK location not found`
- No checked-in GitHub Actions workflows or other visible CI automation were found.
- The visible build surface looks modern and coherent for a small Android game:
  - AGP `9.2.1`
  - Kotlin `2.3.21`
  - Compose BOM `2026.05.01`
  - Java toolchain `21`

## Usefulness Assessment

- Reuse potential: `2`
- Android transfer: `3`
- Implementation depth: `2`
- Code clarity: `3`
- Novelty: `1`
- Overall verdict: `accepted`
- Why:
  - `roulette-android-app` is not deep enough to be a major architecture reference, but it is still a useful direct Android Compose sample.
  - Its strongest value is the combination of custom Canvas wheel rendering, a configuration-driven roulette model, and a surprisingly clean pattern for resuming an in-flight finite animation after recomposition or configuration changes.
  - The low domain depth, absent real test surface, and missing public CI keep it below the stronger Android references already in the lab.

## Interesting Findings

### Engine Architecture And Core Loop

- `app/src/main/java/com/juanoff/rouletteapp/ui/viewmodel/RouletteViewModel.kt` keeps the app's entire game session in one clear `StateFlow` state holder: sector configuration, generated sectors, current rotation, spin lock, selected sector, and the active spin envelope all live in one immutable `RouletteState`.
- The same `RouletteViewModel.kt` uses explicit UI events (`SpinClicked`, `SpinAnimationFinished`, `SectorCountChanged`) rather than mutating state directly from composables, which gives the small app a reusable unidirectional flow shape.
- `app/src/main/java/com/juanoff/rouletteapp/ui/roulette/RouletteRoute.kt` is deliberately thin: it binds state and events, while `RouletteScreen.kt` stays presentation-only and the domain calculations remain in separate use-case classes.

### Rendering And Graphics

- `app/src/main/java/com/juanoff/rouletteapp/ui/components/RouletteWheel.kt` is the main rendering takeaway: it builds a roulette wheel entirely through Compose Canvas arcs and then rotates the full wheel as one surface rather than animating per-sector state.
- `app/src/main/java/com/juanoff/rouletteapp/ui/components/RouletteSectorView.kt` rotates the native Android canvas around the wheel center and draws labels at a fixed radial offset, which is a compact direct pattern for wheel or dial labels in Compose-backed custom rendering.
- `app/src/main/java/com/juanoff/rouletteapp/ui/roulette/RouletteScreen.kt` uses `BoxWithConstraints` plus a portrait/landscape split so the same wheel renderer can scale to different form factors without needing separate activities or fragments.

### Gameplay Systems

- `app/src/main/java/com/juanoff/rouletteapp/domain/usecase/GenerateSpinAngleUseCase.kt` deliberately separates random outcome generation from the UI layer by emitting only the total rotation delta.
- `app/src/main/java/com/juanoff/rouletteapp/core/util/AnimationDurationCalculator.kt` keeps animation duration tied to physical rotation distance rather than to a fixed constant, which makes the larger spins feel heavier without hardcoding several animation profiles.
- `app/src/main/java/com/juanoff/rouletteapp/domain/usecase/CalculateRouletteResultUseCase.kt` reduces the winner calculation to a small angle-normalization rule over `360f / sectorCount`, which is the core reusable rule for any sector-wheel or spinner product.
- `app/src/main/java/com/juanoff/rouletteapp/domain/usecase/GenerateRouletteSectorsUseCase.kt` turns sector count into a fully generated wheel model, including labels and a repeatable color palette, so the UI does not own presentation data construction.

### Input And Controls

- `app/src/main/java/com/juanoff/rouletteapp/ui/components/SectorCountSelector.kt` and `RouletteViewModel.kt` combine into a useful micro-pattern: user-configurable gameplay parameters stay editable only while the session is idle, and the view-model hard-blocks configuration changes during animation.
- `app/src/main/java/com/juanoff/rouletteapp/ui/components/SpinButton.kt` disables the primary action while the spin is active and swaps its label for inline progress feedback instead of trusting the user not to double-trigger the spin logic.

### UI, HUD, And Menus

- `app/src/main/java/com/juanoff/rouletteapp/ui/roulette/RouletteScreen.kt` shows a compact single-screen casual-game shell: selector, wheel, selected-result card, and CTA are split into readable sections that survive portrait and landscape changes.
- `app/src/main/java/com/juanoff/rouletteapp/ui/preview/RoulettePreview.kt` is a useful small-product habit: preview-specific state generation is kept outside the screen composable, so the layout can be inspected without binding to the live `ViewModel`.

### Android Platform Integration

- `app/src/main/java/com/juanoff/rouletteapp/MainActivity.kt` combines `enableEdgeToEdge()` with `WindowInsets.safeDrawing` handling in the composable layer, which is a practical modern Android shell pattern for simple full-screen games.
- `app/src/main/java/com/juanoff/rouletteapp/RouletteApplication.kt` and the Hilt setup show the smallest possible DI-enabled Android app shell, even though the dependency graph is still tiny.

### Build, Release, And Testing

- `app/build.gradle.kts`, `gradle/libs.versions.toml`, and `gradle/gradle-daemon-jvm.properties` show a notably current Android build surface for a zero-star hobby app:
  - AGP `9.2.1`
  - Kotlin `2.3.21`
  - `compileSdk 37`
  - Java toolchain `21`
  - Gradle daemon JDK auto-resolution
- The visible automated test surface is effectively template-only:
  - `app/src/test/java/com/juanoff/rouletteapp/ExampleUnitTest.kt`
  - `app/src/androidTest/java/com/juanoff/rouletteapp/ExampleInstrumentedTest.kt`
- The instrumentation test is also stale in a concrete way: it still expects `com.example.rouletteapp` even though the app id is `com.juanoff.rouletteapp`, so it would fail if actually run unchanged.

## Reusable Takeaways

- For finite game-like animations in Compose, store `start`, `target`, `startedAtMillis`, and `duration` in a `ViewModel` and recompute current position plus remaining time when the screen is recreated instead of restarting the animation blindly.
- Custom wheel or spinner UIs map well to Compose Canvas when sector generation, winner calculation, and spin-distance logic stay in separate domain or utility classes.
- Even very small Android game shells benefit from locking configuration changes while a timed action is in flight rather than trying to reconcile settings mutations mid-animation.
- For single-screen casual apps, a thin route composable plus a single `StateFlow`-backed screen can be enough; there is no need to introduce a heavier navigation graph prematurely.

## Evidence Summary

- `RouletteViewModel.kt`, `RouletteState.kt`, and `RouletteUiEvent.kt` - session-state ownership and unidirectional event flow
- `RouletteSpinState.kt` and `RouletteAnimationStateCalculator.kt` - resumable animation envelope and current-angle recovery
- `RouletteWheel.kt` and `RouletteSectorView.kt` - Canvas sector rendering and label drawing
- `GenerateSpinAngleUseCase.kt`, `AnimationDurationCalculator.kt`, and `CalculateRouletteResultUseCase.kt` - spin-distance generation, duration scaling, and sector winner math
- `RouletteScreen.kt`, `SectorCountSelector.kt`, and `SpinButton.kt` - portrait/landscape UI split, idle-only configuration changes, and compact casual-game shell behavior

## Risks Or Limits

- The repository is very small and genre-narrow, so its best value is in UI/runtime micro-patterns rather than deep gameplay architecture.
- No real gameplay, UI, or regression tests are present; the visible test surface is only templates.
- `ExampleInstrumentedTest.kt` is stale and appears to assert the wrong package name.
- No checked-in CI workflows or broader public maintenance signal were found.
- `app/src/main/java/com/juanoff/rouletteapp/ui/components/RouletteSectorView.kt` allocates a new `android.graphics.Paint` during every label draw, which is acceptable at this scale but not ideal as a performance baseline for heavier animated Canvas scenes.
- Hilt is configured even though the dependency graph is currently tiny, so the DI surface is more instructive as a product-shell pattern than as a necessity for this exact app size.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `android-game`
- Focus tags: `2d`, `android`, `input`, `ui-hud`
- Follow-up needed:
  - if the lab revisits this repository, rerun Android tasks in an SDK-ready environment, or isolate the resumable spin-animation pattern, the Canvas wheel renderer, or the single-screen MVVM shell instead of reopening the whole project broadly
