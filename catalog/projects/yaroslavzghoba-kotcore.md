# Project Entry

## Basic Info

- Project name: `KotCore`
- Source repository: [https://github.com/yaroslavzghoba/KotCore](https://github.com/yaroslavzghoba/KotCore)
- Author / organization: `yaroslavzghoba`
- License: `Apache-2.0`
- Research note: [research/findings/yaroslavzghoba-kotcore.md](../../research/findings/yaroslavzghoba-kotcore.md)
- Investigated commit: `5a4c92dc06090c8e0c942d7f7a72f74cc13cf952`
- Last verified: `2026-06-04`
- Activity / maintenance status: extremely early and low-signal; the repository was pushed on `2026-05-30`, and the latest inspected commit adds publish/version scaffolding rather than actual engine code.

## Short Description

Very early Kotlin Multiplatform library scaffold for a planned 2D grid engine, with Android/JVM/iOS/Linux/Wasm targets and Maven Central release wiring but no checked-in runtime implementation yet.

## Technical Profile

- Primary category: `reference-only`
- Focus tags: `android`, `multiplatform`
- Engine / framework: future custom Kotlin Multiplatform grid-engine scaffold
- Rendering approach: declared Compose Canvas direction, but no checked-in renderer
- Main language(s): Kotlin
- Android target: Android library target declared in Gradle only
- Build system: single-module Gradle KMP library with Vanniktech Maven Publish and a JDK `21` GitHub release-publishing workflow

## Why It Matters

- `KotCore` is useful as a compact reference for publication-first KMP library scaffolding where Android, JVM, iOS, Linux, and Wasm targets are declared from day one.
- It is also a good cautionary example: repository descriptions and target matrices can look much more mature than the actual checked-in runtime implementation.

## Reusable Ideas

- Gameplay ideas:
  - none directly; no gameplay or engine runtime is checked in yet
- Architecture patterns:
  - declare a target matrix and publication coordinates early when a future game library is meant to ship as a reusable artifact
  - keep the distributable library surface isolated in one focused module while the API is still being defined
- Graphics / rendering techniques:
  - none checked in yet; the Compose Canvas direction is only declarative
- Input / UI approaches:
  - none checked in yet
- Performance or optimization ideas:
  - none yet; the strongest practical takeaway is to verify implementation depth from code instead of metadata

## Notable Implementations

- `kotcore/build.gradle.kts` sets up JVM, Android, iOS, Linux, and Wasm targets in one library module.
- The `mavenPublishing` block already declares Maven Central coordinates and a full POM metadata set.
- `.github/workflows/publish.yml` wires release-driven publishing on JDK `21`.
- `.github/workflows/compare-versions.yml` adds a small pull-request version-guard workflow.
- `Main.kt` confirms that the runtime itself is not implemented yet.

## Android Relevance

- Native Android use:
  - only declarative today; no Android sample or runtime shell was found
- Kotlin relevance:
  - moderate
- Porting or adaptation notes:
  - useful only as build and publication scaffolding until real engine code lands

## Risks / Limitations

- No `README.md` or checked-in docs were present.
- No real engine source beyond a package declaration was found.
- No tests were found.
- Most of the visible freshness is around release scaffolding rather than runtime evolution.
- Local Gradle discovery in this lab still stops at the Java `17+` floor while the machine remains on Java `8`.

## Notes

Keep `KotCore` as `reference-only`: it is currently more useful as a compact KMP publishing scaffold and as a caution about metadata outrunning code than as a reusable engine baseline.
