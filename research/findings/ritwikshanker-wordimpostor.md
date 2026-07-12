# ritwikshanker/WordImpostor

## Repository Snapshot

- Repository: `ritwikshanker/WordImpostor`
- Source URL: https://github.com/ritwikshanker/WordImpostor
- Owner: `ritwikshanker`
- Batch ID: `BATCH-2026-07-13-A`
- Type: `android-game`
- License: MIT
- Selection date: `2026-07-13`
- Last pushed at selection: `2026-07-12`
- Stars at selection: `1`
- Investigated commit: `46f8b00e39d5150875907fa7f818f22228968e00`
- Research status: `accepted`
- Build mode: `static-review + gradle-version + gradle-help-failed-java8-needs-java17`
- Catalog card: [ritwikshanker-wordimpostor](../../catalog/projects/ritwikshanker-wordimpostor.md)

## Why This Repository Was Selected

- `ritwikshanker/WordImpostor` was the strongest remaining queued explicit-license Kotlin Android game candidate after `BATCH-2026-07-12-B`.
- It is a direct Android Jetpack Compose game with a compact pass-the-phone social-deduction flow, not only a UI animation sample.
- The repository is small enough for a complete static pass while still showing reusable mobile game patterns: phase-state ownership, role reveal privacy, timer handling, voting, settings persistence, and non-intrusive review prompts.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: Android SDK, Jetpack Compose, Material 3, Navigation Compose, AndroidX Lifecycle/ViewModel
- Rendering stack: Compose screens, Material 3 components, `AnimatedVisibility`, `scaleIn`, `fadeIn`, `slideInVertically`
- Android target: single Android app module; `compileSdk = 36`, `minSdk = 26`, `targetSdk = 36`
- Build system: Gradle `9.6.1`, AGP `9.2.1`, Kotlin `2.2.10`, Compose BOM `2025.06.01`
- Repository layout summary: one `:app` module with `data/model`, `data/repository`, `ui/screens`, `ui/navigation`, `ui/viewmodel`, and `review`
- Key modules reviewed:
  - `app/src/main/java/com/deutschdreamers/wordimpostor/data/model/`
  - `app/src/main/java/com/deutschdreamers/wordimpostor/data/repository/`
  - `app/src/main/java/com/deutschdreamers/wordimpostor/ui/viewmodel/GameViewModel.kt`
  - `app/src/main/java/com/deutschdreamers/wordimpostor/ui/screens/`
  - `app/src/main/java/com/deutschdreamers/wordimpostor/review/`
  - `app/build.gradle.kts`
  - `gradle/libs.versions.toml`

## Build And Runtime Notes

- The repository was reviewed static-first. No emulator or runtime launch was attempted.
- `cmd /c gradlew.bat --version` succeeded and reported Gradle `9.6.1`; the lab launcher JVM is Java `1.8.0_321`.
- `cmd /c gradlew.bat help --no-daemon` failed because Gradle requires JVM `17+` while the lab currently exposes Java `8`.
- README says JDK `11+`, but the checked Gradle wrapper now requires Java `17+`.
- The repository has focused unit tests for word-bank invariants and review-gate logic, plus template tests; the core `GameViewModel` phase and voting logic is not visibly unit-tested.

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `3`
- Implementation depth: `2`
- Code clarity: `3`
- Novelty: `2`
- Overall verdict: `accepted`
- Why: the project is a direct Android Compose game with a clear compact state-machine shape, pass-the-phone privacy UX, persistent settings, and a small amount of meaningful test coverage. It is not deep enough to be a major architecture baseline, but it is a useful reference for local party-game flows and Compose-only small-game shells.

## Interesting Findings

### Engine Architecture And Core Loop

- `GameViewModel` owns the whole match state behind `StateFlow<GameState>` rather than distributing phase mutation across screens.
- `GamePhase` is a sealed class with explicit states for setup absence, role reveal, clue round, discussion, voting, elimination reveal, and game end.
- Timer ownership is centralized in the ViewModel through a cancellable coroutine `Job`, which avoids tying clue timers directly to a Composable lifecycle.
- `GameState` keeps `players`, `secretWord`, `currentPhase`, `settings`, `startingPlayerId`, and `roundHistory` together, giving a compact session snapshot for social deduction games.

### Gameplay Systems

- Role assignment randomizes impostors, then chooses a civilian as starting player. That keeps the first clue from immediately being forced through an impostor.
- Clue rounds iterate over active players and skip eliminated players through `findNextActivePlayer`.
- Voting is modeled as voter-to-target choices, then projected into vote counts for UI display.
- Tie handling is configurable with three modes: no elimination, random elimination, or revote.
- Win checks are simple and reusable: civilians win when no impostors remain; impostors win when impostors are at least the number of remaining civilians.
- Round history records clues, votes, and eliminated player id per round, which supports both discussion recall and final summary screens.

