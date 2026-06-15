# amirroid/mafiauto

- Repository: [amirroid/mafiauto](https://github.com/amirroid/mafiauto)
- Repository type: `gameplay-systems`
- Final status: `accepted`
- Reviewed on: `2026-06-15`
- License: `MIT`
- Stars at review: `13`
- Last pushed at review: `2026-06-14`
- Default branch: `main`
- Investigated commit: `5c22630945be3046d275f8869de7f8ff3d2850d4`
- Build mode: `static-review + gradle-version + gradle-help-failed-java8-needs-java17`

## What This Repository Is

`Mafiauto` is a Kotlin Multiplatform product for running and assisting Mafia party games across Android, desktop, and iOS hosts.

The checked-in tree is more substantial than a single-screen helper app:

- Android, desktop, and iOS entry points are present
- a dedicated `game:engine` module owns the actual Mafia rules runtime
- `core:data`, `core:domain`, and `feature:*` modules wrap the engine in a clean product shell
- SQLDelight, preferences, update-checking, and navigation layers are separated from the rules core
- common tests cover the engine's phase flow and several role interactions

## Why It Is Interesting For The Lab

- It is a strong example of a non-arcade game project where the reusable value is the rules engine and state machine, not rendering tricks.
- The repository shows how to keep a party game's turn-flow logic in a shared Kotlin core while letting Android and other hosts remain thin.
- It preserves practical patterns for phase transitions, role resolution order, delayed actions, and UI-to-engine mapping that are useful well beyond Mafia itself.

## Architecture Snapshot

### 1. Shared product shell around a dedicated rules engine

- `settings.gradle.kts` shows a large but readable KMP split: `composeApp`, `androidApp`, `game:engine`, `core:*`, `shared:*`, and `feature:*`.
- `androidApp` is thin and depends on `composeApp`, while `composeApp` pulls in navigation, DI, domain, and UI models.
- This is a useful reminder that even a game-adjacent Android product can stay modular without introducing a heavyweight external engine.

### 2. `GameEngine` as a real phase-state runtime

- `game/engine/src/commonMain/.../GameEngine.kt` is the main research value.
- The engine owns phase, current day, players, scheduled actions, last cards, status checks, current speaker turn, logs, and message events through `StateFlow` plus a buffered message `Channel`.
- `Phase` is a sealed interface with explicit runtime states such as `Day`, `Voting`, `Defending`, `LastCard`, `Fate`, `Night`, `Result`, `FinalDebate`, and `End`.
- This gives the repo a clear game-state-machine shape instead of scattering flow logic across view models or screens.

### 3. Ordered night-action resolution with delayed execution

- `handleNightActions()` converts submitted actions into `ScheduledAction` records and stores them by execution day.
- `proceedToResultPhase()` pulls the actions scheduled for the current day, applies them in submit-order, resets one-shot ability flags, and calculates a summarized night result.
- Role actions in `game/engine/actions/role/Actions.kt` encode kill, doctor save, surgeon save, sniper shot, silencing, mafia conversion, gun granting, and reactive ranger behavior as isolated action objects.
- This is a reusable pattern for any turn-based game that needs delayed or priority-ordered resolution without embedding logic directly in UI code.

### 4. Role model as capability descriptors

- `game/engine/role/Role.kt` models each role as a capability object with alignment, execution order, target rules, optional instant actions, win conditions, and kill hooks.
- `RolesProviderImpl` acts as the static catalog for all supported roles.
- The role model is a good reference for games where entities need behavior-level configuration without building a full data-driven scripting system first.

### 5. Domain/data layer shields the UI from engine internals

- `core/domain/usecase/game/HandleNightActionsUseCase.kt` and the neighboring use cases expose the engine as application commands rather than direct screen-to-engine coupling.
- `core/data/repository/game/GameRepositoryImpl.kt` maps between domain models and engine models, resolves roles, and exposes engine flows to the app layer.
- This seam is especially reusable for Android work: gameplay rules stay testable and portable, while UI state and persistence stay replaceable.

### 6. View models adapt engine phases into feature-specific UI state

- `feature/room/.../GameRoomViewModel.kt` observes current phase, current day, current turn, players, and last cards, then coordinates defense votes, kick flow, last-card application, and day actions.
- `feature/night/.../NightActionsViewModel.kt` gathers target selections per acting player, supports instant reveal actions, and submits normalized night actions back into the domain layer.
- The useful idea is not the exact UI, but the way feature view models translate one shared game-state machine into screen-local interaction steps.

## Reusable Technical Ideas

- sealed phase model for party-game or turn-based state machines
- `StateFlow`-owned gameplay runtime with a buffered message channel for transient game events
- ordered role resolution using scheduled actions instead of direct mutation during selection
- capability-object role definitions with win rules, targeting rules, and kill hooks
- repository/use-case seam between shared rules engine and Android or Compose UI layers
- feature view models that adapt one shared runtime into screen-specific flows
- integrated game logs as a first-class runtime output instead of an afterthought

## Android Relevance

Android relevance is **direct**.

Why it matters:

- the repository includes a real Android app host
- the game rules engine is shared and portable, which is useful for Android-first products that may later add desktop or iOS hosts
- the app shows how to wrap a rules-heavy gameplay core in a modern Compose/KMP modular product shell

Why it is not mainly a rendering reference:

- the strongest reusable value is in flow control, role logic, and state ownership
- this is closer to a game-rules architecture sample than to a graphics or engine-rendering baseline

## Build And Verification Notes

- `cmd /c gradlew.bat --version` succeeds and reports Gradle `9.5.1`.
- `cmd /c gradlew.bat help --no-daemon` fails in the lab because Gradle now requires Java `17+` while the current machine still exposes Java `8`.
- The repository surface is large for a party-game assistant: about `524` files, roughly `436` Kotlin/Gradle/Java/Swift source files, and at least `3` checked-in engine test files.
- The build stack is current: Kotlin `2.4.0`, Compose `1.9.3`, AGP `9.2.1`, SQLDelight `2.3.2`, Ktor `3.5.0`, and Koin `4.2.1`.

## Risks And Caveats

- The README encoding is currently broken in the checked-in file, so public-facing docs look rough even though the codebase is structured.
- The rules engine is specialized to Mafia and related variants; reuse is architectural rather than plug-and-play for unrelated genres.
- `core/preferences` uses a persistent package typo namespace `ir.amirroid.mafiauot.*`; it is internally consistent, but it is still a maintenance smell worth noting.
- The project is broad and product-oriented, so extracting only the reusable engine ideas takes more effort than with a tiny demo.

## Verdict

Keep `amirroid/mafiauto` as `accepted`.

It is a strong `gameplay-systems` reference for the lab because it preserves a serious Kotlin rules engine, explicit phase-state ownership, delayed action resolution, clean domain wrapping, and direct Android product relevance without collapsing everything into one UI layer.
