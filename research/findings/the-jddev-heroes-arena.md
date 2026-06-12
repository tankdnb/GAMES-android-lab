# Research Note

## Repository Snapshot

- Repository: `The-JDdev/Heroes-Arena`
- Source URL: [https://github.com/The-JDdev/Heroes-Arena](https://github.com/The-JDdev/Heroes-Arena)
- Owner: `The-JDdev`
- Batch ID: [`BATCH-2026-06-12-B`](../batches/BATCH-2026-06-12-B.md)
- Type: `android-game`
- License: `MIT`
- Selection date: `2026-06-12`
- Last pushed at selection: `2026-06-11`
- Stars at selection: `0`
- Default branch at selection: `main`
- Investigated commit: `61a4ae8769cc46e4ae1af09d2f0f11c3fde61bf0`
- Research status: `reference-only`
- Build mode: `static-review + missing-windows-gradle-wrapper-script`
- Catalog card: [catalog/projects/the-jddev-heroes-arena.md](../../catalog/projects/the-jddev-heroes-arena.md)

## Why This Repository Was Selected

- `The-JDdev/Heroes-Arena` was the next candidate in the exact-license short backlog.
- The main question for this pass was whether the repository was a real Android MOBA implementation with reusable gameplay/runtime depth, or mainly an aspirational shell.
- The answer is `reference-only`: the repository contains more than a blank UI mockup, including a playable custom-loop `SurfaceView` shell, hero data, item data, and several product screens, but many advertised online/product features are still stubbed or disconnected from the in-match runtime.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: custom Android-native `SurfaceView` game shell plus several standard Android activities
- Rendering stack: Android `SurfaceView`, manual game thread, `Canvas` drawing, XML layouts for menu/product screens
- Android target: direct Android app only
- Build system: single-module Android Gradle project with Groovy DSL, AGP `8.2.2`, Kotlin `1.9.22`, Gradle wrapper metadata `8.5`
- Repository layout summary:
  - `app/src/main/java/com/heroesarena/engine/` - custom loop, rendering, touch handling, and game runtime classes
  - `app/src/main/java/com/heroesarena/models/` - hero, skill, item, profile, and mode data models
  - `app/src/main/java/com/heroesarena/ui/` - splash, menu, hero select, rank, profile, shop, and settings activities
  - `app/src/main/java/com/heroesarena/network/` - online-feature stubs
  - `app/src/main/java/com/heroesarena/audio/` - background music and SFX service scaffold
  - `app/src/main/res/layout/` - menu/product XML screens
- Source footprint:
  - total files counted in repository: `55`
  - Kotlin/Java files counted in repository: `22`
- Test surface:
  - visible automated test files: `0`
- Key modules and files reviewed:
  - `README.md`
  - `build.gradle`
  - `settings.gradle`
  - `app/build.gradle`
  - `gradle.properties`
  - `gradle/wrapper/gradle-wrapper.properties`
  - `app/src/main/AndroidManifest.xml`
  - `app/src/main/java/com/heroesarena/engine/GameEngine.kt`
  - `app/src/main/java/com/heroesarena/engine/GameLoop.kt`
  - `app/src/main/java/com/heroesarena/engine/GameView.kt`
  - `app/src/main/java/com/heroesarena/models/Hero.kt`
  - `app/src/main/java/com/heroesarena/models/Skill.kt`
  - `app/src/main/java/com/heroesarena/models/Item.kt`
  - `app/src/main/java/com/heroesarena/ui/MainActivity.kt`
  - `app/src/main/java/com/heroesarena/ui/HeroSelectActivity.kt`
  - `app/src/main/java/com/heroesarena/ui/GameActivity.kt`
  - `app/src/main/java/com/heroesarena/network/NetworkManager.kt`
  - `app/src/main/java/com/heroesarena/audio/GameMusicService.kt`

## Build And Runtime Notes

- The repository was investigated through static code review only.
- A lightweight Gradle discovery attempt could not be executed in the current Windows lab because the repository checks in `gradlew` but does not include `gradlew.bat`.
- That matters because the checked-in wrapper metadata is present, but the missing Windows launcher means the repo cannot currently be validated through the normal lab workflow on this host without adding an external shell layer.
- The checked-in Android build surface is otherwise straightforward:
  - one `app` module
  - `compileSdk 34`
  - `minSdk 24`
  - Java/Kotlin target `17`
  - light dependency set around AndroidX, Material, RecyclerView, Preference, and Gson

## Usefulness Assessment

- Reuse potential: `2`
- Android transfer: `3`
- Implementation depth: `2`
- Code clarity: `2`
- Novelty: `1`
- Overall verdict: `reference-only`
- Why:
  - the repository is directly Android-native and contains a real custom-loop gameplay shell instead of only menus or screenshots
  - it falls short of `accepted` because the in-match implementation stays simple, no automated tests exist, online features are explicit stubs, and the README overstates the current runtime depth and module structure

## Interesting Findings

### Engine Architecture And Core Loop

- `app/src/main/java/com/heroesarena/engine/GameLoop.kt` is a very direct Android game loop:
  - background thread
  - nanosecond delta calculation
  - `60` FPS target by default
  - simple frame sleep control
  - a delta clamp to avoid large-step physics explosions
- `app/src/main/java/com/heroesarena/engine/GameView.kt` keeps the host shell compact:
  - `SurfaceView` ownership
  - one `GameEngine`
  - one `GameLoop`
  - lock/unlock `Canvas` rendering
  - overlay drawing for joystick, skill buttons, pause, and game-over states
- `app/src/main/java/com/heroesarena/engine/GameEngine.kt` acts as a monolithic runtime owner:
  - map setup
  - hero/minion/tower/base state
  - AI stepping
  - combat
  - camera
  - HUD drawing
  - touch interpretation
- This is reusable mainly as a compact example of a direct Android-native custom-view loop, not as a model for a production-scale MOBA architecture.

### Rendering And Graphics

- `GameEngine.render(...)` uses one large immediate-mode `Canvas` pass for:
  - terrain and lane drawing
  - bases, towers, jungle camps, and minions
  - hero circles plus HP/MP bars
  - skill buttons
  - minimap
  - match HUD
- `GameView.kt` layers a second UI pass on top of the engine render for transient controls such as the joystick and pause/game-over overlays.
- This keeps the visual shell easy to study, but it also confirms the current game is much closer to a readable prototype than to a content-heavy MOBA presentation stack.

### Gameplay Systems

- `GameEngine.startGame(...)` initializes:
  - one player-controlled hero
  - ally AI heroes
  - enemy AI heroes
  - lane towers
  - bases
  - jungle monsters
- `GameEngine.update(...)` adds:
  - timed minion waves
  - nearest-target hero AI
  - simple tower aggro
  - projectile/effect cleanup
  - base-destruction win checks
- `Hero.kt`, `Skill.kt`, and `Item.kt` provide more authored gameplay data than the tiny file count first suggests:
  - `8` defined heroes were found in the current registry file
  - several typed skills per hero
  - a non-trivial item list
- The main limit is integration depth: a lot of authored data exists, but the in-match loop still uses a very compact approximation of movement, combat, and targeting rather than a richer ability or lane-state system.

### Input And Controls

- `GameView.onTouchEvent(...)` splits input cleanly by screen region:
  - left side for joystick-style movement
  - right-side circles for skill taps
- `GameEngine.movePlayer(...)` normalizes movement input before applying hero speed and camera follow.
- This is a practical direct-Android pattern for small `SurfaceView` games, especially if a team wants touch-first controls without importing a larger engine or gesture layer.

### UI, HUD, And Menus

- `MainActivity.kt`, `HeroSelectActivity.kt`, `ProfileActivity.kt`, `RankActivity.kt`, `ShopActivity.kt`, and `SettingsActivity.kt` show a broader product shell than the runtime alone would imply.
- The menu-side app is structured like a mobile game product:
  - splash
  - main hub
  - hero browser/select
  - profile
  - rank
  - shop
  - settings
- That shell is useful as reference material for Android product framing, but much of it is still local-only or mock-data-driven.

### Audio

- `audio/GameMusicService.kt` is mostly service scaffolding:
  - volume management
  - `SoundPool`
  - named SFX constants
  - BGM start/stop actions
- The important caveat is that actual music loading is still commented out, so this is structure-first rather than a finished audio pipeline.

### Networking And Multiplayer

- `network/NetworkManager.kt` explicitly states that online features are unavailable in the current build.
- `login`, `startMatchmaking`, `reportMatchResult`, `getLeaderboard`, and `getPlayerProfile` all return errors through callbacks.
- This is one of the strongest reasons to keep the repository out of `accepted`: the README frames ranked, online, and matchmaking-style features much more aggressively than the checked-in code currently supports.

### Android Platform Integration

- `AndroidManifest.xml` confirms a direct Android-only product shell with:
  - landscape-only activities
  - explicit splash entry activity
  - `WAKE_LOCK`, `VIBRATE`, `INTERNET`, and `ACCESS_NETWORK_STATE`
  - dedicated `GameMusicService`
- This makes the repository more useful than a desktop-only prototype for teams studying Android-native game packaging and activity flow.

### Build, Release, And Testing

- The root build is simple and easy to read, but there is no visible test tree and no checked-in CI workflow was verified in this pass.
- The missing `gradlew.bat` is a real Windows reproducibility problem for this lab workflow.
- README quality is currently weak because the main text contains obvious mojibake/encoding corruption.
- The README also overclaims module structure such as `network`, `audio`, `utils`, `assets`, and broader gameplay scope compared with the actual lightweight runtime and stubbed services.

## Reusable Takeaways

- A compact Android `SurfaceView` game can keep loop, render, HUD, and touch ownership readable if one class intentionally owns the gameplay shell.
- Menu/product-shell activities can still be worth studying even when the in-match runtime is much simpler than the product framing implies.
- Stubbed service layers are still useful to document because they show where future networking and audio seams were intended, even if they are not yet production-ready.

## Evidence Summary

- `GameLoop.kt`, `GameView.kt`, and `GameEngine.kt` prove the repository contains a real custom Android loop and not only menu screens.
- `Hero.kt`, `Skill.kt`, and `Item.kt` show that gameplay content authoring exists beyond the bare minimum.
- `NetworkManager.kt` and `GameMusicService.kt` show that several advertised product features are still structure-only.
- `README.md` and the actual tree together show meaningful drift between marketing claims and the present codebase.

## Risks Or Limits

- The README text has encoding corruption and should not be trusted without checking code.
- Several high-level features are still stubs or mock data:
  - networking
  - leaderboard service
  - profile-from-server flow
  - actual BGM loading
- No automated tests were found.
- The runtime is monolithic and prototype-like, with one large engine class owning most systems directly.
- The repository includes `gradlew` but not `gradlew.bat`, which breaks the normal Windows wrapper path used by this lab.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `reference-only`
- Focus tags: `2d`, `android`, `input`, `ui-hud`, `ai`, `audio`
- Follow-up needed:
  - if the lab revisits this repository, keep it narrow: compare only the direct Android `SurfaceView` loop, the touch-skill overlay pattern, the menu-to-game activity shell, or the gap between advertised online features and actual local runtime support
