# neumannhans326-crypto/license-plate-game

## Repository Snapshot

- Repository: `neumannhans326-crypto/license-plate-game`
- Source URL: https://github.com/neumannhans326-crypto/license-plate-game
- Owner: `neumannhans326-crypto`
- Batch ID: `BATCH-2026-07-18-A`
- Type: `android-game`
- License: MIT
- Selection date: `2026-07-18`
- Last pushed at selection: `2026-07-10`
- Stars at selection: `3`
- Investigated commit: `37084ab1f5f843c9b4041de264652cbec20d22b1`
- Research status: `reference-only`
- Build mode: `static-review + missing-gradle-wrapper + gradle-unavailable-local`
- Catalog card: [neumannhans326-crypto-license-plate-game](../../catalog/projects/neumannhans326-crypto-license-plate-game.md)

## Why This Repository Was Selected

- `neumannhans326-crypto/license-plate-game` was the remaining queued explicit-license Kotlin Android game candidate after `BATCH-2026-07-13-A`.
- It is a direct Android car-trip game, not only a UI demo: players spot German license plates and receive points based on rarity.
- The repo has an unusual real-world content hook for a small mobile game: offline vehicle-registration data, duplicate detection, and local multiplayer scoring.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: Android SDK, Jetpack Compose, Material 3, AndroidX Lifecycle/ViewModel, Room, coroutines
- Rendering stack: Compose screens and Material components; no external engine or custom drawing layer
- Android target: single Android app module under `license-plate-app/app`, `compileSdk = 34`, `minSdk = 24`, `targetSdk = 34`
- Build system: Gradle Kotlin DSL with Android Gradle Plugin `8.4.0`, Kotlin `1.9.22`, Java/Kotlin target `17`
- Repository layout summary: small root with MIT license, README, and one nested Android app project
- Key modules reviewed:
  - `license-plate-app/app/src/main/java/com/kennzeichen/app/MainActivity.kt`
  - `license-plate-app/app/src/main/java/com/kennzeichen/app/KennzeichenApplication.kt`
  - `license-plate-app/app/src/main/java/com/kennzeichen/app/data/database/`
  - `license-plate-app/app/src/main/java/com/kennzeichen/app/data/repository/`
  - `license-plate-app/app/src/main/java/com/kennzeichen/app/ui/screen/`
  - `license-plate-app/app/src/main/java/com/kennzeichen/app/ui/component/`
  - `license-plate-app/app/src/main/assets/kennzeichen.csv`
  - `license-plate-app/app/build.gradle.kts`

## Build And Runtime Notes

- The repository was reviewed static-first. No emulator or runtime launch was attempted.
- The checked-in project does not include `gradlew`, `gradlew.bat`, or `gradle/wrapper/gradle-wrapper.jar`, while the README documents `./gradlew assembleDebug`.
- The lab environment also has no system `gradle` command available, so Gradle configuration, compilation, and tests could not be run locally.
- Static review found no visible test files despite declared JUnit and Android test dependencies.
- Static review also found likely compile/import issues, including missing Compose/lifecycle imports in `MainActivity.kt`, missing imports or modifier usage in `PlayerNameInput.kt`, a nonstandard `Material3` wrapper call, a likely unavailable `Icons.Default.Wikipedia` symbol, and a Room/Flow nullability mismatch around total points. These were not build-confirmed because the repo has no reproducible wrapper in this lab.

## Usefulness Assessment

- Reuse potential: `2`
- Android transfer: `3`
- Implementation depth: `1`
- Code clarity: `1`
- Novelty: `2`
- Overall verdict: `reference-only`
- Why: the game concept is directly Android-relevant and preserves useful patterns around real-world scoring data, offline seed loading, duplicate detection, and local player scoreboards. It is kept as a comparison and idea reference rather than an accepted architecture baseline because the checked-in project is small, untested, not locally reproducible through its README build command, and appears to contain source maturity issues.

## Interesting Findings

### Engine Architecture And Core Loop

- `MainActivity.kt` acts as the app shell and manually routes between player setup, player selection, keyboard input, and scan-result dialog screens through Compose `MutableState` flags.
- `MainViewModel.kt` owns the active player, input text, player list, and `ScanResult` state. This is a small but reusable shape for non-real-time turn/entry games where the "loop" is user input plus result feedback rather than a frame tick.
- `KennzeichenApplication.kt` creates a Room database eagerly in `Application.onCreate`, while `AppDatabase.getDatabase()` also exposes a singleton builder. The idea is simple manual DI, but the duplicate construction paths should be cleaned before reuse.

### Gameplay Systems

- `MainViewModel.onKennzeichenInput()` normalizes input to uppercase, rejects blanks, checks whether the plate was already scanned, looks up plate metadata, scores the result, records the scan, marks the plate as found, and increments the active player's points.
- Duplicate detection is intentionally non-penalizing: already scanned plates produce an `AlreadyScanned` result with the original player and scan time.
- `KennzeichenRepository.calculatePunkte()` turns vehicle-count rarity into a small point ladder and special-cases the `BUS` prefix, plus the umlaut variant visible in source data, as a 100-point plate.
- `KennzeichenRepository.getKennzeichenInfo()` formats a simple educational info string for the result dialog.

### Input And Controls

- `KennzeichenInputScreen.kt` uses a custom capital-letter keyboard tailored for German license plate prefixes, including umlaut rows and wide backspace/enter controls.
- Input is capped to six characters and filtered through a letter regex before submission. The idea is good for child-friendly constrained-entry game UIs, although the inspected source shows encoding artifacts around umlaut characters.
- `PlayerSetupViewModel.kt` caps local player setup at six names and keeps setup state in a `StateFlow`, which is a compact pattern for one-device local multiplayer.

