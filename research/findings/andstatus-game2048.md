# Research Note

## Repository Snapshot

- Repository: `andstatus/game2048`
- Source URL: [https://github.com/andstatus/game2048](https://github.com/andstatus/game2048)
- Owner: `andstatus`
- Batch ID: [`BATCH-2026-06-04-A`](../batches/BATCH-2026-06-04-A.md)
- Type: `android-game`
- License: `Apache-2.0`
- Selection date: `2026-06-04`
- Last pushed at selection: `2025-11-29`
- Stars at selection: `334`
- Investigated commit: `59f363677fe4559f725b3db5d88fa626e8998070`
- Research status: `accepted`
- Build mode: `static-review + root-gradle-help-failed-java8-needs-java21 + android-project-help-failed-java8-needs-java11`
- Catalog card: [catalog/projects/andstatus-game2048.md](../../catalog/projects/andstatus-game2048.md)

## Why This Repository Was Selected

- From the refreshed license-first shortlist, `andstatus/game2048` had the strongest balance of direct Android relevance, public signal, explicit Apache-2.0 licensing, and likely architecture yield.
- The repository looked more valuable than a typical 2048 clone because it combines a KorGE/Kotlin Multiplatform core with a separate Android shell, AI play modes, long-form move history, share/load, and product-level UX work.
- The main question for this pass was whether it was only a polished puzzle sample or a deeper reusable reference for Android-facing state, persistence, and small-game product architecture. It turned out to be the latter.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: KorGE / Korlibs with a separate Android app module reusing the shared game code
- Rendering stack: KorGE scene/UI rendering with custom board and HUD views layered through a shared Kotlin Multiplatform codebase
- Android target: direct; the repository ships both a root KorGE-based multiplatform project and a dedicated `game2048-android` Android Studio project
- Build system: Gradle Kotlin DSL at the root plus a separate Gradle Android application project under `game2048-android`
- Repository layout summary: root KMP/KorGE game, `src/commonMain` shared gameplay/UI code, `src/androidMain` Android platform glue, extra `doc/` UX notes, and a separate `game2048-android/` app project that reuses the same sources and resources
- Source footprint:
  - total files reviewed in repository: `227`
  - Kotlin/Java files reviewed across the repository: `85`
- Test surface:
  - test files found: `13`
  - meaningful gameplay/persistence/AI tests found: `13`
- Key modules reviewed:
  - `README.md`
  - `build.gradle.kts`
  - `settings.gradle.kts`
  - `gradle/libs.versions.toml`
  - `doc/User-Experience.md`
  - `src/commonMain/kotlin/org/andstatus/game2048/Main.kt`
  - `src/commonMain/kotlin/org/andstatus/game2048/MyContext.kt`
  - `src/commonMain/kotlin/org/andstatus/game2048/MyStorage.kt`
  - `src/commonMain/kotlin/org/andstatus/game2048/model/Board.kt`
  - `src/commonMain/kotlin/org/andstatus/game2048/model/GamePosition.kt`
  - `src/commonMain/kotlin/org/andstatus/game2048/model/GamePlies.kt`
  - `src/commonMain/kotlin/org/andstatus/game2048/model/History.kt`
  - `src/commonMain/kotlin/org/andstatus/game2048/model/Model.kt`
  - `src/commonMain/kotlin/org/andstatus/game2048/model/ShortRecord.kt`
  - `src/commonMain/kotlin/org/andstatus/game2048/model/PliesPageData.kt`
  - `src/commonMain/kotlin/org/andstatus/game2048/presenter/Presenter.kt`
  - `src/commonMain/kotlin/org/andstatus/game2048/presenter/PresenterAsync.kt`
  - `src/commonMain/kotlin/org/andstatus/game2048/ai/AiPlayer.kt`
  - `src/commonMain/kotlin/org/andstatus/game2048/view/ViewData.kt`
  - `src/commonMain/kotlin/org/andstatus/game2048/view/MainView.kt`
  - `src/commonMain/kotlin/org/andstatus/game2048/view/BoardView.kt`
  - `src/androidMain/kotlin/org/andstatus/game2048/PlatformUtilAndroid.kt`
  - `src/androidMain/kotlin/org/andstatus/game2048/MyMainActivity.kt`
  - `src/androidMain/kotlin/org/andstatus/game2048/data/FileProvider.kt`
  - `game2048-android/build.gradle`
  - `src/commonTest/kotlin/PersistenceTest.kt`
  - `src/commonTest/kotlin/AiPlayerTest.kt`
  - `src/commonTest/kotlin/MovesTest.kt`
  - `src/commonTest/kotlin/HistoryTest.kt`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeds and reports Gradle `8.14` on a Java `8` launcher.
- `cmd /c gradlew.bat help --no-daemon` at the repository root fails because the current lab machine is still on Java `8`, while the resolved KorGE plugin chain now needs Java `21`:
  - dependency resolution reports that `com.soywiz.korlibs.korge.plugins:korge-gradle-plugin-settings:6.0.0` requires at least JVM runtime `21`
- `cmd /c gradlew.bat -p game2048-android help --no-daemon` also fails under the same machine because the inspected Android Gradle Plugin stack already needs Java `11+`.
- The build floors are expected from the checked-in configuration:
  - the root project resolves modern KorGE tooling
  - `game2048-android/build.gradle` uses Android Gradle Plugin `8.13.1`, Kotlin plugin `2.2.0`, `compileSdk 36`, `targetSdk 36`, and Java target `21`
- No runtime launch was attempted.
- One important documentation caveat was confirmed: the root `README.md` still describes some setup/build expectations in `Java 8 or greater` terms, but the inspected current build no longer matches that floor.

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `3`
- Implementation depth: `3`
- Code clarity: `3`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - `game2048` is a much stronger small-game product reference than its simple genre suggests.
  - It shows how to turn a tiny puzzle core into a durable Android-facing product through history management, AI modes, flexible board sizing, sharing/loading, and platform-specific shell work.
  - The repository is also unusually reusable because the gameplay state, orchestration, persistence, and Android glue are split clearly enough to study in isolation.

## Interesting Findings

### Engine Architecture And Core Loop

- `src/commonMain/kotlin/org/andstatus/game2048/Main.kt` computes an aspect-aware virtual board size before starting the KorGE scene. That keeps board proportions stable across different host window or device sizes instead of hardcoding one layout.
- `src/commonMain/kotlin/org/andstatus/game2048/view/ViewData.kt` shows a staged async bootstrap path: splash first, then strings, fonts, settings, history, theme, and only then the main presenter and views. That is a good product-shell pattern for small Android games that still need real startup work.
- `src/commonMain/kotlin/org/andstatus/game2048/presenter/Presenter.kt` is the central orchestrator, while `Model.kt`, `History.kt`, and the view layer keep their concerns narrower. The result is a product architecture that feels more like a small app than like a toy one-file game loop.
- `src/commonMain/kotlin/org/andstatus/game2048/presenter/PresenterAsync.kt` keeps slower AI and autoplay loops separated from the main presenter logic, but still lets shared counters and position checks guard against stale async results.

### Rendering And Graphics

- `Main.kt`, `ViewData.kt`, and the shared view layer build around responsive sizing instead of assuming one fixed board shape. That matters for an Android puzzle product more than flashy graphics do.
- `src/commonMain/kotlin/org/andstatus/game2048/view/BoardView.kt` uses a transparent `controlsArea` over the board to capture swipes and keyboard-like direction input without coupling gesture handling directly to tile drawing.
- `src/commonMain/kotlin/org/andstatus/game2048/view/MainView.kt` stays relatively thin and mostly assembles board, score, status, and control pieces. That keeps presentation wiring visible without burying it inside gameplay state classes.

### Gameplay Systems

- `src/commonMain/kotlin/org/andstatus/game2048/model/Board.kt` precomputes directional traversal and neighbor links for every square. Instead of recalculating scan order for every move, the puzzle runtime can reuse that topology directly.
- `src/commonMain/kotlin/org/andstatus/game2048/model/GamePosition.kt` is the core reference point for board state. It tracks pieces, score, retries, clock, ply number, and move application/reversal. The reversible move model is one of the strongest reusable ideas in the repository.
- `GamePosition.userPly()` records explicit `PieceMove` data instead of only mutating board state. That decision makes deterministic replay, undo/redo, bookmarks, and watched replays much easier to support later.
- `src/commonMain/kotlin/org/andstatus/game2048/model/History.kt` separates current game state, recent games, best score, redo pointer, and mode. This is a good example of treating history as a first-class product feature instead of as a debug-only convenience.
- `src/commonMain/kotlin/org/andstatus/game2048/model/GamePlies.kt` and `ShortRecord.kt` show how long-running game sessions can keep a durable move log plus lightweight summary records without inflating the whole live model.
- `src/commonMain/kotlin/org/andstatus/game2048/ai/AiPlayer.kt` goes beyond a single hint algorithm. The repository includes random, one-move, multi-move, score-oriented, and longest-random-play heuristics, which is useful for future hint/autoplay design work in other puzzle games.

### Input And Controls

- `BoardView.kt` supports swipe input, keyboard-like directional flow, and duplicate-key suppression in one place instead of scattering device-specific checks across gameplay logic.
- The repository treats user play, AI tips, AI autoplay, watch mode, and replay stepping as related but distinct control modes. That is more reusable than a single `if aiEnabled` toggle buried inside one update loop.
- Shared control semantics are pushed through the presenter/model boundary, so Android-specific input hosting stays outside the puzzle rules themselves.

### UI, HUD, And Menus

- `doc/User-Experience.md` is a useful signal that the repository treats UX as something intentional and documented. The game is not only code-complete; it is product-shaped.
- `MainView.kt`, the history model, and the presenter together support recent games, bookmarks, board-size changes, theme changes, AI mode toggles, and replay/watching controls inside one coherent shell.
- The repository is a good reminder that small games often benefit more from polished stateful UI and recovery flows than from more rendering complexity.

### Android Platform Integration

- `src/androidMain/kotlin/org/andstatus/game2048/MyMainActivity.kt` replaces the default KorGE-generated activity so the project can restore fullscreen preferences, keep the screen awake, recreate more safely around orientation or resume events, and integrate Android document-picker handling.
- `PlatformUtilAndroid.kt` isolates platform-specific concerns such as dark theme detection, actual screen size, share intents, open-document flow, and app exit. That keeps Android behavior explicit without leaking it across shared gameplay code.
- `src/androidMain/kotlin/org/andstatus/game2048/data/FileProvider.kt` is a custom cache-backed `ContentProvider` for shared game files. That is a concrete reusable pattern for Android share/export flows in small games.
- `game2048-android/build.gradle` shows a strong Android-specific packaging move: the repository keeps a separate Android Studio project that reuses `../src/commonMain` and `../src/androidMain` rather than forcing all Android iteration through the root KorGE project.

### Performance And Memory

- `Board.kt` avoids repeated neighbor/traversal recomputation by building directional links once.
- `PliesPageData.kt` keeps only a small bounded number of move-history pages in memory with `maxPagesStored = 5`, then spills the rest to storage. That is a very practical pattern for mobile-friendly long-session history.
- `PresenterAsync.kt` deliberately checks whether the game position and click counters still match before applying background AI results. That is a simple but important stale-work guard for small-game coroutine flows.
- `History.kt` saves current state asynchronously and prunes older records by age or score range, which helps history stay useful without growing forever.

### Build, Release, And Testing

- The repository has a meaningful test surface for a puzzle game of this size: persistence, move logic, AI, history behavior, paging, retries, and parsing all have direct test files.
- The split between the root KorGE build and the separate `game2048-android` project is valuable in itself. It shows one way to keep a shared KMP game core while still preserving a normal Android Studio app surface.
- The checked-in build surface is more modern than the README suggests. That mismatch is worth documenting because future lab work should trust the actual Gradle configuration over stale prose.
- No meaningful CI workflows were present in the inspected tree, so the repository is strong as a code/product reference but weaker as a release-automation reference than some other catalog entries.

## Reusable Takeaways

- A small Android puzzle game becomes much more reusable as a reference when move history is reversible, serializable, and paged instead of being only an in-memory undo stack.
- Splitting `Presenter`, `Model`, `History`, and Android platform glue makes product evolution easier than hiding everything inside one scene/controller.
- Separate hint logic and autoplay logic are worth modeling explicitly. They have different UX and correctness needs even when they share the same underlying search code.
- A dedicated Android app module can still be worthwhile even when the gameplay core is shared through Kotlin Multiplatform, especially when platform-specific activity, sharing, or document flows matter.

## Evidence Summary

- `Main.kt`, `ViewData.kt`, `MainView.kt` - aspect-aware KorGE shell and staged bootstrap into the playable UI
- `Presenter.kt`, `PresenterAsync.kt` - orchestration split between main-state flow and background AI/autoplay work
- `Board.kt`, `GamePosition.kt`, `Model.kt` - reversible puzzle logic, board traversal structure, and domain state
- `History.kt`, `GamePlies.kt`, `PliesPageData.kt`, `ShortRecord.kt` - current/recent game management, paged history, summaries, and shareable records
- `AiPlayer.kt` - several AI hint/autoplay strategies
- `BoardView.kt` - swipe/input layer and board-local interaction shell
- `PlatformUtilAndroid.kt`, `MyMainActivity.kt`, `FileProvider.kt` - Android platform host, share/load flow, and activity replacement
- `game2048-android/build.gradle` - separate Android app project reusing shared sources/resources
- `PersistenceTest.kt`, `MovesTest.kt`, `AiPlayerTest.kt`, `HistoryTest.kt` - meaningful gameplay and persistence verification

## Risks Or Limits

- The project is still domain-specific: its strongest patterns transfer to puzzle or turn-step games more directly than to action-heavy real-time games.
- The root `README.md` is partially stale about build prerequisites; future work should trust the inspected Gradle configuration instead.
- Full local build verification in the lab is still blocked by the machine's Java `8` runtime and the lack of a ready Android SDK path for real Android task execution.
- The repository is product-rich, but it does not show much release automation or CI discipline compared with the stronger workflow-oriented engine references already in the lab.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `android-game`
- Focus tags: `2d`, `android`, `multiplatform`, `korge`, `input`, `save-load`, `ai`, `testing`
- Follow-up needed:
  - if the lab revisits this repository, rerun both root and `game2048-android` Gradle discovery in a Java `21` plus Android SDK-ready environment
  - a good scoped revisit target would be the reversible ply/history pipeline, the AI hint vs autoplay split, or the Android share/load shell instead of reopening the whole codebase broadly
