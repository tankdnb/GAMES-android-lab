# Project Entry

## Basic Info

- Project name: `gdx-liftoff`
- Source repository: [https://github.com/libgdx/gdx-liftoff](https://github.com/libgdx/gdx-liftoff)
- Author / organization: `libgdx`
- License: `Apache-2.0`
- Research note: [research/findings/libgdx-gdx-liftoff.md](../../research/findings/libgdx-gdx-liftoff.md)
- Investigated commit: `088e9c4769daa0b88f9969201e68ca9248eb09a8`
- Last verified: `2026-06-04`
- Activity / maintenance status: active upstream-maintained tooling repository; the latest inspected commit is `Back to SNAPSHOTs. Update Fory/Tantrum.` from `2026-06-02`, and the repository still carries current build and demo-publication workflows.

## Short Description

libGDX project generator with a desktop GUI shell and a structured Kotlin-heavy generation core for bootstrapping Android, desktop, web, and other multi-module game projects.

## Technical Profile

- Primary category: `tooling-pipeline`
- Focus tags: `android`, `multiplatform`, `libgdx`, `editor-tools`, `asset-pipeline`, `testing`
- Engine / framework: libGDX project generator plus desktop launcher UI for emitting Gradle-based multi-platform project skeletons
- Rendering approach: the generator itself is a desktop libGDX/LWJGL3 app with Scene2D-style UI; the generated projects can target Android, LWJGL3 desktop, TeaVM, GWT, iOS, and headless/server modes
- Main language(s): Kotlin, Java
- Android target: indirect but strong; the repository does not ship an Android game, but it generates Android modules, manifests, resources, native-copy tasks, and launcher code for downstream projects
- Build system: Gradle Groovy DSL with Kotlin plugin support, `application`, `java-library`, `ktlint`, and `construo`

## Why It Matters

- `gdx-liftoff` is a strong reference for how to scaffold a Kotlin-friendly libGDX project without letting Android, desktop, and web support drift into separate one-off build setups.
- It is especially valuable as a tooling study because the generator is not just a pile of copied templates. It uses a typed project model, explicit per-platform build emitters, and centralized version/default management.

## Reusable Ideas

- Gameplay ideas:
  - none directly; the repository is about project bootstrap rather than gameplay systems
- Architecture patterns:
  - typed project-generation pipeline with root settings, platform emitters, templates, optional languages, and optional extensions
  - clear split between generator UI shell and generation core
- Graphics / rendering techniques:
  - none directly for games; the desktop UI shell is only an operator front-end
- Input / UI approaches:
  - desktop generator UI separated from emitted project content
- Performance or optimization ideas:
  - checked-in daemon JDK provisioning and Gradle toolchain bootstrapping reduce environment friction for users of the tool

## Notable Implementations

- `Project.kt` orchestrates generation as an explicit pipeline instead of as a single monolithic template dump.
- `RootGradleFile.kt` and the per-platform `GradleFile` subclasses keep shared build logic and module-local build logic separate.
- `Android.kt` and `AndroidGradleFile` generate a surprisingly complete Android module surface: manifest, resources, `local.properties`, desugaring flags, native extraction, and an `adb` run task.
- `KotlinTemplate.kt` emits Kotlin launchers and builders for several target platforms from one template family.
- `settings.gradle` plus `gradle/gradle-daemon-jvm.properties` show a strong build-UX pattern where the repository can provision a compatible daemon JDK automatically.

## Android Relevance

- Native Android use:
  - indirect; this repository is not an Android runtime or game
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - particularly useful when we need a reference for Kotlin/libGDX project bootstrap, Android module setup, and keeping shared/core/platform Gradle structure maintainable over time

## Risks / Limitations

- The repository is generator-specific and does not contain direct gameplay, rendering-runtime, or Android product-shell techniques.
- `Architecture.md` is explicitly out of date and should not be trusted over the live code.
- The visible confidence surface is stronger in build/sample/demo automation than in a large checked-in unit-test suite.

## Notes

`gdx-liftoff` belongs in the main catalog because this lab is not only collecting runtime/gameplay references. It also needs strong references for how Kotlin game projects are bootstrapped, structured, versioned, and kept portable across Android and adjacent targets.
