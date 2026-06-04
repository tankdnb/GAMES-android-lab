# Research Note

## Repository Snapshot

- Repository: `tottelofstrom/NFC-DOOM`
- Source URL: [https://github.com/tottelofstrom/NFC-DOOM](https://github.com/tottelofstrom/NFC-DOOM)
- Owner: `tottelofstrom`
- Batch ID: [`BATCH-2026-06-04-AE`](../batches/BATCH-2026-06-04-AE.md)
- Type: `android-game`
- License: `MIT`
- Selection date: `2026-06-04`
- Last pushed at selection: `2026-06-03`
- Stars at selection: `0`
- Default branch at selection: `main`
- Investigated commit: `22ae1d60186712e8a11fb90ec5386a3fed69e492`
- Research status: `accepted`
- Build mode: `static-review + gradle-help-failed-no-jdk`
- Catalog card: [catalog/projects/tottelofstrom-nfc-doom.md](../../catalog/projects/tottelofstrom-nfc-doom.md)

## Why This Repository Was Selected

- `NFC-DOOM` was the last remaining candidate in the exact-license shortlist.
- The main question for this batch was whether the repository is only a novelty Android experiment or whether it is a real reusable reference for Kotlin game work around software raycasting, tiny content formats, and NFC-driven gameplay bootstrapping.
- The answer is `accepted`: the repository is small and fresh, but it contains a real Android-native stack with a pure gameplay core, a disciplined cartridge codec, robust `NfcV` fallback paths, and a practical Compose-hosted pseudo-3D renderer.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: Android SDK + Jetpack Compose + Android NFC / `NfcV` + pure Kotlin gameplay core
- Rendering stack: low-resolution offscreen software raycaster rendered into an `ImageBitmap`, then upscaled through Compose `Canvas` with nearest-neighbor filtering; bundled Freedoom-derived PNG art provides walls, sprites, weapon, and HUD
- Android target: direct Android app module with `minSdk 26`, `targetSdk 35`, and `compileSdk 35`
- Build system: Gradle `8.9` wrapper + AGP `8.7.2` + Kotlin `2.0.21` + Compose plugin + Java target `17`
- Repository layout summary:
  - `app/` - Android app, Compose UI, pure gameplay core, cartridge codec, and NFC read/write stack
  - `docs/` - binary cartridge-format reference
  - `app/src/main/assets/doomgfx/` - bundled Freedoom-derived art library and attribution
- Source footprint:
  - total files counted in repository: `119`
  - Kotlin, Gradle Kotlin DSL, and Java files counted in repository: `36`
  - test files counted in repository: `4`
- Key modules reviewed:
  - `README.md`
  - `settings.gradle.kts`
  - `build.gradle.kts`
  - `app/build.gradle.kts`
  - `gradle/libs.versions.toml`
  - `app/src/main/AndroidManifest.xml`
  - `app/src/main/kotlin/com/implantdoom/MainActivity.kt`
  - `app/src/main/kotlin/com/implantdoom/ui/AppViewModel.kt`
  - `app/src/main/kotlin/com/implantdoom/ui/DoomAssets.kt`
  - `app/src/main/kotlin/com/implantdoom/ui/screens/PlayScreen.kt`
  - `app/src/main/kotlin/com/implantdoom/game/Raycaster.kt`
  - `app/src/main/kotlin/com/implantdoom/game/GameState.kt`
  - `app/src/main/kotlin/com/implantdoom/game/GameLevel.kt`
  - `app/src/main/kotlin/com/implantdoom/cartridge/CartridgeCodec.kt`
  - `app/src/main/kotlin/com/implantdoom/cartridge/DemoCartridge.kt`
  - `app/src/main/kotlin/com/implantdoom/nfc/NfcReader.kt`
  - `app/src/main/kotlin/com/implantdoom/nfc/NfcWriter.kt`
  - `app/src/main/kotlin/com/implantdoom/nfc/NfcVNdefReader.kt`
  - `app/src/main/kotlin/com/implantdoom/nfc/NfcVNdefWriter.kt`
  - `app/src/main/kotlin/com/implantdoom/nfc/NfcVDiagnostics.kt`
  - `docs/CARTRIDGE_FORMAT.md`
  - `app/src/test/kotlin/com/implantdoom/cartridge/CartridgeCodecTest.kt`
  - `app/src/test/kotlin/com/implantdoom/cartridge/DemoCartridgeTest.kt`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeded and reports:
  - Gradle `8.9`
  - launcher JVM `1.8.0_321`
- `cmd /c gradlew.bat help --no-daemon` failed in the lab because no Java compiler or full JDK is available:
  - `No Java compiler found, please ensure you are running Gradle with a JDK`
- `cmd /c gradlew.bat :app:testDebugUnitTest --dry-run --no-daemon` failed for the same reason before Android task configuration could proceed.
- The repository itself clearly expects a real modern Android toolchain:
  - Java and Kotlin target `17`
  - Android SDK `35`
  - README setup notes explicitly call for JDK `17`
- The visible verification surface is focused rather than broad:
  - cartridge encode/decode round-trip tests
  - CRC and corruption tests
  - nibble-packing validation
  - demo-cartridge and seeded-generator checks
- No checked-in CI workflows were found in the inspected default branch.

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `3`
- Implementation depth: `2`
- Code clarity: `3`
- Novelty: `3`
- Overall verdict: `accepted`
- Why:
  - `NFC-DOOM` is a rare direct Android reference that combines Compose, software pseudo-3D, and low-level NFC content loading without collapsing into gimmick-only code.
  - The most reusable value comes from the pure Kotlin raycaster and simulation core, the strict tiny cartridge format, the raw `NfcV` recovery paths for broken tags, and the clean separation between immutable tag-provided content and phone-owned runtime state.
  - It is held back by low ecosystem signal, a small test surface outside the codec layer, and local build verification limits in the lab, but it still clears the bar for the main catalog.

## Interesting Findings

### Engine Architecture And Core Loop

- `app/src/main/kotlin/com/implantdoom/ui/AppViewModel.kt` is the main orchestration layer. It owns NFC mode switching, current cartridge, builder state, diagnostics state, and navigation events, while delegating heavy tag I/O to background coroutines on `Dispatchers.IO`.
- `app/src/main/kotlin/com/implantdoom/game/GameState.kt` and `GameLevel.kt` keep the runtime mostly pure Kotlin. Once a cartridge is loaded, the phone plays against a mutable in-memory copy of the level state instead of mutating the NFC payload directly.
- `app/src/main/kotlin/com/implantdoom/ui/screens/PlayScreen.kt` shows a clean Compose-hosted loop:
  - `withFrameNanos` drives updates
  - `GameState.update(...)` stays separate from UI concerns
  - the render phase simply redraws from current state each frame

### Rendering And Graphics

- `app/src/main/kotlin/com/implantdoom/game/Raycaster.kt` implements a compact grid-based DDA raycaster with perpendicular-distance projection, wall-hit fraction reporting, and a line-of-sight helper that the gameplay layer can reuse for enemy behavior.
- `app/src/main/kotlin/com/implantdoom/ui/screens/PlayScreen.kt` uses an intentionally tiny offscreen framebuffer (`RENDER_WIDTH = 128`) and then upscales it with nearest-neighbor filtering. That is a strong Android-friendly pattern for stylized pseudo-3D without relying on OpenGL or a heavyweight engine.
- The same screen layers several useful visual ideas on top of the tiny framebuffer:
  - textured wall-column rendering
  - billboard sprites for enemies and items
  - simple fog and side shading
  - first-person weapon overlay
  - a separate Doom-like status bar rendered from image slices
- `app/src/main/kotlin/com/implantdoom/ui/DoomAssets.kt` keeps the asset library on the phone rather than on the tag. The cartridge only selects content IDs, while the app bundles Freedoom-derived textures, sprites, weapon frames, digits, and face plates locally.

### Gameplay Systems

- `app/src/main/kotlin/com/implantdoom/cartridge/CartridgeCodec.kt` defines a strong tiny content-pack format:
  - `20`-byte header
  - `16x16` map packed into `4`-bit tiles
  - fixed-size entity and item records
  - trailing CRC32
  - hard size ceiling of `1000` bytes
- `app/src/main/kotlin/com/implantdoom/cartridge/DemoCartridge.kt` makes the project useful even on emulators or non-NFC phones. The repository includes both a hand-authored demo map and a seeded `MapGenerator`, so the app is still usable as a normal Android prototype without implant/tag hardware.
- `app/src/main/kotlin/com/implantdoom/game/GameState.kt` shows a compact but real first-person rules core:
  - player move/turn state
  - ammo, health, armor, pickups, and key logic
  - enemy chase gated by line of sight
  - hazard and exit tiles
  - banner/HUD event messaging

### Input And Controls

- `app/src/main/kotlin/com/implantdoom/MainActivity.kt` combines NFC reader-mode ownership with a normal activity shell instead of splitting discovery into separate Android components. It enables `FLAG_READER_SKIP_NDEF_CHECK`, delays presence checks, and handles direct tag callbacks itself.
- `app/src/main/kotlin/com/implantdoom/ui/screens/PlayScreen.kt` keeps the in-game controls deliberately small and touch-first:
  - hold buttons for turning and movement
  - separate fire button
  - landscape lock only while the game screen is active
- The combination of tag scanning, demo-cartridge fallback, and touch-only controls makes the app usable both as a niche NFC experiment and as a normal small Android game shell.

### UI, HUD, And Menus

- `PlayScreen.kt` and the surrounding Compose screen stack show how to host a specialized game surface without abandoning normal Android UI. The gameplay viewport, HUD overlays, controls, and end-state dialogs all stay inside standard Compose composition.
- The top HUD and status bar are intentionally split:
  - `TopHud(...)` shows cartridge provenance, FPS, and banner text
  - `DoomStatusBar(...)` renders a more stylized retro bottom HUD from image slices

### Persistence And Data

- `CartridgeCodec.kt` and `GameLevel.kt` show a strong pattern for external game content: treat the loaded payload as immutable source data, then fork it into runtime-owned mutable state so gameplay can progress without rewriting the original cartridge.
- The CRC32 validation path is worth reusing in other tiny content-pack or level-bundle formats because it fails fast on corruption before gameplay tries to interpret bad data.

### Tooling And Content Pipeline

- `docs/CARTRIDGE_FORMAT.md` is a good example of keeping a compact binary format documented alongside code. The documentation mirrors the actual byte layout, field sizes, and validation order instead of forcing readers back into the codec implementation.
- `DemoCartridge.defaultBytes()` gives the project a useful authoring seam: the same binary format can be generated in-app for writing, not only read back from external tags.

### Android Platform Integration

- `app/src/main/AndroidManifest.xml` is unusually intentional for such a small project:
  - NFC is the only requested permission
  - `android.hardware.nfc` is marked `required="false"`
  - no `INTERNET` permission is present
  - the app auto-launches on its custom cartridge MIME type
- `app/src/main/kotlin/com/implantdoom/nfc/NfcReader.kt` and `NfcVNdefReader.kt` do not trust the happy path. They prefer the OS NDEF route, but fall back to raw ISO 15693 block reads when the tag's CC or NDEF exposure is broken.
- `NfcWriter.kt` and `NfcVNdefWriter.kt` are similarly careful on writes:
  - multiple framing profiles are probed
  - only NDEF data blocks are written
  - block `0` CC and lock/security bytes are deliberately avoided
  - readback verification happens after writes

### Build, Release, And Testing

- `build.gradle.kts`, `app/build.gradle.kts`, and `gradle/libs.versions.toml` show a compact but current Android build surface around AGP `8.7.2`, Kotlin `2.0.21`, SDK `35`, and Java `17`.
- The checked-in test surface is narrow, but it targets the most failure-prone subsystem: binary cartridge integrity. That is more useful than the default placeholder tests common in small Android game samples.

## Reusable Takeaways

- A direct Android game can safely externalize level content into a tiny binary payload while keeping art, runtime, and UI ownership entirely on the device.
- Compose can host a retro pseudo-3D game if the renderer stays small and software-driven: render low-res offscreen, upscale sharply, and let Compose own the outer HUD and controls.
- `NfcV` / Type 5 tags may need raw block-level fallback paths in production even when Android's higher-level NDEF APIs exist.
- A strict size budget plus CRC validation is a practical way to keep experimental gameplay cartridges robust and portable.
- Optional NFC hardware support is a good Android product pattern: the same app still runs on emulators and non-NFC devices by shipping a built-in demo content path.

## Evidence Summary

- `app/src/main/kotlin/com/implantdoom/ui/AppViewModel.kt` - NFC mode orchestration, cartridge loading, background tag I/O, and state ownership
- `app/src/main/kotlin/com/implantdoom/game/Raycaster.kt` - pure Kotlin DDA raycaster and line-of-sight helper
- `app/src/main/kotlin/com/implantdoom/game/GameState.kt` and `GameLevel.kt` - runtime simulation, mutable play-state fork, and basic AI/combat flow
- `app/src/main/kotlin/com/implantdoom/ui/screens/PlayScreen.kt` - frame loop, offscreen raycaster rendering, HUD, and touch controls
- `app/src/main/kotlin/com/implantdoom/ui/DoomAssets.kt` - bundled asset library and theme-color extraction
- `app/src/main/kotlin/com/implantdoom/cartridge/CartridgeCodec.kt` - byte layout, CRC validation, and size-budget enforcement
- `app/src/main/kotlin/com/implantdoom/cartridge/DemoCartridge.kt` - authored demo level and seeded generator
- `app/src/main/kotlin/com/implantdoom/nfc/NfcReader.kt`, `NfcWriter.kt`, `NfcVNdefReader.kt`, and `NfcVNdefWriter.kt` - OS-level plus raw `NfcV` fallback behavior
- `app/src/main/AndroidManifest.xml` - NFC-only permission footprint, optional hardware, and MIME/tag launch integration
- `app/src/test/kotlin/com/implantdoom/cartridge/*` - focused codec and demo-cartridge tests

## Risks Or Limits

- The repository is extremely fresh and still has zero public signal, so long-term maintenance confidence is low.
- The automated verification surface is focused almost entirely on the cartridge layer; the raycaster, Compose UI, and NFC runtime paths have far less direct test coverage.
- The whole app currently lives in one Android module with a relatively central `AppViewModel`, so future complexity growth could make the product shell harder to keep tidy.
- Some code/documentation drift is already visible:
  - `Textures.kt` still describes a generated-color path
  - the active runtime now loads real bundled Freedoom-derived PNG assets via `DoomAssets`
- Local build validation in the lab remains incomplete because the machine still exposes only a Java `8` JRE without compiler tools, while the repository expects a full JDK `17` and Android SDK `35`.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `android-game`
- Focus tags: `3d`, `android`, `input`, `ui-hud`, `asset-pipeline`, `performance`
- Follow-up needed:
  - if the lab revisits this repository, rerun Android tasks in a JDK `17+` plus Android SDK-ready environment, or isolate the low-resolution software raycaster, the cartridge codec/builder seam, or the raw `NfcV` read/write fallback layer instead of reopening the whole repository broadly