### UI, HUD, And Menus

- `PlayerSelectionScreen.kt` doubles as a standby scoreboard: each player row shows name and current points, and tapping a player starts that player's plate entry flow.
- `ScanResultDialog.kt` separates success, duplicate, and not-found outcomes. Success shows the plate code, awarded points, info text, and a Wikipedia action.
- The app uses standard Material 3 cards, buttons, and dialogs rather than custom rendering, making it a useful reference for "game as mobile product shell" patterns.

### Persistence And Data

- `AppDatabase.kt` defines Room tables for license-plate metadata, players, and scanned plates.
- `DataLoader.kt` reads `assets/kennzeichen.csv`, parses semicolon-delimited rows, maps headers to `KennzeichenEntity`, and seeds the Room database on first launch.
- The CSV asset has 91 lines in the inspected checkout: one header plus 90 data rows, matching the README's "90 license plates" claim.
- `ScannedRepository.kt` stores each scan with `kennzeichen`, `playerId`, `punkte`, and `LocalDateTime` timestamp, which enables duplicate feedback and per-player history.
- `PlayerRepository.kt` keeps the player score as mutable Room state through `addPoints()` and `setPoints()`.

### Android Platform Integration

- `AndroidManifest.xml` registers `KennzeichenApplication`, a single launcher `MainActivity`, and internet/network-state permissions for the external Wikipedia action.
- `MainActivity.kt` opens `https://de.wikipedia.org/wiki/<city>` through `Intent.ACTION_VIEW` after a successful scan.
- The project uses `enableEdgeToEdge()`, Compose `setContent`, and Activity `viewModels`, keeping the Android shell small.

### Build, Release, And Testing

- `license-plate-app/app/build.gradle.kts` uses AGP `8.4.0`, Kotlin Android `1.9.22`, Compose compiler extension `1.5.11`, Room `2.6.1`, Material 3, lifecycle `ViewModel`, coroutines, and CSV serialization.
- Java and Kotlin targets are set to `17`.
- No Gradle wrapper, CI, release workflow, or visible tests were found.
- Static source review shows multiple likely compile/import problems, so the project should be treated as a concept/reference until a build is verified upstream.

## Reusable Takeaways

- Real-world public datasets can become lightweight mobile game mechanics when scoring is derived from rarity or frequency.
- Offline-first seed data plus Room is a practical pattern for car-trip, travel, trivia, scavenger-hunt, and collection games.
- Duplicate detection can be designed as feedback rather than punishment in family/local multiplayer games.
- A custom constrained keyboard can make fast in-car or child-facing input easier than relying on the system keyboard.
- For production reuse, separate pure scoring/duplicate rules from Android `ViewModel` and Room so they can be unit-tested without an emulator.

## Evidence Summary

- `README.md`: project concept, features, tech stack, and license claim.
- `LICENSE`: MIT license text.
- `license-plate-app/app/build.gradle.kts`: Android, Compose, Room, coroutine, Java target, and dependency surface.
- `license-plate-app/app/src/main/assets/kennzeichen.csv`: semicolon-delimited offline plate dataset with 90 data rows.
- `data/database/AppDatabase.kt`, `KennzeichenEntity.kt`, `PlayerEntity.kt`, `ScannedKennzeichenEntity.kt`: Room schema.
- `data/repository/DataLoader.kt`: CSV asset loader and entity mapper.
- `data/repository/KennzeichenRepository.kt`: plate lookup helpers and rarity scoring.
- `data/repository/ScannedRepository.kt`: duplicate detection and scan history.
- `data/repository/PlayerRepository.kt`: player creation and point updates.
- `ui/screen/MainViewModel.kt`: scan flow, duplicate branch, success branch, score updates, and result state.
- `ui/screen/KennzeichenInputScreen.kt`: constrained license-plate keyboard.
- `ui/screen/PlayerSelectionScreen.kt`, `PlayerSetupScreen.kt`, `ScanResultDialog.kt`: local multiplayer setup, scoreboard, and result feedback.

## Risks Or Limits

- The repository has no checked-in Gradle wrapper and no system Gradle was available in the lab, so build claims were not locally validated.
- No meaningful automated tests were found.
- The source and README display mojibake in the Windows terminal for German umlauts, punctuation, and emoji-like text; this affects both data parsing confidence and UI polish.
- Several likely compile issues are visible from static review, including unresolved imports or APIs around Compose material/theme, lifecycle collection, modifier focus handling, icons, and a `Flow<Int?>` versus `Flow<Int>` total-points path.
- `DataLoader.kt` catches all parsing exceptions per row and silently drops invalid rows, which can hide dataset corruption.
- Room schema uses `LocalDateTime` in `ScannedKennzeichenEntity`; reuse should verify or add type converters in the actual target stack before copying.
- Manual dependency creation is simple but duplicated between `KennzeichenApplication` and `AppDatabase.getDatabase()`.

## Catalog Decision

- Keep in main catalog: yes, as `reference-only`
- Primary category: `reference-only`
- Focus tags: `android`, `ui-hud`, `input`, `save-load`
- Follow-up needed: optional. If revisited, first verify a build in a proper Java `17+` Android environment or upstream wrapper, then isolate the scoring/duplicate rules and CSV-to-Room seed loader for tests instead of reopening the whole UI broadly.
