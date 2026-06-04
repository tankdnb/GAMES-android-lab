# Research Note

## Repository Snapshot

- Repository: `xxxcucus/planes`
- Source URL: [https://github.com/xxxcucus/planes](https://github.com/xxxcucus/planes)
- Owner: `xxxcucus`
- Batch ID: [`BATCH-2026-06-04-W`](../batches/BATCH-2026-06-04-W.md)
- Type: `android-game`
- License: `MIT`
- Selection date: `2026-06-04`
- Last pushed at selection: `2026-06-03`
- Stars at selection: `42`
- Investigated commit: `41485900b8d7e236ab5c6e498be11fe1b47088ac`
- Research status: `accepted`
- Build mode: `static-review + compose-gradlew-failed-missing-wrapper-files`
- Catalog card: [catalog/projects/xxxcucus-planes.md](../../catalog/projects/xxxcucus-planes.md)

## Why This Repository Was Selected

- `xxxcucus/planes` was the strongest current candidate in the refreshed exact-license shortlist because it combines direct Android relevance, fresh activity, public distribution signal, and a broader product shell than most small Kotlin board-game repos.
- Compared with the other refreshed candidates, it offered a better balance of popularity, freshness, and expected architecture yield: a current Kotlin Android app, a legacy Android implementation with real tests, a custom multiplayer/chat backend contract, and visible Play Store plus F-Droid release history.
- The main question for this batch was whether the repository was only another simple board game or whether it preserved enough reusable Android-specific structure to justify a main-catalog entry. The answer is yes: the current Compose app plus the retained legacy test surface make it a stronger migration and product-shell reference than a typical board-game sample.

## Technical Profile

- Main language(s): Kotlin primary, with significant legacy Java and C++ / Qt history in the same monorepo
- Engine / framework: Android SDK + Jetpack Compose + Hilt + Retrofit + Room + DataStore + Media3 in the current app; legacy Android views/fragments and C++ / Qt desktop implementations are still checked in
- Rendering stack: Compose `Canvas` board rendering and responsive layouts in the current Android app; older Android and desktop renderers are preserved for reference
- Android target: direct; the repository is an Android game project with public Google Play and F-Droid references
- Build system:
  - `kotlin/PlanesCompose`: single-module Android Gradle Kotlin DSL app with AGP `9.0.0`, Kotlin `2.2.10`, `compileSdk 36`, `targetSdk 36`, and `minSdk 26`
  - `kotlin/PlanesAndroid`: legacy single-module Android Groovy DSL app with Java `17`, data binding, and the historical Android-side test suite
- Repository layout summary: mixed-generation monorepo with `c_plus_plus/`, `java/obsolete/`, `kotlin/PlanesAndroid`, `kotlin/PlanesCompose`, `fastlane/`, `docs/`, and `Book/`
- Source footprint:
  - total files counted in repository: `1140`
  - Kotlin files counted in repository: `372`
  - Java files counted in repository: `67`
  - XML files counted in repository: `120`
- Test surface:
  - current `PlanesCompose` tests found: `2` placeholder files
  - legacy `PlanesAndroid` tests found: `27` Android-side files (`15` unit + `12` instrumented)
  - C++ test files found: `54`
- Key modules reviewed:
  - `README.md`
  - `fastlane/Fastfile`
  - `fastlane/Appfile`
  - `kotlin/PlanesCompose/settings.gradle.kts`
  - `kotlin/PlanesCompose/build.gradle.kts`
  - `kotlin/PlanesCompose/app/build.gradle.kts`
  - `kotlin/PlanesCompose/gradle/libs.versions.toml`
  - `kotlin/PlanesCompose/app/src/main/AndroidManifest.xml`
  - `kotlin/PlanesCompose/app/src/main/java/com/planes/android/MainActivity.kt`
  - `kotlin/PlanesCompose/app/src/main/java/com/planes/android/navigation/PlanesNavigation.kt`
  - `kotlin/PlanesCompose/app/src/main/java/com/planes/android/di/PlaneRoundModule.kt`
  - `kotlin/PlanesCompose/app/src/main/java/com/planes/android/di/MultiplayerRoundModule.kt`
  - `kotlin/PlanesCompose/app/src/main/java/com/planes/android/di/RetrofitModule.kt`
  - `kotlin/PlanesCompose/app/src/main/java/com/planes/android/di/RoomModule.kt`
  - `kotlin/PlanesCompose/app/src/main/java/com/planes/android/di/DataStoreModule.kt`
  - `kotlin/PlanesCompose/app/src/main/java/com/planes/singleplayerengine/PlaneRound.kt`
  - `kotlin/PlanesCompose/app/src/main/java/com/planes/singleplayerengine/ComputerLogic.kt`
  - `kotlin/PlanesCompose/app/src/main/java/com/planes/multiplayerengine/MultiplayerRound.kt`
  - `kotlin/PlanesCompose/app/src/main/java/com/planes/android/repository/PlanesUserRepository.kt`
  - `kotlin/PlanesCompose/app/src/main/java/com/planes/android/repository/PlanesGameRepository.kt`
  - `kotlin/PlanesCompose/app/src/main/java/com/planes/android/repository/ChatDbRepository.kt`
  - `kotlin/PlanesCompose/app/src/main/java/com/planes/android/repository/NewMessagesDbRepository.kt`
  - `kotlin/PlanesCompose/app/src/main/java/com/planes/android/screens/chat/ChatUserListViewModel.kt`
  - `kotlin/PlanesCompose/app/src/main/java/com/planes/android/screens/createmultiplayergame/CreateViewModel.kt`
  - `kotlin/PlanesCompose/app/src/main/java/com/planes/android/screens/login/LoginViewModel.kt`
  - `kotlin/PlanesCompose/app/src/main/java/com/planes/android/screens/norobot/NoRobotViewModel.kt`
  - `kotlin/PlanesCompose/app/src/main/java/com/planes/android/screens/video/VideoModelRepository.kt`
  - `kotlin/PlanesCompose/app/src/main/java/com/planes/android/screens/preferences/PreferencesViewModel.kt`
  - `kotlin/PlanesCompose/app/src/main/java/com/planes/android/screens/singleplayergame/PlaneGridViewModel.kt`
  - `kotlin/PlanesCompose/app/src/main/java/com/planes/android/screens/singleplayergame/BoardEditingScreenSinglePlayer.kt`
  - `kotlin/PlanesCompose/app/src/main/java/com/planes/android/screens/singleplayergame/GameScreenSinglePlayer.kt`
  - `kotlin/PlanesCompose/app/src/main/java/com/planes/android/screens/singleplayergame/GridSquareGame.kt`
  - `kotlin/PlanesCompose/app/src/main/java/com/planes/android/screens/multiplayergame/GameScreenMultiPlayer.kt`
  - `kotlin/PlanesCompose/app/src/main/java/com/planes/android/screens/multiplayergame/ComputerGridViewModelMultiPlayer.kt`
  - `kotlin/PlanesAndroid/app/build.gradle`
  - `kotlin/PlanesAndroid/app/src/test/java/com/planes/singleround/test/PlaneRoundTest.kt`
  - `kotlin/PlanesAndroid/app/src/androidTest/java/fragment/test/GameFragmentSinglePlayerTest.kt`

## Build And Runtime Notes

- The repository was investigated through static review plus lightweight Gradle discovery attempts.
- The current Android rewrite in `kotlin/PlanesCompose` checks in `gradlew` and `gradlew.bat`, but the `gradle/wrapper/` directory is missing from the tree.
- Because of that, both `cmd /c gradlew.bat --version` and `cmd /c gradlew.bat help --no-daemon` fail immediately with `Could not find or load main class org.gradle.wrapper.GradleWrapperMain`.
- This means the current build reproducibility problem is repository-side for the Compose app, not only a lab-environment JDK limitation.
- The legacy `PlanesAndroid` branch still preserves a fuller historical verification story than the current rewrite:
  - `15` JVM-side unit tests for the single-round core
  - `12` fragment-level Android instrumentation tests
- The current Compose rewrite retains only the default `ExampleUnitTest.kt` and `ExampleInstrumentedTest.kt` placeholders.
- The checked-in `fastlane` setup shows a real Android release surface:
  - `test`, `beta`, and `deploy` lanes
  - Play Store metadata
  - screenshots and localized store assets
- README claims that Android-side equivalents of the single-round tests exist; that is true for `PlanesAndroid`, but not for the current `PlanesCompose` rewrite.
- No runtime launch was attempted.

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `3`
- Implementation depth: `3`
- Code clarity: `2`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - `planes` is more than a compact board-game sample: it is a multi-generation Android product reference with a portable rules core, a modern Compose rewrite, a legacy but meaningful regression surface, and a real release/distribution footprint.
  - The strongest reusable value is the separation between pure-ish game rules, Android-hosted board/UI state, and a REST-polled multiplayer/chat shell.
  - The repo is especially useful as a migration and product-shell reference because it keeps older implementations and tests beside the current Kotlin Android path instead of pretending the rewrite started from zero.

## Interesting Findings

### Engine Architecture And Core Loop

- `kotlin/PlanesCompose/app/src/main/java/com/planes/singleplayerengine/PlaneRound.kt` is the most reusable seam in the repository. It keeps board size, plane placement, turn order, guess tracking, score statistics, and round-end logic in a plain Kotlin rules core rather than burying them inside Compose screens.
- `PlaneRound` also exposes a clean "show plane after kill" expansion path: when a plane head is guessed, the engine can synthesize and publish the remaining plane points as extra reveal guesses instead of forcing the UI layer to reverse-engineer the board state.
- `kotlin/PlanesCompose/app/src/main/java/com/planes/multiplayerengine/MultiplayerRound.kt` wraps the same single-player core rather than duplicating game rules. That is a useful reminder that asynchronous remote play can often reuse the same authoritative board logic if move ownership and round-end reconciliation are modeled separately.
- `kotlin/PlanesCompose/app/src/main/java/com/planes/android/MainActivity.kt` turns the app into a product shell rather than a one-screen game. One activity owns the drawer, navigation, popup help, preferences hydration, and both injected game-round singletons.
- The monorepo itself is informative: desktop Qt, older Android XML/fragment code, and the current Compose rewrite all coexist. That makes the repository a rare migration reference, not just a gameplay sample.

### Rendering And Graphics

- `GridSquareGame.kt` shows a small but effective Compose rendering approach for board games:
  - draw the square itself through `Canvas`
  - encode plane ownership and plane-head markers through integer annotations
  - overlay guesses as simple geometric symbols
  - animate dead/head hits with a small `Animatable` scale effect instead of a heavier scene graph
- `BoardEditingScreenSinglePlayer.kt` and `GameScreenSinglePlayer.kt` compute board size directly from screen orientation and grid dimensions, then rebuild the surrounding control layout around the board. That is a good pattern for tablet/phone and portrait/landscape adaptation without maintaining a separate renderer.
- The current rendering path is intentionally lightweight. It uses board-cell composables and symbolic drawing rather than texture-heavy game assets, which makes the board UI easy to port and reason about.

### Gameplay Systems

- `ComputerLogic.kt` is the standout gameplay-system artifact. The AI does not guess randomly after a hit; it maintains a scored map of possible plane heads and orientations, updates those scores from hit/miss/dead evidence, and combines three strategy modes depending on the configured difficulty.
- `PlaneGridViewModel.kt` mirrors only the board state the UI needs: selected plane, computed plane points, overlap/out-of-bounds flags, and guess lists. That keeps the Compose layer explicit without forcing screens to manipulate the raw engine collections directly.
- The board-editing flow is stronger than it first looks. Placement validity is checked through overlap detection plus outside-grid detection, and the player cannot finalize editing while the current arrangement is invalid.
- `GameScreenMultiPlayer.kt` plus `ComputerGridViewModelMultiPlayer.kt` show a pragmatic asynchronous multiplayer approach for a turn-based board game: send not-yet-sent moves, poll for missing opponent moves, then reconcile round-end state only when both sides' move counts make that decision safe.

### Input And Controls

- `BoardEditingScreenSinglePlayer.kt` uses three low-level touch behaviors on the same board surface:
  - tap to select a plane
  - long-press to rotate
  - drag to move planes across the board
- The drag handlers translate swipe distance into one-or-more board-cell moves instead of treating every pointer delta as one pixel-level transform. That is a useful board-game pattern when movement happens in discrete logical steps.
- In the main game flow, input stays equally explicit: guesses are board taps, and the app lets the player swap between viewing the player board and the opponent board instead of trying to overlay too many states at once.

### UI, HUD, And Menus

- The current app is much richer than a bare gameplay shell. `PlanesNavigation.kt` wires together login, registration, no-robot verification, chat, conversations, preferences, tutorials, single-player, and multiplayer screens inside one navigation graph.
- `MainActivity.kt` uses a drawer as the top-level feature switcher rather than isolating the game in a dedicated one-screen flow. That is useful for small online/mobile games where account, chat, tutorial, and configuration surfaces matter almost as much as the play screen.
- `VideoModelRepository.kt` plus the tutorial routes are a nice product touch: the app ships tutorial videos as raw resources while also tracking their corresponding YouTube URLs.
- The no-robot flow is also notable. `NoRobotViewModel.kt` models an image-selection verification step rather than delegating the whole registration-confirmation UX to a webview or third-party widget.

### Persistence And Data

- `DataStoreModule.kt` and `PreferencesViewModel.kt` show a straightforward small-product preference seam around computer difficulty, reveal behavior, and cached credentials.
- `RoomModule.kt`, `PlanesDatabase.kt`, `ChatDao.kt`, and `NewMessagesDao.kt` add a local persistence layer for chat history and unread-message flags. That is stronger than the typical "all remote, no local cache" approach found in many small online game samples.
- `ChatUserListViewModel.kt` persists incoming chat messages and unread flags locally while polling the backend, which makes the networking/UI seam easier to reason about.
- One cautionary detail is worth recording: `screens/preferences/PreferencesRepository.kt` looks incomplete and apparently unused in the current rewrite, which is another signal that the Compose app is still mid-migration.

### Networking And Multiplayer

- `RetrofitModule.kt`, `PlanesUserApi.kt`, `PlanesGameApi.kt`, `PlanesUserRepository.kt`, and `PlanesGameRepository.kt` show a complete REST-backed Android multiplayer shell:
  - login and registration
  - no-robot confirmation
  - players list
  - chat send/receive
  - game create/status/connect
  - send planes
  - send moves
  - send winner / start new round
- The multiplayer path is not socket-first. It is built around polling and REST reconciliation. That is less real-time than a WebSocket model, but it is perfectly reasonable for an asynchronous, turn-based board game and easier to transplant into other Android products.
- `CreateViewModel.kt` and `ComputerGridViewModelMultiPlayer.kt` are especially useful references for poll-driven session state:
  - poll game status until the second player joins
  - send only unsent moves
  - ask the backend for missing opponent moves
  - track send/receive indexes locally

### Tooling And Content Pipeline

- `fastlane/Fastfile`, `fastlane/Appfile`, and the metadata tree show a release discipline that many game repos never reach. Even though the codebase is mixed-generation and small-team in feel, publication assets and lanes are checked in rather than left implicit.
- The localized Play Store metadata, screenshots, feature graphic, and video references make this repository stronger as a public-product reference than many similar Android samples.

### Android Platform Integration

- README and `fastlane` both confirm that the Android app has been treated as a real shipped product rather than a private demo. The repository references both Google Play and F-Droid delivery.
- The current Compose app uses:
  - Hilt for app and game-core injection
  - edge-to-edge `ComponentActivity`
  - Compose Navigation
  - DataStore and Room
  - Media3 for tutorial playback
- This makes `planes` a useful Android integration reference even if the core game itself is mechanically simple.

### Build, Release, And Testing

- The repository preserves a strong cross-generation testing story:
  - older C++ runtime tests
  - legacy Android unit and fragment tests
  - current Compose rewrite placeholders only
- That asymmetry is actually informative. It shows what often happens during UI rewrites: core logic and old UI coverage survive, while the new presentation layer temporarily outruns the test surface.
- The current Compose app is not self-contained from a build-reproducibility standpoint because its wrapper files are incomplete.
- `fastlane` and the store-metadata tree partially offset that weakness by proving the project has had a real Android release workflow, even if the current checked-in Compose branch is not fully turnkey from a fresh clone.

## Reusable Takeaways

- Keeping board-game rules in a plain Kotlin core makes it much easier to survive UI rewrites from fragments/views to Compose.
- Turn-based multiplayer on Android does not always need sockets; indexed move polling plus local Room/DataStore state can be enough when the game is asynchronous.
- A mixed-generation monorepo can still be valuable when it preserves old tests and release artifacts instead of deleting all historical context during rewrites.
- Store metadata, screenshots, and release lanes are worth keeping in version control even for small games because they make product-level reproducibility much better.

## Evidence Summary

- `PlaneRound.kt`, `ComputerLogic.kt`, `MultiplayerRound.kt` - pure-ish board rules, AI scoring, and async multiplayer wrapper
- `MainActivity.kt`, `PlanesNavigation.kt`, `PlaneRoundModule.kt`, `MultiplayerRoundModule.kt` - product shell, drawer routing, and injected singletons
- `BoardEditingScreenSinglePlayer.kt`, `GameScreenSinglePlayer.kt`, `GridSquareGame.kt`, `PlaneGridViewModel.kt` - Compose board editing, rendering, and gesture ownership
- `RetrofitModule.kt`, `PlanesUserApi.kt`, `PlanesGameApi.kt`, `CreateViewModel.kt`, `ComputerGridViewModelMultiPlayer.kt` - REST-backed multiplayer and polling-based session orchestration
- `ChatUserListViewModel.kt`, `RoomModule.kt`, `ChatDao.kt`, `NewMessagesDao.kt`, `PreferencesViewModel.kt` - local persistence and product-shell data flow
- `Fastfile`, `Appfile`, `fastlane/metadata/android/*` - release automation and public store assets
- `kotlin/PlanesAndroid/app/src/test/*`, `kotlin/PlanesAndroid/app/src/androidTest/*`, `c_plus_plus/tests/*` - historical regression surface that still matters during the Compose rewrite

## Risks Or Limits

- The current `PlanesCompose` rewrite lacks meaningful automated tests and still carries default placeholder test files.
- The current Compose project is not build-reproducible from a fresh clone because the Gradle wrapper files are incomplete.
- The codebase is split across generations, so README-level claims and verified current-state facts can drift.
- Some parts of the rewrite still look unfinished or transitional:
  - many TODOs
  - a likely unused `PreferencesRepository.kt`
  - placeholder / migration leftovers
- Multiplayer is turn-based polling over REST, not a real-time networking reference.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `android-game`
- Focus tags: `2d`, `android`, `networking`, `input`, `ui-hud`, `testing`
- Follow-up needed:
  - if the lab revisits this repository, first restore or verify the current `PlanesCompose` wrapper/toolchain path before attempting build validation
  - good narrow revisit targets would be the `PlaneRound` plus `ComputerLogic` core, the polling-based multiplayer shell, or the migration difference between `PlanesAndroid` and `PlanesCompose`
