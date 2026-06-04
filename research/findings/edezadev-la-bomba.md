# Research Note

## Repository Snapshot

- Repository: `edezadev/la-bomba`
- Source URL: [https://github.com/edezadev/la-bomba](https://github.com/edezadev/la-bomba)
- Owner: `edezadev`
- Batch ID: [`BATCH-2026-06-04-Q`](../batches/BATCH-2026-06-04-Q.md)
- Type: `android-game`
- License: `Apache-2.0`
- Selection date: `2026-06-04`
- Last pushed at selection: `2026-06-03`
- Stars at selection: `0`
- Investigated commit: `eee85afa520e9e3fc5685931123d71377ee4482f`
- Research status: `accepted`
- Build mode: `static-review + gradle-help-failed-java8-needs-java11`
- Catalog card: [catalog/projects/edezadev-la-bomba.md](../../catalog/projects/edezadev-la-bomba.md)

## Why This Repository Was Selected

- `edezadev/la-bomba` was the strongest remaining direct-Android candidate in the current explicit-license shortlist after `Mesabloo/hm-defense`.
- Compared with the older libGDX rewrite alternative, it offered fresher Android code, explicit Firebase-backed content sync, and a clearer small-product shell built with standard Android UI layers.
- The main question for this batch was whether the repository was only a thin Firebase-wrapped toy or whether it preserved enough reusable Android game-product structure to earn a main-catalog slot. The answer is yes, but mainly as a compact product-shell reference rather than as a gameplay-engine reference.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: Android SDK + Material Design 3 + Firebase Firestore/Auth/Analytics + Google Mobile Ads + Media3 ExoPlayer
- Rendering stack: standard Android views, fragments, RecyclerView, ViewPager2, and Material bottom sheets rather than a custom renderer or engine runtime
- Android target: direct; the repository is an Android-only application
- Build system: single-module Gradle Kotlin DSL Android project with AGP `8.13.2`, Kotlin `2.3.20`, `compileSdk 35`, `targetSdk 35`, and `minSdk 25`
- Repository layout summary: one `app` module with `config`, `controllers`, `models`, and `utils` packages plus root docs such as `README.md`, `SETUP.md`, and `PRIVACY.md`
- Source footprint:
  - total files counted in repository: `130`
  - Kotlin/Java/build-script files counted in repository: `46`
  - included Gradle modules: `1`
- Test surface:
  - test files found: `2`
  - meaningful automated assertion-heavy tests found: `0`
- Key modules reviewed:
  - `README.md`
  - `SETUP.md`
  - `settings.gradle.kts`
  - `build.gradle.kts`
  - `app/build.gradle.kts`
  - `gradle.properties`
  - `app/src/main/AndroidManifest.xml`
  - `app/src/main/java/com/edeza/labomba/utils/BaseActivity.kt`
  - `app/src/main/java/com/edeza/labomba/utils/GameSession.kt`
  - `app/src/main/java/com/edeza/labomba/utils/AdsManager.kt`
  - `app/src/main/java/com/edeza/labomba/config/auth/FirebaseAuthManager.kt`
  - `app/src/main/java/com/edeza/labomba/config/database/FirestoreConfig.kt`
  - `app/src/main/java/com/edeza/labomba/config/database/PenaltyDbManager.kt`
  - `app/src/main/java/com/edeza/labomba/config/database/PlayerDbManager.kt`
  - `app/src/main/java/com/edeza/labomba/config/database/TopicDbManager.kt`
  - `app/src/main/java/com/edeza/labomba/controllers/activities/MainActivity.kt`
  - `app/src/main/java/com/edeza/labomba/controllers/activities/SettingsActivity.kt`
  - `app/src/main/java/com/edeza/labomba/controllers/activities/StartGameActivity.kt`
  - `app/src/main/java/com/edeza/labomba/controllers/activities/ResultsActivity.kt`
  - `app/src/main/java/com/edeza/labomba/controllers/fragments/PenaltyFragment.kt`
  - `app/src/main/java/com/edeza/labomba/controllers/fragments/PlayerFragment.kt`
  - `app/src/main/java/com/edeza/labomba/controllers/fragments/TopicsFragment.kt`
  - `app/src/main/java/com/edeza/labomba/controllers/fragments/TimerFragment.kt`

## Build And Runtime Notes

- The repository was investigated through static review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeds and reports Gradle `8.13` on a Java `8` launcher.
- `cmd /c gradlew.bat help --no-daemon` fails in the lab because the Android Gradle Plugin and Google Services plugin now require at least Java `11`, while the current machine still exposes only Java `8`.
- `cmd /c gradlew.bat :app:testDebugUnitTest --dry-run --no-daemon` fails for the same JVM-floor reason during configuration.
- `SETUP.md` still claims `Java 8+`, so the checked-in setup docs lag the actual build surface.
- The app also expects Firebase setup material such as `google-services.json` for real builds.
- No GitHub Actions workflow or other visible CI configuration was found in the checked-in repository.
- The only test files in the tree are the default template `ExampleUnitTest.kt` and `ExampleInstrumentedTest.kt`.
- No runtime launch was attempted.

## Usefulness Assessment

- Reuse potential: `2`
- Android transfer: `3`
- Implementation depth: `2`
- Code clarity: `2`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - `la-bomba` is a compact direct-Android product reference for small party, quiz, or casual-social games that want cloud-backed custom content without a heavier engine architecture.
  - Its main value is the product shell: anonymous Firebase bootstrap, fragment-hosted setup flow, local round ownership, rematch handling, and straightforward ad/audio seams.
  - It is not a rendering or multiplayer-networking baseline, but it is still useful enough to keep in the main catalog because the Android-specific implementation patterns are concrete and current.

## Interesting Findings

### Engine Architecture And Core Loop

- `app/src/main/java/com/edeza/labomba/utils/BaseActivity.kt` centralizes edge-to-edge handling, fullscreen flags, a reusable loading dialog, and double-back exit behavior. That is a solid small-app shell pattern for Android games that do not need a full engine activity hierarchy.
- `app/src/main/java/com/edeza/labomba/controllers/activities/MainActivity.kt` acts as a bootstrap shell rather than a menu-only screen: it ensures anonymous Firebase auth exists, warns about offline state after auth settles, and initializes Mobile Ads in the background before routing the user into the setup flow.
- `app/src/main/java/com/edeza/labomba/controllers/activities/SettingsActivity.kt` hosts a fragment-by-fragment wizard instead of pushing all configuration into one screen. Penalty selection, player management, topic selection, and timer choice stay modular without requiring a larger navigation stack.
- `app/src/main/java/com/edeza/labomba/utils/GameSession.kt` is the core ownership seam. The app keeps selected penalty, chosen players, chosen topics, timer length, and accumulated losers in one process-global singleton. This is simple and readable for a small game, even though it would become brittle in a larger product.
- `app/src/main/java/com/edeza/labomba/controllers/activities/StartGameActivity.kt` shows a narrow but reusable round loop: take one selected topic per round, run a countdown, force loser selection when time expires, accumulate penalties, then either advance or open results.
- `app/src/main/java/com/edeza/labomba/controllers/activities/ResultsActivity.kt` keeps the endgame simple but product-like. It computes the top loser list, supports ties through a rematch flow, and preserves only tied players for the next run instead of forcing a full reset.

### Rendering And Graphics

- The repository is intentionally not a rendering-heavy reference. It is useful precisely because it stays inside normal Android UI primitives rather than over-engineering a tiny party-game shell.
- `PenaltyFragment.kt`, `PlayerFragment.kt`, and `TopicsFragment.kt` rely on RecyclerView plus adapters and bottom sheets for most game setup interactions.
- `TopicsFragment.kt` adds one extra reusable idea: paginated topic selection rendered through `ViewPager2` plus a separate page-indicator adapter, which is a good fit for cloud-backed content lists that should stay visually manageable on phones.

### Gameplay Systems

- The gameplay model is local pass-the-device play, not a synchronized remote match. Players configure a penalty, add player names, select at least five topics, choose a bomb timer, and then play one topic per round until the results screen.
- `TimerFragment.kt` encodes the game-setup constraints directly and clearly: at least `2` players and at least `5` topics are required before the game can start.
- `ResultsActivity.kt` makes the rematch flow more interesting than a simple restart. When there is a tie, the code deletes non-tied players from the per-user Firestore collection and keeps only tied players for the replay.
- The repository's README markets the app as multiplayer, but the inspected code points to local social play rather than real-time remote match synchronization.

### Input And Controls

- `PenaltyFragment.kt`, `PlayerFragment.kt`, `TopicsFragment.kt`, and `TimerFragment.kt` show a classic Android product-control pattern: each step owns its own widgets, adapters, and bottom sheets, while shared game state is written into `GameSession`.
- `TopicAdapter.kt` and related flows keep topic selection explicit by mirroring checkbox state into `GameSession.topics`. This is less scalable than a full immutable state model, but it is easy to follow in a small product.
- `SelectLoserBottomSheet.kt` is a good reminder that not every casual game needs continuous input. Here the round resolves through one explicit choice after the timer ends, and the rest of the session loop stays simple.

### UI, HUD, And Menus

- `SettingsActivity.kt` and the fragment set form the strongest UI-shell reference in the repo. The app uses one guided setup wizard instead of a cluttered all-in-one configuration screen.
- `TopicsFragment.kt` combines a paged content list with a horizontal page-indicator bar. That is a practical pattern for medium-sized user-authored content collections.
- `ResultsActivity.kt` turns the end of a session into a proper product surface with loser standings, optional punishment text, replay handling, and a path back to the start instead of just ending the activity.
- The game shell is far more valuable than the graphics layer here. If we revisit this repo, it should be for setup-flow structure and small-product session UX.

### Audio

- `StartGameActivity.kt` maps the selected timer length to different bundled countdown tracks and plays them through Media3 ExoPlayer. That is a tidy small-game audio seam where the session length directly controls the sound choice without introducing a larger audio service layer.
- The audio implementation is bound tightly to the round activity, which is fine for this app's size and makes the timer/audio link easy to reuse in other simple Android party games.

### Persistence And Data

- `app/src/main/java/com/edeza/labomba/config/auth/FirebaseAuthManager.kt` uses anonymous Firebase auth and immediately seeds default penalty data for new users. That is a practical pattern for cloud-backed personalization without forcing account onboarding.
- `app/src/main/java/com/edeza/labomba/config/database/FirestoreConfig.kt` enables Firestore persistent local cache. This makes the app's "offline mode" claim partially real: content can be read locally even though cloud writes still need connectivity.
- `PenaltyDbManager.kt`, `PlayerDbManager.kt`, and `TopicDbManager.kt` all use per-user subcollections plus snapshot listeners. That gives the app a simple live-sync data model for user-authored setup content.
- `TopicDbManager.kt` is the most interesting of the three data managers. It paginates Firestore topic data into UI pages through a coroutine-based background pass instead of loading everything into one giant scrolling list.

### Networking And Multiplayer

- The repository does use network-backed services, but not for live match synchronization.
- `PenaltyDbManager.kt`, `PlayerDbManager.kt`, and `TopicDbManager.kt` provide live Firestore-backed content sync and offline-cache-aware reads for per-user setup data.
- The inspected gameplay path itself is still local. The cloud layer stores and syncs players, topics, and penalties, but it does not coordinate an in-progress shared game session across devices.
- That distinction matters if we later compare Firebase-backed game repos: `la-bomba` is a synced-content product shell, not a real-time multiplayer architecture sample.

### Tooling, Android Integration, Or Other Notable Areas

- `MainActivity.kt`, `AdsManager.kt`, and the manifest show a compact Android integration stack: Firebase anonymous auth, Firestore persistence, Analytics, and AdMob all live inside one small app.
- `AdsManager.kt` handles missing-interstitial cases safely by continuing the flow immediately when no ad is available, then reloading after dismissal or show failure. That is a better small-product ad seam than blocking UI on monetization.
- The manifest still uses Google's sample AdMob app ID while interstitials load through `BuildConfig.ADMOB_INTERSTITIAL_ID`. That makes the ad integration useful as a pattern, but not fully trustworthy as production-ready configuration.

### Build, Release, And Testing

- `build.gradle.kts` and `app/build.gradle.kts` show a modern single-module Android build surface with current SDK levels and Firebase/Ads/Media dependencies.
- The verification surface is weak:
  - the checked-in tests are template-only
  - no visible CI workflow was found
  - local Gradle configuration in this lab stops at the Java `11` floor because the machine still exposes Java `8`
- `SETUP.md` is already stale about the Java requirement, which is a useful caution when judging small Android repos by docs alone.

## Reusable Takeaways

- Small Android games can stay simple and still be structured: one bootstrap activity, one setup wizard, one session singleton, one round activity, and one results activity are enough when the game scope is narrow.
- Firebase anonymous auth plus per-user Firestore collections is a workable pattern for cloud-backed custom content without forcing users into a heavier account system.
- Firestore snapshot listeners and local cache can make a repo look "real-time" from a product perspective even when the actual gameplay remains local.
- For small-party products, the setup flow and rematch UX can be more reusable than the gameplay itself.

## Evidence Summary

- `BaseActivity.kt`, `MainActivity.kt`, `SettingsActivity.kt`, `StartGameActivity.kt`, `ResultsActivity.kt`, `GameSession.kt` - Android shell, guided setup flow, round ownership, and results/rematch handling
- `PenaltyFragment.kt`, `PlayerFragment.kt`, `TopicsFragment.kt`, `TimerFragment.kt`, `SelectLoserBottomSheet.kt` - step-based configuration flow, explicit controls, and end-of-round loser selection
- `FirebaseAuthManager.kt`, `FirestoreConfig.kt`, `PenaltyDbManager.kt`, `PlayerDbManager.kt`, `TopicDbManager.kt` - anonymous auth, cached cloud data, snapshot-listener sync, and topic pagination
- `AdsManager.kt`, `AndroidManifest.xml` - ad integration seams and Android platform wiring
- `build.gradle.kts`, `app/build.gradle.kts`, `SETUP.md`, `README.md` - build surface, dependency stack, and the Java-version / feature-description mismatches

## Risks Or Limits

- Public signal is extremely low at selection time: `0` stars.
- The visible verification surface is weak: only template tests and no checked-in CI workflow were found.
- The product is more useful as a direct Android shell reference than as a gameplay or engine baseline.
- The README and setup docs overstate some aspects:
  - "multiplayer" in practice means local social play rather than remote session sync
  - `SETUP.md` still says `Java 8+`, but the current AGP and Google Services path already require Java `11+`
- `GameSession` is a mutable process-global singleton, which is acceptable for this small app but not a strong baseline for larger products.
- The manifest's sample AdMob app ID means the monetization surface should be treated as an integration example, not as production-ready configuration.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `android-game`
- Focus tags: `android`, `ui-hud`, `audio`, `networking`, `save-load`
- Follow-up needed:
  - if the lab revisits this repository, rerun build and selected Android tasks in a Java `11+` plus Android SDK-ready environment with Firebase config present
  - good narrow revisit targets would be the anonymous-auth plus Firestore content model, the fragment-wizard plus `GameSession` ownership seam, or the ad/audio/lifecycle shell rather than reopening the repository as a broad networking baseline
