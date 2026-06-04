# Research Note

## Repository Snapshot

- Repository: `joaomanaia/newquiz`
- Source URL: [https://github.com/joaomanaia/newquiz](https://github.com/joaomanaia/newquiz)
- Owner: `joaomanaia`
- Batch ID: [`BATCH-2026-06-04-J`](../batches/BATCH-2026-06-04-J.md)
- Type: `android-game`
- License: `Apache-2.0`
- Selection date: `2026-06-04`
- Last pushed at selection: `2025-01-27`
- Stars at selection: `156`
- Investigated commit: `c6f3748ce80e0318a583f1785da728f7a3fdd0aa`
- Research status: `accepted`
- Build mode: `static-review + gradle-help-failed-no-jdk`
- Catalog card: [catalog/projects/joaomanaia-newquiz.md](../../catalog/projects/joaomanaia-newquiz.md)

## Why This Repository Was Selected

- From the current explicit-license shortlist, `joaomanaia/newquiz` still had the strongest balance of direct Android relevance, public signal, permissive licensing, and expected research yield.
- The repository looked more valuable than a typical trivia app because it combines several quiz modes, a generated maze meta-mode, daily challenges, profile/progression tracking, `normal` / `foss` distribution flavors, and a large test surface.
- The main question for this pass was whether it was mostly a polished Compose UI sample or a deeper Android game-product reference. It turned out to be a strong product-shell and progression reference.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: Android SDK + Jetpack Compose + Material 3 + Hilt + WorkManager + Room + DataStore + Ktor + Firebase / Remote Config
- Rendering stack: Compose-first game and product UI; the repository builds screens, boards, keyboards, and navigation through Compose instead of a custom GL runtime
- Android target: direct; the repository is an Android-first app with `normal` and `foss` distribution flavors
- Build system: multi-module Gradle Kotlin DSL Android project with an included `build-logic` convention build
- Repository layout summary: `app` shell, `core/data/domain/model` layers, dedicated feature modules, separate gameplay modules for multi-choice, Wordle, and comparison quiz, plus convention plugins under `build-logic`
- Source footprint:
  - total files reviewed in repository: `972`
  - Kotlin/Java files reviewed across the repository: `523`
  - included Gradle modules: `19`
- Test surface:
  - test files found: `73`
  - the visible coverage spans model, data, domain, workers, Compose UI, and gameplay-core paths
- Key modules reviewed:
  - `README.md`
  - `settings.gradle.kts`
  - `build.gradle.kts`
  - `gradle/libs.versions.toml`
  - `app/build.gradle.kts`
  - `data/build.gradle.kts`
  - `domain/build.gradle.kts`
  - `core/build.gradle.kts`
  - `.github/workflows/android.yml`
  - `build-logic/convention/src/main/kotlin/com/infinitepower/newquiz/Flavors.kt`
  - `build-logic/convention/src/main/kotlin/AndroidApplicationFirebaseConventionPlugin.kt`
  - `app/src/main/java/com/infinitepower/newquiz/core/navigation/AppNavGraphs.kt`
  - `app/src/main/java/com/infinitepower/newquiz/ui/main/MainViewModel.kt`
  - `app/src/main/java/com/infinitepower/newquiz/initializer/WorkManagerInitializer.kt`
  - `app/src/main/java/com/infinitepower/newquiz/initializer/EnqueueStartWorksInitializer.kt`
  - `feature/maze/src/main/kotlin/com/infinitepower/newquiz/feature/maze/generate/GenerateMazeScreenViewModel.kt`
  - `feature/maze/src/main/kotlin/com/infinitepower/newquiz/feature/maze/common/MazeCategories.kt`
  - `feature/profile/src/main/kotlin/com/infinitepower/newquiz/feature/profile/ProfileViewModel.kt`
  - `data/src/main/java/com/infinitepower/newquiz/data/worker/maze/GenerateMazeQuizWorker.kt`
  - `data/src/main/java/com/infinitepower/newquiz/data/worker/daily_challenge/VerifyDailyChallengeWorker.kt`
  - `data/src/main/java/com/infinitepower/newquiz/data/repository/daily_challenge/DailyChallengeRepositoryImpl.kt`
  - `data/src/main/java/com/infinitepower/newquiz/data/repository/home/RecentCategoriesRepositoryImpl.kt`
  - `data/src/main/java/com/infinitepower/newquiz/data/repository/wordle/WordleRepositoryImpl.kt`
  - `data/src/main/java/com/infinitepower/newquiz/data/repository/comparison_quiz/ComparisonQuizRepositoryImpl.kt`
  - `multi-choice-quiz/src/main/java/com/infinitepower/newquiz/multi_choice_quiz/MultiChoiceQuizScreenViewModel.kt`
  - `wordle/src/main/java/com/infinitepower/newquiz/wordle/WordleScreenViewModel.kt`
  - `wordle/src/main/java/com/infinitepower/newquiz/wordle/util/worker/WordleEndGameWorker.kt`
  - `comparison-quiz/src/main/java/com/infinitepower/newquiz/comparison_quiz/core/ComparisonQuizCoreImpl.kt`
  - `core/src/main/java/com/infinitepower/newquiz/core/game/GameCore.kt`
  - `core/database/src/main/kotlin/com/infinitepower/newquiz/core/database/AppDatabase.kt`
  - `core/user-services/src/main/kotlin/com/infinitepower/newquiz/core/user_services/LocalUserServiceImpl.kt`
  - `core/user-services/src/main/kotlin/com/infinitepower/newquiz/core/user_services/data/xp/MultiChoiceQuizXpGeneratorImpl.kt`
  - `core/user-services/src/main/kotlin/com/infinitepower/newquiz/core/user_services/workers/MultiChoiceQuizEndGameWorker.kt`
  - `comparison-quiz/src/test/java/com/infinitepower/newquiz/comparison_quiz/core/ComparisonQuizCoreImplTest.kt`
  - `data/src/test/java/com/infinitepower/newquiz/data/repository/daily_challenge/DailyChallengeRepositoryImplTest.kt`
  - `wordle/src/androidTest/java/com/infinitepower/newquiz/wordle/WordleScreenTest.kt`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeds and reports Gradle `8.11.1` on a Java `8` launcher.
- `cmd /c gradlew.bat help --no-daemon` fails in the lab because the current machine exposes only a Java `8` JRE without a Java compiler:
  - `No Java compiler found, please ensure you are running Gradle with a JDK`
- Upstream CI confirms the intended floor is newer:
  - `.github/workflows/android.yml` sets `JAVA_VERSION: "17"` and runs unit tests, lint, detekt, and debug APK assembly
- The repository also documents additional local setup requirements:
  - `README.md` says build/run needs `google-services.json`
  - `README.md` also warns that the `foss` build still contains some proprietary integrations
- No runtime launch was attempted.

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `3`
- Implementation depth: `3`
- Code clarity: `3`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - `newquiz` is a strong Android product reference for small and mid-sized casual games that want more than a single gameplay screen.
  - Its main value is not raw rendering complexity. It is the way several quiz modes, progression, scheduling, persistence, category personalization, and distribution flavors are kept modular without becoming unreadable.
  - The repository also has a stronger-than-usual verification surface for this niche: gameplay-core tests, worker tests, repository tests, and Compose instrumentation tests are all visible in the tree.

## Interesting Findings

### Engine Architecture And Core Loop

- `app/src/main/java/com/infinitepower/newquiz/core/navigation/AppNavGraphs.kt` keeps the whole product inside one typed Compose Destinations navigation shell. That is a reusable pattern for multi-mode casual games where several game screens, results, settings, profile, and daily-challenge routes must coexist without ad hoc string routing.
- `app/src/main/java/com/infinitepower/newquiz/ui/main/MainViewModel.kt` combines animation settings, analytics-consent state, daily-challenge claim count, and the user's diamonds into one root UI state. That is a good product-shell pattern for Android games that need persistent meta-state above the current round.
- `app/src/main/java/com/infinitepower/newquiz/initializer/WorkManagerInitializer.kt` and `EnqueueStartWorksInitializer.kt` show an explicit App Startup ownership model: WorkManager is reconfigured with a Hilt worker factory, then startup tasks such as daily-challenge verification and analytics logging are enqueued automatically.
- `core/src/main/java/com/infinitepower/newquiz/core/game/GameCore.kt` plus `comparison-quiz/src/main/java/com/infinitepower/newquiz/comparison_quiz/core/ComparisonQuizCoreImpl.kt` show a useful split where one game mode keeps its rules and progression inside a small `StateFlow`-backed core rather than folding all logic into Compose screens.

### Rendering And Graphics

- The repository is intentionally Compose-first. Its value is that boards, keyboards, progress shells, and navigation are built through normal Android UI primitives instead of a custom rendering runtime. That makes it a strong reference for teams building Android game products where UX and state are more important than low-level graphics.
- `wordle/src/androidTest/java/com/infinitepower/newquiz/wordle/WordleScreenTest.kt` confirms that even the game board/keyboard shell is treated as a semantics-aware Compose surface that can be validated through UI tests, not as an opaque visual blob.

### Gameplay Systems

- `data/src/main/java/com/infinitepower/newquiz/data/worker/maze/GenerateMazeQuizWorker.kt` is one of the strongest findings in the repository. It builds a maze meta-mode by combining multi-choice, Wordle, and comparison-quiz generators under one seeded worker, using remote config to tune total question count and mode distribution.
- `feature/maze/src/main/kotlin/com/infinitepower/newquiz/feature/maze/common/MazeCategories.kt` and `GenerateMazeScreenViewModel.kt` keep the maze setup surface explicit: users can choose all categories, only offline categories, or game-mode-specific subsets before the worker generates a run.
- `comparison-quiz/src/main/java/com/infinitepower/newquiz/comparison_quiz/core/ComparisonQuizCoreImpl.kt` turns a simple comparison minigame into a reusable core by pairing fetched items into rounds, applying remote-config helper-value behavior, and handling paid skips through the user-economy service instead of screen-local hacks.
- `data/src/main/java/com/infinitepower/newquiz/data/repository/wordle/WordleRepositoryImpl.kt` broadens Wordle into several quiz types: text words, numbers, math formulas, and number trivia. The validation rules differ by mode, but the repository keeps them behind one interface instead of scattering them through UI state.
- `data/src/main/java/com/infinitepower/newquiz/data/repository/daily_challenge/DailyChallengeRepositoryImpl.kt` generates daily tasks from the global `GameEvent` space, comparison categories, and remote-config reward values. That is a clean reference for daily meta-goals in small Android game products.

### Input And Controls

- `multi-choice-quiz/src/main/java/com/infinitepower/newquiz/multi_choice_quiz/MultiChoiceQuizScreenViewModel.kt` owns round timing, answer selection, verification, save-question flow, paid skips, translation, maze completion, and worker-based endgame processing in one explicit controller. The result is busy but still readable product logic rather than fragmented callbacks.
- `wordle/src/main/java/com/infinitepower/newquiz/wordle/WordleScreenViewModel.kt` handles keyboard input, removal, row verification, hard-mode hint enforcement, disabled-key tracking, row-limit policy, and maze integration in one place while keeping actual word generation and validation in the repository layer.
- `data/src/main/java/com/infinitepower/newquiz/data/repository/home/RecentCategoriesRepositoryImpl.kt` is a practical product pattern: recent categories are persisted, only three are surfaced by default, and offline-aware sorting can hide categories that require internet when the device is offline.

### UI, HUD, And Menus

- `AppNavGraphs.kt` and `MainViewModel.kt` together show a polished product shell: game modes, results, settings, profile, daily challenge, and saved questions all live inside one coordinated navigation and top-level state model.
- `feature/profile/src/main/kotlin/com/infinitepower/newquiz/feature/profile/ProfileViewModel.kt` turns stored XP history into time-range-filtered UI data. That is a useful pattern for progression dashboards in Android games that want more than a static score screen.
- The repository is a good reminder that an Android game reference can be valuable because of its menuing, progression, and session-shell quality rather than because of low-level renderer sophistication.

### Persistence And Data

- `core/database/src/main/kotlin/com/infinitepower/newquiz/core/database/AppDatabase.kt` stores saved questions, maze items, daily challenges, and game-result history inside one Room database with explicit auto migrations. That is a practical persistence baseline for a multi-mode casual game.
- `core/user-services/src/main/kotlin/com/infinitepower/newquiz/core/user_services/LocalUserServiceImpl.kt` combines DataStore-backed user preferences with Room-stored game results and remote-config-driven rewards. XP, diamonds, and level-up bonuses are handled centrally instead of per game mode.
- `core/user-services/src/main/kotlin/com/infinitepower/newquiz/core/user_services/workers/MultiChoiceQuizEndGameWorker.kt` and `wordle/src/main/java/com/infinitepower/newquiz/wordle/util/worker/WordleEndGameWorker.kt` move end-of-round bookkeeping into workers. That keeps UI flows thinner while still recording analytics, progression, recent-category updates, and maze completion consistently.

### Tooling, Android Integration, Or Other Notable Areas

- `build-logic/convention/src/main/kotlin/com/infinitepower/newquiz/Flavors.kt` and `AndroidApplicationFirebaseConventionPlugin.kt` are a durable build-architecture idea: the project encodes `normal` and `foss` distribution flavors centrally and routes proprietary integrations such as Firebase through `normalImplementation`.
- The split is not fully clean yet, but it is still a good reference for Android game teams that want one codebase to serve both a richer store build and a more restricted distribution build.
- `data/src/main/java/com/infinitepower/newquiz/data/worker/daily_challenge/VerifyDailyChallengeWorker.kt` plus the startup initializers show a clean Android-native pattern for daily task rotation that does not depend on the user opening a specific game mode.

### Build, Release, And Testing

- `settings.gradle.kts` shows a serious module split for a casual game: `app`, layered `core/data/domain/model`, several feature modules, separate gameplay modules, and an included convention build.
- `.github/workflows/android.yml` runs unit tests, lint, detekt, and both `assembleNormalDebug` and `assembleFossDebug`, which is a stronger release discipline than many similarly sized Android game samples.
- The visible test surface is substantial:
  - `comparison-quiz/src/test/java/com/infinitepower/newquiz/comparison_quiz/core/ComparisonQuizCoreImplTest.kt` exercises core round flow and paid skips with temp DataStore plus fake DAO state
  - `data/src/test/java/com/infinitepower/newquiz/data/repository/daily_challenge/DailyChallengeRepositoryImplTest.kt` validates expiration, generation, completion, and claiming behavior
  - `wordle/src/androidTest/java/com/infinitepower/newquiz/wordle/WordleScreenTest.kt` uses Hilt and WorkManager test helpers to drive the real Compose UI
- Local build verification in the lab is weaker than the codebase deserves because the machine still lacks a full JDK and cannot configure the project beyond lightweight wrapper inspection.

## Reusable Takeaways

- For Android casual games, a product-shell architecture can be more valuable than a custom rendering loop. `newquiz` shows how to keep progression, settings, badges, and multiple modes coherent in one Compose app.
- WorkManager is useful for more than sync: it can own end-of-round persistence, daily challenge rotation, and startup bookkeeping without cluttering UI controllers.
- A central user service that owns XP, diamonds, and level-up rewards is easier to reuse across many mini-games than mode-specific reward code.
- A partial `normal` / `foss` flavor split can still be worthwhile even before every proprietary dependency is fully isolated.

## Evidence Summary

- `AppNavGraphs.kt`, `MainViewModel.kt`, `WorkManagerInitializer.kt`, `EnqueueStartWorksInitializer.kt` - product shell, top-level state, and Android startup ownership
- `GameCore.kt`, `ComparisonQuizCoreImpl.kt` - pure gameplay-core pattern for one mode
- `GenerateMazeScreenViewModel.kt`, `MazeCategories.kt`, `GenerateMazeQuizWorker.kt` - cross-mode maze generation and meta-mode setup
- `DailyChallengeRepositoryImpl.kt`, `VerifyDailyChallengeWorker.kt` - event-driven daily challenge generation and periodic verification
- `MultiChoiceQuizScreenViewModel.kt`, `WordleScreenViewModel.kt`, `WordleRepositoryImpl.kt` - mode-specific controller logic, input handling, and variant-specific validation
- `RecentCategoriesRepositoryImpl.kt`, `ProfileViewModel.kt` - personalized home/category flow and progression dashboard
- `AppDatabase.kt`, `LocalUserServiceImpl.kt`, `MultiChoiceQuizEndGameWorker.kt`, `WordleEndGameWorker.kt` - persistence, progression, and worker-based endgame bookkeeping
- `Flavors.kt`, `AndroidApplicationFirebaseConventionPlugin.kt`, `.github/workflows/android.yml` - build flavors, proprietary dependency split, and CI discipline
- `ComparisonQuizCoreImplTest.kt`, `DailyChallengeRepositoryImplTest.kt`, `WordleScreenTest.kt` - meaningful rule, data, and UI verification

## Risks Or Limits

- The repository is most useful for quiz, word, and casual-product patterns; it is less relevant for low-level rendering, real-time action loops, or physics-heavy games.
- The code is not especially fresh anymore: the inspected commit and last push date are both `2025-01-27`, even though GitHub metadata was updated later.
- Full local verification in the lab is blocked by the missing JDK, and actual app builds would also need `google-services.json`.
- The `foss` split is only partial at the moment; the repository itself warns that proprietary integrations are not fully removed yet.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `android-game`
- Focus tags: `android`, `ui-hud`, `save-load`, `procedural-generation`, `testing`
- Follow-up needed:
  - if the lab revisits this repository, rerun build and selected tests in a JDK `17+` Android SDK-ready environment with the required `google-services.json`
  - a good scoped revisit target would be the maze meta-mode generation path, the central progression/user-service model, or the `normal` / `foss` build split rather than reopening the whole repository broadly