### Input And Controls

- `SetupScreen` dynamically grows/shrinks the player-name list based on player count and defaults blank names to `Player N`.
- `ClueRoundScreen` constrains input to one word by truncating on spaces and capping the clue length.
- `VotingScreen` uses separate voter and target selection, with self-voting controlled by settings.
- Pass-the-phone role reveal deliberately separates "tap to reveal role" from "pass the phone" so private information is not shown accidentally to the next player.

### UI, HUD, And Menus

- Navigation Compose routes game phases through typed `Screen` objects, while `MainActivity` reacts to `GamePhase` transitions using `LaunchedEffect` navigation.
- Role, elimination, and game-end screens use Compose animations to highlight dramatic reveal moments without custom rendering code.
- The game uses Material 3 cards, chips, and scaffold surfaces consistently enough to serve as a small-party-game UI baseline.
- Edge-to-edge handling is explicit: `enableEdgeToEdge`, transparent system bar contrast updates, and `safeDrawingPadding` are applied around the app shell.

### Persistence And Data

- `SettingsRepository` persists timer, difficulty, voting behavior, theme, dynamic color, and review prompt tracking in Preferences DataStore.
- Word pools are embedded in `WordRepository` and split by difficulty, making the content pipeline trivial but easy to replace later with localized or remote word packs.
- `ReviewGate` is pure Kotlin decision logic for when to request a Play in-app review, separate from the Android Play Core controller.

### Android Platform Integration

- The app is a direct Android Compose project with no external engine layer.
- The app integrates Google Play In-App Review at the natural "game finished" moment and gates it with local counters/cooldowns.
- Android 15-style edge-to-edge system bar behavior is handled in the Compose root.

### Build, Release, And Testing

- `gradle/libs.versions.toml` centralizes current Android dependencies around AGP `9.2.1`, Kotlin `2.2.10`, Compose BOM `2025.06.01`, Navigation Compose, DataStore, Kotlinx Serialization, and Play Review.
- Release builds enable minification and resource shrinking.
- `WordRepositoryTest` guards that each difficulty returns non-blank and varied words.
- `ReviewGateTest` verifies the first-prompt and cooldown logic without Android dependencies.
- The main missing test surface is `GameViewModel`: phase transitions, tie behavior, timer expiry, eliminated-player skipping, and win conditions are all testable but currently uncovered.

## Reusable Takeaways

- Model small social-deduction games as a sealed phase-state machine plus one lifecycle-aware owner.
- Keep pass-the-phone privacy flows explicit: reveal, hide/pass, then advance.
- Store settings and non-gameplay counters in DataStore, but keep the active in-memory session light until a real resume requirement appears.
- Split pure policy logic, such as review prompting, from Android API callers so it can be tested quickly.
- Treat local word/content repositories as replaceable boundaries even when initial content is hardcoded.

## Evidence Summary

- `data/model/GamePhase.kt`: explicit phase-state model.
- `data/model/GameState.kt`: compact session snapshot and round-history model.
- `data/model/GameSettings.kt`: timer, difficulty, voting, theme, and dynamic-color settings.
- `data/repository/WordRepository.kt`: embedded difficulty word pools.
- `data/repository/SettingsRepository.kt`: DataStore settings and in-app review counters.
- `ui/viewmodel/GameViewModel.kt`: role assignment, clue timers, voting, eliminations, win checks, and reset behavior.
- `ui/screens/RoleRevealScreen.kt`, `ClueRoundScreen.kt`, `VotingScreen.kt`, `DiscussionScreen.kt`, `GameEndScreen.kt`: pass-the-phone, clue, vote, discussion, and summary UI flows.
- `review/ReviewGate.kt`, `ReviewController.kt`: pure review gate plus Play Core adapter.
- `app/build.gradle.kts`, `gradle/libs.versions.toml`: Android/Compose/DataStore/Play Review build stack.

## Risks Or Limits

- README and some source comments/text display mojibake in the Windows terminal, so documentation encoding should be cleaned upstream before relying on it as polished public reference text.
- `GameViewModel` is central and readable but currently lacks visible unit tests for the core phase machine.
- `Player` contains mutable `var` properties even though most updates use `copy`; immutable fields would better match the `StateFlow` state-model style.
- Voting can be finalized before all active players vote; this may be intentional for a party game, but it should be documented or guarded.
- The README JDK requirement is stale relative to the Gradle `9.6.1` Java `17+` floor.

## Catalog Decision

- Keep in main catalog: yes
- Primary category: `android-game`
- Focus tags: `android`, `ui-hud`, `input`, `save-load`, `testing`
- Follow-up needed: optional. If revisited, focus on extracting `GameViewModel` tests for phase transitions, tie behavior, timer expiry, and win conditions rather than reopening the Compose UI broadly.
