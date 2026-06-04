# Research Note

## Repository Snapshot

- Repository: `yaroslavzghoba/KotCore`
- Source URL: [https://github.com/yaroslavzghoba/KotCore](https://github.com/yaroslavzghoba/KotCore)
- Owner: `yaroslavzghoba`
- Batch ID: [`BATCH-2026-06-04-AD`](../batches/BATCH-2026-06-04-AD.md)
- Type: `engine-framework`
- License: `Apache-2.0`
- Selection date: `2026-06-04`
- Last pushed at selection: `2026-05-30`
- Stars at selection: `0`
- Default branch at selection: `main`
- Investigated commit: `5a4c92dc06090c8e0c942d7f7a72f74cc13cf952`
- Research status: `reference-only`
- Build mode: `static-review + gradle-help-failed-java8-needs-java17`
- Catalog card: [catalog/projects/yaroslavzghoba-kotcore.md](../../catalog/projects/yaroslavzghoba-kotcore.md)

## Why This Repository Was Selected

- `KotCore` led the carry-over exact-license shortlist because it had explicit Apache-2.0 licensing, fresh activity, and direct Kotlin Multiplatform plus Android-positioned engine framing.
- The repository was small enough to audit almost completely in one pass, which made it a good candidate for validating whether the shortlist still contained real engine value or only aspirational scaffolding.
- Static review answers the main question conservatively: the checked-in tree is mostly a publication-first KMP library scaffold, so it is useful only as `reference-only`, not as a substantive engine baseline.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: extremely early Kotlin Multiplatform library scaffold for a future grid-based 2D engine
- Rendering stack: declared Compose Canvas intent only; no renderer or game loop implementation is checked in
- Android target: Android library target declared in Gradle, but no Android app, host shell, or engine-specific Android code was found
- Build system: single-module Gradle KMP library with JVM, Android library, iOS Arm64, iOS Simulator Arm64, Linux x64, and Wasm JS targets; Kotlin `2.3.21`; AGP `9.0.1`; Vanniktech Maven Publish
- Repository layout summary:
  - `kotcore/` holds the only code module plus publishing metadata
  - `.github/workflows/` contains release publishing and PR version-comparison automation
  - the root build only configures plugins and module inclusion
- Source footprint:
  - total files counted in repository: `14`
  - Kotlin/KTS/Java files counted in repository: `4`
- Test surface:
  - test files found: `0`
  - meaningful engine/gameplay tests found: `0`
- Key modules and files reviewed:
  - `settings.gradle.kts`
  - `build.gradle.kts`
  - `gradle/libs.versions.toml`
  - `kotcore/build.gradle.kts`
  - `kotcore/src/commonMain/kotlin/Main.kt`
  - `.github/workflows/publish.yml`
  - `.github/workflows/compare-versions.yml`

## Build And Runtime Notes

- The repository was investigated through static review plus lightweight Gradle discovery.
- No `README.md`, checked-in docs, sample app, or engine implementation was present in the inspected tree.
- `cmd /c gradlew.bat --version` succeeds in the lab and reports Gradle `9.3.0` running on Java `8`.
- `cmd /c gradlew.bat help --no-daemon` fails because Gradle requires JVM `17+` while the current lab environment still exposes Java `8`.
- Upstream release automation is already pinned higher than the current lab:
  - `.github/workflows/publish.yml` provisions JDK `21` and runs `publishToMavenCentral` on GitHub release events.
- No runtime launch was attempted because the checked-in source does not contain an executable engine, sample, or rendering path.

## Usefulness Assessment

- Reuse potential: `1`
- Android transfer: `1`
- Implementation depth: `0`
- Code clarity: `2`
- Novelty: `1`
- Overall verdict: `reference-only`
- Why:
  - The repository is useful as a compact example of how to scaffold a publishable KMP game-library surface early, with Android included in the declared target matrix from the start.
  - It is not strong enough to serve as a main lab reference because the actual engine implementation is still absent: the only common Kotlin source file contains just a package declaration.

## Interesting Findings

### Engine Architecture And Core Loop

- `kotcore/src/commonMain/kotlin/Main.kt` is the clearest maturity signal in the repository: the checked-in "engine" code is currently only `package space.zghoba`. That makes the repository a useful cautionary counterexample about verifying implementation depth from code rather than trusting repository descriptions.
- The declared runtime ambition is still visible in metadata rather than code. `settings.gradle.kts` and `kotcore/build.gradle.kts` frame `KotCore` as a future grid-based KMP engine library, but no loop, world, input, or rendering abstractions are yet present.

### Tooling, Release, And Multiplatform Setup

- `kotcore/build.gradle.kts` is more substantial than the source tree itself. One module already declares `jvm`, `androidLibrary`, `iosArm64`, `iosSimulatorArm64`, `linuxX64`, and `wasmJs` targets plus Maven Central coordinates and a complete POM definition.
- `.github/workflows/publish.yml` shows a clean release path: on GitHub release events, JDK `21` is provisioned and `publishToMavenCentral` runs with in-memory signing credentials.
- `.github/workflows/compare-versions.yml` adds a small but useful process guard. Pull requests use a custom action to clone the repository and compare the current version via `./gradlew printVersion -q`.

## Reusable Takeaways

- A future Kotlin game library can be scaffolded with explicit multiplatform targets, Android library configuration, and publication metadata before the runtime exists, which can help define intended distribution boundaries early.
- At the same time, repository framing should never be taken at face value during intake. A declared Android or Compose Canvas target matrix does not mean reusable engine code is actually present yet.
- For this lab, tiny repositories like `KotCore` are still worth one fast pass because they validate the queue and prevent the team from revisiting empty or mostly aspirational candidates later.

## Evidence Summary

- `kotcore/build.gradle.kts` - target matrix, Android library surface, Maven Central metadata, and `printVersion` task
- `kotcore/src/commonMain/kotlin/Main.kt` - confirms the current implementation surface is effectively empty
- `gradle/libs.versions.toml` - Kotlin `2.3.21`, AGP `9.0.1`, project version `0.2.0`
- `.github/workflows/publish.yml` - release-driven JDK `21` Maven Central publishing
- `.github/workflows/compare-versions.yml` - PR-side version comparison process
- `settings.gradle.kts` and `build.gradle.kts` - single-module root layout and plugin setup

## Risks Or Limits

- No `README.md` or checked-in docs were present.
- No real engine/runtime/rendering code is present in the inspected revision.
- No tests were found.
- Direct Android relevance is only declarative at this stage.
- The latest inspected commit (`5a4c92d`) focuses on publish/version scripts, which means the visible freshness signal is mostly around release scaffolding rather than runtime implementation.
- Local Gradle discovery in the lab remains limited by Java `8` while the project already expects Java `17+` and publishes on JDK `21`.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `reference-only`
- Focus tags: `android`, `multiplatform`
- Follow-up needed:
  - if the lab revisits this repository, keep it narrow: rerun Gradle discovery in a JDK `21` environment only if the source surface grows, or isolate future real engine files once loop, grid, input, or rendering code actually appears
