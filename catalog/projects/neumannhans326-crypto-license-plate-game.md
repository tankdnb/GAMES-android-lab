# License Plate Game

## Basic Info

- Project name: License Plate Game
- Source repository: https://github.com/neumannhans326-crypto/license-plate-game
- Author / organization: `neumannhans326-crypto`
- License: MIT
- Research note: [research/findings/neumannhans326-crypto-license-plate-game.md](../../research/findings/neumannhans326-crypto-license-plate-game.md)
- Investigated commit: `37084ab1f5f843c9b4041de264652cbec20d22b1`
- Last verified: `2026-07-18`
- Activity / maintenance status: created `2026-07-07`, last pushed `2026-07-10`, not archived, 3 stars at selection.

## Short Description

`License Plate Game` is a small Android car-trip game where kids collect German license plate prefixes, earn points based on rarity, and compare scores on a local one-device scoreboard.

## Technical Profile

- Primary category: `reference-only`
- Focus tags: `android`, `ui-hud`, `input`, `save-load`
- Engine / framework: Android SDK, Jetpack Compose, Material 3, AndroidX Lifecycle/ViewModel, Room, coroutines
- Rendering approach: Compose screens, Material cards/buttons/dialogs, no custom game renderer
- Main language(s): Kotlin
- Android target: direct Android app, `compileSdk = 34`, `minSdk = 24`, `targetSdk = 34`
- Build system: Gradle Kotlin DSL with AGP `8.4.0`, Kotlin `1.9.22`, Java/Kotlin target `17`; no checked-in Gradle wrapper found

## Why It Matters

- It shows how a simple real-world observation game can be turned into a reusable Android game loop: constrained input, lookup, score, feedback, and local scoreboard.
- Its most useful idea is dataset-backed scoring: common plates are worth less, rarer plates are worth more, and a special prefix is worth a jackpot score.
- It is valuable as an idea/reference card, but not as a strong architecture baseline because the checked-in source appears immature and was not locally buildable in the lab.

## Reusable Ideas

- Gameplay ideas: car-trip scavenger hunt, rarity-based points, duplicate-as-feedback rather than duplicate-as-penalty, one-device local multiplayer.
- Architecture patterns: Room tables for content, players, and scan history; a `ViewModel`-owned entry/result flow; small repositories around each data concern.
- Input / UI approaches: custom capital-letter keyboard for quick constrained entry, standby player scoreboard, success/duplicate/not-found result dialog.
- Persistence ideas: seed an offline dataset from assets into Room on first launch, then store session discoveries and player scores locally.
- Testing ideas: extract the scoring ladder, duplicate rules, and CSV parsing into pure Kotlin seams before production reuse.

## Notable Implementations

- `MainViewModel.onKennzeichenInput()` handles the scan flow: normalize input, reject duplicates, look up metadata, calculate score, persist scan, mark plate as found, and add player points.
- `KennzeichenRepository.calculatePunkte()` converts vehicle-count rarity into a point ladder and special-cases `BUS`, plus the umlaut variant visible in source data.
- `DataLoader.kt` loads semicolon-delimited `kennzeichen.csv` from Android assets and maps rows into Room entities.
- `ScannedRepository.kt` keeps scanned plate history with player id, points, and timestamp for duplicate feedback.
- `KennzeichenInputScreen.kt` implements a domain-specific on-screen keyboard for fast license-prefix entry.

## Android Relevance

- Native Android use: direct Android app with Compose, Room, Activity `viewModels`, `enableEdgeToEdge()`, and external `Intent.ACTION_VIEW` links.
- Kotlin relevance: Kotlin-first Android codebase with coroutines, flows, data classes, and Room DAOs.
- Porting or adaptation notes: reuse the concept and data/scoring flow, but first verify build health, clean encoding, add type converters if needed, and extract testable domain rules.

## Risks / Limitations

- Classified as `reference-only` because no Gradle wrapper, CI, runtime validation, or real tests were found.
- The lab could not run Gradle because the repository has no wrapper and no system `gradle` command is installed.
- Static review shows likely compile/import issues in the Compose and Room integration, including a total-points nullability mismatch and `LocalDateTime` persistence that needs converter verification.
- README and source text display mojibake in the Windows terminal.
- The CSV loader silently drops rows on parse exceptions, which can hide data issues.

## Notes

Best reuse target: the game premise and data-backed scoring loop. Treat the current implementation as a sketch to study, not code to copy directly into a production Android game.
