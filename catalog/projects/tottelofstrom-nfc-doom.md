# Project Entry

## Basic Info

- Project name: `NFC-DOOM`
- Source repository: [https://github.com/tottelofstrom/NFC-DOOM](https://github.com/tottelofstrom/NFC-DOOM)
- Author / organization: `tottelofstrom`
- License: `MIT`
- Research note: [research/findings/tottelofstrom-nfc-doom.md](../../research/findings/tottelofstrom-nfc-doom.md)
- Investigated commit: `22ae1d60186712e8a11fb90ec5386a3fed69e492`
- Last verified: `2026-06-04`
- Activity / maintenance status: extremely fresh and still zero-star, but actively edited on `2026-06-03`; the latest inspected commit is `README front-page write-up`, and the checked-in Android/NFC/product docs are already stronger than most one-day experiments.

## Short Description

Android-native Jetpack Compose raycaster experiment where tiny Doom-like levels are stored as NFC cartridges, loaded into a pure Kotlin runtime, and rendered through a low-resolution software 3D pipeline with bundled Freedoom-derived art.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `3d`, `android`, `input`, `ui-hud`, `asset-pipeline`, `performance`
- Engine / framework: Android SDK + Jetpack Compose + Android NFC / `NfcV` + pure Kotlin gameplay core
- Rendering approach: offscreen low-resolution software raycaster rendered into an `ImageBitmap` and upscaled in Compose `Canvas`, with billboard sprites, bundled Doom-style HUD art, and phone-owned asset selection while the tag carries only level data
- Main language(s): Kotlin
- Android target: direct Android app module with `minSdk 26`, `targetSdk 35`, and `compileSdk 35`
- Build system: Gradle `8.9` wrapper + AGP `8.7.2` + Kotlin `2.0.21` + Java target `17`

## Why It Matters

- This repository is worth keeping because it is one of the clearest direct Android references in the lab for combining Jetpack Compose, software pseudo-3D, and low-level NFC content handling without any third-party engine.
- Its main value is not only the gimmick of "Doom from an implant." The reusable part is the technical stack: strict tiny cartridge encoding, raw `NfcV` fallback when Android's higher-level NDEF path is unreliable, pure Kotlin raycasting and simulation, and a clean Compose shell around a specialized game surface.

## Reusable Ideas

- Gameplay ideas:
  - treat a tag or cartridge as a tiny immutable level pack while the phone owns the actual runtime, art library, and HUD
- Architecture patterns:
  - keep codec, NFC, simulation, and UI responsibilities separate, with one `ViewModel` orchestrating device events and pure helpers doing the heavy work
- Graphics / rendering techniques:
  - low-resolution software raycaster plus nearest-neighbor upscale, billboard sprites, and a separate phone-side asset bundle selected by compact cartridge IDs
- Input / UI approaches:
  - optional NFC hardware, MIME-driven tag launch, reader-mode ownership in the main activity, and Compose-hosted touch controls with a dedicated retro HUD layer
- Performance or optimization ideas:
  - fixed tiny framebuffer width, simple DDA math, small byte-budget content format, and careful avoidance of unnecessary write-back to the cartridge

## Notable Implementations

- `CartridgeCodec.kt` defines a `1000`-byte max cartridge format with nibble-packed tiles, fixed record sizes, and CRC32 validation.
- `NfcReader.kt`, `NfcVNdefReader.kt`, and `NfcVNdefWriter.kt` provide raw ISO 15693 fallback and safe write behavior for Type 5 tags.
- `Raycaster.kt` implements a compact pure Kotlin DDA renderer plus line-of-sight helper.
- `GameState.kt` and `GameLevel.kt` keep gameplay in pure Kotlin instead of in Android/Compose code.
- `PlayScreen.kt` hosts the update loop and renders the 3D view into an offscreen `ImageBitmap` before scaling it up in Compose.
- `DoomAssets.kt` keeps the phone-side art bundle and theme-color extraction separate from the NFC payload.
- `DemoCartridge.kt` ensures the app still works on emulators or phones without NFC hardware.

## Android Relevance

- Native Android use:
  - yes, direct Android app with NFC intent filters, reader mode, Compose screens, touch controls, and no external engine layer
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - the most transferable pieces are the low-res software-rendering pattern, the strict content-pack codec, and the raw `NfcV` fallback layer; the exact "implant cartridge" framing is niche, but the technical solutions are broadly reusable

## Risks / Limitations

- Very fresh repository with no ecosystem signal yet.
- Test coverage is concentrated on the cartridge codec rather than on the raycaster, UI, or NFC runtime.
- Build verification in this lab is blocked by the missing full JDK and Android SDK.
- Minor code/documentation drift already exists around old generated-texture comments versus the current bundled `doomgfx` asset path.

## Notes

`NFC-DOOM` is especially useful as a reference for unusual Android constraints: optional hardware support, tiny external content payloads, retro rendering without OpenGL, and a direct activity-owned NFC flow. Even if no future project uses NFC literally, the cartridge codec and host/runtime split are strong ideas for compact level packs, physical game props, or other external-content experiments.
