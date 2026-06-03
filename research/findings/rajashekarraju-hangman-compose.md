# Research Note

## Repository Snapshot

- Repository: `RajashekarRaju/hangman-compose`
- Source URL: [https://github.com/RajashekarRaju/hangman-compose](https://github.com/RajashekarRaju/hangman-compose)
- Owner: `RajashekarRaju`
- Batch ID: [`BATCH-2026-06-04-B`](../batches/BATCH-2026-06-04-B.md)
- Type: `android-game`
- License: `Apache-2.0`
- Selection date: `2026-06-04`
- Last pushed at selection: `2026-03-12`
- Stars at selection: `38`
- Investigated commit: `f8cc2e3fa714b48e3d63f108e128188918c69443`
- Research status: `accepted`
- Build mode: `static-review + gradle-help-failed-java8-needs-java17`
- Catalog card: [catalog/projects/rajashekarraju-hangman-compose.md](../../catalog/projects/rajashekarraju-hangman-compose.md)

## Why This Repository Was Selected

- From the current licensed short backlog, `RajashekarRaju/hangman-compose` had the strongest balance of direct Android relevance, recent maintenance, explicit Apache-2.0 licensing, and expected architecture yield.
- It looked more valuable than a typical Compose game sample because it is a real Kotlin Multiplatform game product with Android, desktop, web, and iOS targets, plus a shared gameplay core, persistence, settings, audio, CI/CD, and packaging.
- The main question for this pass was whether it was mostly a polished UI demo or a deeper reference for small-game product architecture. It turned out to be a stronger product-shell and gameplay-core reference than a typical single-screen sample.

## Technical Profile

- Main language(s): Kotlin, with minor HTML, Shell, and Swift support files
- Engine / framework: Kotlin Multiplatform + Compose Multiplatform + Android SDK + Room + Koin + coroutines
- Rendering stack: Compose-first shared UI and navigation shell with gameplay state projected into screen models instead of a separate GL runtime
- Android target: direct; the repository includes both a shared `composeApp` KMP shell and an Android `app` module
- Build system: multi-module Gradle Kotlin DSL KMP project
- Repository layout summary:
  - `game-core` contains the reusable gameplay engine and word catalog DSL
  - `feature/*` contains screen-level view models and UI logic
  - `core/data` owns Room, local storage, and platform audio/persistence actuals
  - `composeApp` owns shared app bootstrap, DI, navigation, and multiplatform entry points
  - `app` owns the Android-specific shell and Firebase/Crashlytics wiring
- Source footprint:
  - total files reviewed in repository: `415`
  - Kotlin/Java files reviewed across the repository: `253`
- Test surface:
  - test files found: `17`
  - meaningful gameplay, repository, and view-model tests found: `17`
- Key modules reviewed:
  - `README.md`
  - `settings.gradle.kts`
  - `build.gradle.kts`
  - `gradle/libs.versions.toml`
  - `.github/workflows/tests.yaml`
  - `.github/workflows/packages.yml`
  - `.github/workflows/pages-production.yml`
  - `composeApp/build.gradle.kts`
  - `app/build.gradle.kts`
  - `game-core/build.gradle.kts`
  - `core/data/build.gradle.kts`
  - `feature/game/build.gradle.kts`
  - `composeApp/src/commonMain/kotlin/com/developersbreach/hangman/composeapp/Modules.kt`
  - `composeApp/src/commonMain/kotlin/com/developersbreach/hangman/composeapp/AppInitializerViewModel.kt`
  - `composeApp/src/commonMain/kotlin/com/developersbreach/hangman/composeapp/HangmanRoot.kt`
  - `navigation/src/commonMain/kotlin/com/developersbreach/hangman/navigation/AppNavigation.kt`
  - `game-core/src/commonMain/kotlin/com/developersbreach/game/core/GameSessionEngine.kt`
  - `game-core/src/commonMain/kotlin/com/developersbreach/game/core/GameSessionState.kt`
  - `game-core/src/commonMain/kotlin/com/developersbreach/game/core/WordCatalogDsl.kt`
  - `game-core/src/commonMain/kotlin/com/developersbreach/game/core/WordBank.kt`
  - `game-core/src/commonMain/kotlin/com/developersbreach/game/core/WordSelection.kt`
  - `feature/game/src/commonMain/kotlin/com/developersbreach/hangman/ui/game/GameViewModel.kt`
  - `feature/mainmenu/src/commonMain/kotlin/com/developersbreach/hangman/ui/mainmenu/MainMenuViewModel.kt`
  - `feature/settings/src/commonMain/kotlin/com/developersbreach/hangman/ui/settings/SettingsViewModel.kt`
  - `feature/achievements/src/commonMain/kotlin/com/developersbreach/hangman/ui/achievements/AchievementsViewModel.kt`
  - `core/data/src/jvmSharedMain/kotlin/com/developersbreach/hangman/repository/GameRepository.kt`
  - `core/data/src/jvmSharedMain/kotlin/com/developersbreach/hangman/repository/RoomGameSettingsRepository.kt`
  - `core/data/src/jvmSharedMain/kotlin/com/developersbreach/hangman/repository/RoomAchievementsRepository.kt`
  - `core/data/src/androidMain/kotlin/com/developersbreach/hangman/repository/di/PlatformDataModule.android.kt`
  - `core/data/src/desktopMain/kotlin/com/developersbreach/hangman/repository/di/PlatformDataModule.desktop.kt`
  - `core/data/src/wasmJsMain/kotlin/com/developersbreach/hangman/repository/di/PlatformDataModule.wasmJs.kt`
  - `core/data/src/androidMain/kotlin/com/developersbreach/hangman/audio/AndroidBackgroundAudioController.kt`
  - `core/data/src/androidMain/kotlin/com/developersbreach/hangman/audio/AndroidGameSoundEffectPlayer.kt`
  - `game-core/src/commonTest/kotlin/com/developersbreach/game/core/GameSessionEngineTest.kt`
  - `game-core/src/commonTest/kotlin/com/developersbreach/game/core/WordCatalogDslTest.kt`
  - `feature/game/src/commonTest/kotlin/com/developersbreach/hangman/ui/game/GameViewModelTest.kt`
  - `core/data/src/desktopTest/kotlin/com/developersbreach/hangman/repository/RoomAchievementsRepositoryTest.kt`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeds and reports Gradle `9.2.1` on a Java `8` launcher.
- `cmd /c gradlew.bat help --no-daemon` fails immediately because Gradle now requires JVM `17+`, while the current lab machine still exposes Java `8`.
- The checked-in build surface confirms a modern actively maintained product:
  - `gradle/libs.versions.toml` pins Kotlin `2.3.10`, Compose Multiplatform `1.10.1`, AGP `9.0.1`, Room `2.8.4`, and Koin `4.1.1`
  - `app/build.gradle.kts` targets `compileSdk 36`, `targetSdk 36`, and `kotlin.jvmToolchain(21)`
  - `composeApp/build.gradle.kts` configures Android, desktop, iOS, and WASM packaging from one shared shell
  - CI workflows split JDK usage between test-oriented `17` jobs and packaging/deploy jobs on `21`
- The release surface is stronger than average for a small game product:
  - `tests.yaml` covers unit, desktop, and Android instrumentation tasks
  - `packages.yml` builds Android and desktop packages
  - `pages-production.yml` deploys the WASM build to GitHub Pages
- No runtime launch was attempted.
- One workflow caveat should be kept in mind:
  - the default branch is `development`, but some release-style workflows are still triggered from `master`, so branch expectations should be rechecked before treating the automation surface as fully aligned

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `3`
- Implementation depth: `3`
- Code clarity: `3`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - `hangman-compose` is a strong direct Android reference for a Compose-first small-game product that still keeps gameplay rules, persistence, platform seams, and UI shell structure readable
  - the repository offers several reusable patterns that often disappear in toy samples: a pure session engine, a validated content DSL, reactive app bootstrap, cross-platform persistence/audio seams, and a real release/test surface
  - it is more useful as a product-architecture reference than as a low-level rendering/runtime reference, which is exactly what makes it complementary to the lab's engine-heavy entries

## Interesting Findings

### Shared Product Shell And App Bootstrap

- `composeApp/src/commonMain/kotlin/com/developersbreach/hangman/composeapp/AppInitializerViewModel.kt` treats app bootstrap as first-class product state. It hydrates settings first, then continuously observes language, theme palette, theme mode, cursor style, and achievement-banner state through flows instead of leaving those concerns scattered across screens.
- `HangmanRoot.kt` is a good Compose-first shell pattern: initialize Koin once, wrap the app in theme/cursor/achievement-banner layers, and recreate the subtree on language changes with `key(appState.appLanguage)` rather than mutating localization assumptions in place.
- `navigation/.../AppNavigation.kt` shows a useful product-shell pattern for shared Compose games: menu, settings, gameplay, guide, history, and achievements stay in one route system, with a browser-navigation abstraction layered on top for the web target.

### Gameplay Core And Content Modeling

- `game-core/.../GameSessionEngine.kt` is the strongest reusable gameplay artifact in the repository. It keeps the word-game rules pure-ish and UI-free: attempts, points, hints, level progression, guessed letters, and current word state all live here rather than inside composables or screen state.
- `GameSessionState.kt` uses immutable snapshots and typed update envelopes, which keeps the `GameViewModel` free to orchestrate timers, overlays, and effects without becoming the only source of truth for game rules.
- `WordCatalogDsl.kt` is an unusually good content-modeling example for a small game:
  - categories are declared through a readable DSL
  - words are normalized and validated
  - duplicates and invalid characters are rejected early
  - required difficulty coverage is enforced by word-length buckets
- `WordSelection.kt` shows a small but reusable rule: tie difficulty to word-length ranges and keep graceful fallback behavior for sparse pools instead of assuming every content bucket is perfectly populated.

### Screen Orchestration And UI-State Ownership

- `feature/game/.../GameViewModel.kt` is a controller-style screen orchestrator around the pure `GameSessionEngine`. It owns timers, hint cooldowns, transition holds, dialogs, achievements, sounds, and history writes, while the actual hangman rules stay in `game-core`.
- `feature/mainmenu/.../MainMenuViewModel.kt` and `feature/settings/.../SettingsViewModel.kt` show a good small-product pattern where screen VMs aggregate repositories and platform services instead of reaching directly into storage or media code from the UI.
- `feature/achievements/.../AchievementsViewModel.kt` keeps detail selection, unread handling, and grouped presentation in one clear place, while persistence stays in the repository layer.

### Persistence, Settings, And Platform Data Seams

- `RoomGameSettingsRepository.kt` is a strong reference for small-game settings persistence:
  - one-row settings entity
  - immediate `StateFlow` mirrors for theme, language, and cursor style
  - defensive storage parsing
  - explicit setters for product-facing preferences such as difficulty, palette, cursor style, sound, and progress-visual mode
- `GameRepository.kt` shows a pragmatic approach where one repository can implement both session-write and history-read responsibilities without over-abstracting a small product.
- `RoomAchievementsRepository.kt` keeps achievement progress and aggregate stat counters behind a simple repository boundary, which makes feature VMs and gameplay code treat achievements as product state rather than as ad hoc flags.
- The platform data actuals are especially useful:
  - Android and desktop use Room-backed repositories
  - WASM falls back to localStorage with the same repository interfaces
  - the shared feature layer stays ignorant of those storage differences

### Audio And Platform-Specific UX Constraints

- `AndroidBackgroundAudioController.kt` and `AndroidGameSoundEffectPlayer.kt` keep Android media handling tiny and isolated instead of letting platform playback bleed into game logic.
- `PlatformDataModule.desktop.kt` is a nice example of desktop-specific adaptation: MP3 resources are decoded into `Clip` objects while still satisfying the same shared interfaces used by Android and WASM.
- `PlatformDataModule.wasmJs.kt` contains one of the more reusable web-specific patterns in the repository: background music defers actual playback until the first user interaction, which cleanly handles browser autoplay restrictions without contaminating the shared feature layer.

### Build, Release, And Testing

- The repository has a stronger test surface than most small game samples:
  - `GameSessionEngineTest.kt` covers rules, hints, scoring, level progression, and loss/win behavior
  - `WordCatalogDslTest.kt` covers DSL validation and difficulty coverage
  - `GameViewModelTest.kt` covers timers, cooldowns, overlays, win/loss transitions, sounds, and persisted achievement effects
  - repository tests verify Room-backed persistence behavior
- The CI/CD surface is worth keeping as a reference in its own right. The project is not only coded cleanly; it is packaged and shipped like a real product across Android, desktop, and web.

## Reusable Takeaways

- A small Compose-first Android game benefits from a pure gameplay session engine under a controller-style `ViewModel` instead of mixing all rules into the UI layer.
- Content-heavy casual games can benefit from a DSL plus validation rules, especially when difficulty depends on content shape rather than only on timers or score multipliers.
- Room/localStorage/platform-audio differences can stay completely behind repository and service interfaces while the shared feature layer remains mostly platform-agnostic.
- Product shell concerns such as language, theme, cursor, achievements, history, packaging, and release workflows are worth studying alongside gameplay rules, because they are what separate a referenceable product from a toy sample.

## Evidence Summary

- `AppInitializerViewModel.kt`, `HangmanRoot.kt`, `AppNavigation.kt`, and `Modules.kt` - shared app bootstrap, DI, route shell, and global product state
- `GameSessionEngine.kt`, `GameSessionState.kt`, `WordCatalogDsl.kt`, `WordBank.kt`, and `WordSelection.kt` - pure gameplay rules, content DSL, and difficulty/content selection logic
- `GameViewModel.kt`, `MainMenuViewModel.kt`, `SettingsViewModel.kt`, and `AchievementsViewModel.kt` - controller-style screen orchestration, product-state hydration, and UI ownership
- `GameRepository.kt`, `RoomGameSettingsRepository.kt`, and `RoomAchievementsRepository.kt` - session/history/settings/achievement persistence patterns
- `PlatformDataModule.android.kt`, `PlatformDataModule.desktop.kt`, and `PlatformDataModule.wasmJs.kt` - platform-specific storage/audio seams behind common interfaces
- `AndroidBackgroundAudioController.kt` and `AndroidGameSoundEffectPlayer.kt` - thin Android media integration
- `GameSessionEngineTest.kt`, `WordCatalogDslTest.kt`, `GameViewModelTest.kt`, and `RoomAchievementsRepositoryTest.kt` - meaningful gameplay, VM, and persistence verification
- `.github/workflows/tests.yaml`, `packages.yml`, and `pages-production.yml` - real packaging, verification, and deployment automation

## Risks Or Limits

- `GameViewModel.kt` is effective but already fairly branch-heavy, so the controller-style approach should be treated as a good small-product pattern rather than as a no-limits scaling model.
- The repository is stronger as a product-shell, persistence, and gameplay-core reference than as a graphics/runtime reference; teams looking for low-level render-loop techniques should pair it with engine-focused entries.
- Some workflow configuration still looks slightly split-brained because the default branch is `development` while some package/pages workflows still target `master`.
- Full local Gradle verification in the lab remains blocked by the machine's Java `8` runtime even though the inspected repository clearly expects JDK `17+` and often `21`.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `android-game`
- Focus tags: `2d`, `android`, `multiplatform`, `ui-hud`, `input`, `audio`, `save-load`, `testing`
- Follow-up needed:
  - if the lab revisits this repository later, rerun Gradle discovery or targeted tests in a real JDK `17+` or `21` environment
  - a narrower revisit could isolate the pure session engine, the word-catalog DSL, or the settings/history shell instead of reopening the whole repository broadly
