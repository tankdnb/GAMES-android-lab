# Research Note

## Repository Snapshot

- Repository: `libgdx/gdx-liftoff`
- Source URL: [https://github.com/libgdx/gdx-liftoff](https://github.com/libgdx/gdx-liftoff)
- Owner: `libgdx`
- Batch ID: [`BATCH-2026-06-04-O`](../batches/BATCH-2026-06-04-O.md)
- Type: `tooling-pipeline`
- License: `Apache-2.0`
- Selection date: `2026-06-04`
- Last pushed at selection: `2026-06-02`
- Stars at selection: `669`
- Default branch at selection: `master`
- Investigated commit: `088e9c4769daa0b88f9969201e68ca9248eb09a8`
- Research status: `accepted`
- Build mode: `static-review + gradle-help`
- Catalog card: [catalog/projects/libgdx-gdx-liftoff.md](../../catalog/projects/libgdx-gdx-liftoff.md)

## Why This Repository Was Selected

- `gdx-liftoff` came from the explicit-license shortlist and had the strongest ecosystem signal in the remaining queue by far: maintained upstream ownership, `669` stars, a fresh push on `2026-06-02`, and a still-active release/demo workflow.
- The main question for this batch was whether a project generator is too indirect for the main catalog. The answer is `accepted`: this repository is not a runtime engine, but it is a high-value reference for how to scaffold Kotlin-first game projects that still need Android, desktop, and web targets to stay coherent.
- Its strongest value is not visual rendering or gameplay code. It is the way it models project generation as a typed pipeline: root configuration, per-platform Gradle files, launchers, version properties, extension selection, and Android-specific build details are all generated from one structured project model.

## Technical Profile

- Main language(s): Kotlin, Java
- Engine / framework: libGDX project generator with a desktop GUI shell and a Kotlin-heavy project-generation core
- Rendering stack:
  - the generator app itself is a libGDX desktop application using LWJGL3 plus Scene2D/VisUI-style UI tooling
  - the emitted projects can target Android, LWJGL3 desktop, TeaVM, GWT, iOS/MOE, RoboVM, and headless/server modes
- Android target: indirect but strong; the repository does not ship an Android game, but it generates Android modules, manifests, resources, Gradle files, native extraction tasks, and launcher code for downstream libGDX projects
- Build system: Gradle Groovy DSL with Kotlin plugin support, `application`, `java-library`, `ktlint`, and `construo`
- Repository layout summary:
  - `src/main/kotlin/` contains the project model, platform definitions, language templates, Gradle-file emitters, and extension metadata
  - `src/main/java/` contains the generator UI shell, app entrypoint, dialog and table logic, and the user-data assembly flow
  - `etc/`, `icons/`, and `raw/` hold generator resources and template assets
  - top-level docs such as `Guide.md`, `GWT.md`, and `Troubleshooting.md` explain generated-project tradeoffs
- Source footprint:
  - total files counted in repository: `410`
  - Kotlin/KTS/Java files counted in repository: `97`
- Test surface:
  - no obvious checked-in `src/test` tree was found during this pass
  - confidence instead comes from build/sample-generation automation and the maturity of the generated-project surface
- Key files reviewed:
  - `README.md`
  - `Architecture.md`
  - `Guide.md`
  - `build.gradle`
  - `settings.gradle`
  - `gradle.properties`
  - `gradle/gradle-daemon-jvm.properties`
  - `version.txt`
  - `src/main/kotlin/gdx/liftoff/data/project/Project.kt`
  - `src/main/kotlin/gdx/liftoff/data/project/Data.kt`
  - `src/main/kotlin/gdx/liftoff/data/files/ProjectFiles.kt`
  - `src/main/kotlin/gdx/liftoff/data/files/gradle/GradleFile.kt`
  - `src/main/kotlin/gdx/liftoff/data/files/gradle/RootGradleFile.kt`
  - `src/main/kotlin/gdx/liftoff/data/platforms/Android.kt`
  - `src/main/kotlin/gdx/liftoff/data/platforms/Lwjgl3.kt`
  - `src/main/kotlin/gdx/liftoff/data/platforms/TeaVM.kt`
  - `src/main/kotlin/gdx/liftoff/data/languages/Kotlin.kt`
  - `src/main/kotlin/gdx/liftoff/data/templates/KotlinTemplate.kt`
  - `src/main/kotlin/gdx/liftoff/data/libraries/Library.kt`
  - `src/main/kotlin/gdx/liftoff/data/libraries/Repository.kt`
  - `src/main/java/gdx/liftoff/Main.java`
  - `src/main/java/gdx/liftoff/Maker.java`
  - `.github/workflows/build.yml`
  - `.github/workflows/publish-demos.yml`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeds in the inspected clone:
  - Gradle `9.5.1`
  - launcher JVM `1.8.0_321`
  - daemon JVM resolved as Java `21` from `gradle/gradle-daemon-jvm.properties`
- `cmd /c gradlew.bat help --no-daemon` also succeeds in the lab:
  - Gradle forks a single-use daemon and honors the repository's daemon JVM/toolchain settings
  - this is a useful pattern in itself, because the checked-in build can bootstrap a compatible daemon even when the ambient launcher JVM is older
- The root build is more modern than the stale `Architecture.md` suggests:
  - `settings.gradle` applies the Foojay toolchain resolver
  - `gradle/gradle-daemon-jvm.properties` pins daemon toolchain download URLs and `toolchainVersion=21`
  - `build.yml` runs the build matrix on Java `17` and `21`, then generates a sample project
- `publish-demos.yml` is especially relevant for reusable workflow design:
  - it generates a default sample and a Kotlin sample
  - each demo is then deployed to a separate GitHub Pages repository
- The README says the generator itself now requires Java `17+`, which is consistent with the checked-in CI floor even though the wrapper can still bootstrap from an older launcher JVM in this environment.
- `Architecture.md` begins by saying it is out of date, and the warning is accurate:
  - the current codebase is no longer best understood through that document alone
  - the live repository now mixes a Java desktop UI shell with a Kotlin generation core and more modern Gradle/toolchain discipline than the old architecture note describes

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `3`
- Implementation depth: `3`
- Code clarity: `3`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - `gdx-liftoff` is one of the clearest reusable references in the lab for bootstrapping a Kotlin/libGDX project that still needs Android, desktop, and web targets to stay aligned.
  - The project-generator surface is typed and modular instead of being a pile of template strings with no structure, which makes it worth keeping as a main catalog reference for tooling and project-pipeline work.

## Interesting Findings

### Tooling And Content Pipeline

- `src/main/kotlin/gdx/liftoff/data/project/Project.kt` is the core reusable pattern: the generator owns one typed `Project` model that combines basic metadata, advanced versions, selected platforms, optional languages, selected extensions, and one template. Generation is then an explicit pipeline of `addBasicFiles()`, language support, extensions, template application, platform initiation, README/editorconfig emission, property saving, and file saving.
- `src/main/kotlin/gdx/liftoff/data/files/gradle/RootGradleFile.kt` plus the per-platform `GradleFile` subclasses show a clean split between root Gradle concerns and module-local concerns. This is much more transferable than older monolithic generators that emit one giant build file and then patch it conditionally.
- `src/main/kotlin/gdx/liftoff/data/templates/KotlinTemplate.kt` is a strong example of multi-platform launcher generation as code instead of as opaque text blobs. It emits platform-specific launchers for Android, LWJGL, LWJGL3, TeaVM, headless, and iOS while still enforcing known limits such as "Kotlin currently not supported by GWT."
- `src/main/kotlin/gdx/liftoff/data/libraries/Library.kt` and `Repository.kt` show that extension/dependency intake is modeled explicitly. The generator understands library repositories, per-platform dependency injection, Android native artifacts, GWT inherits, TeaVM config lines, and Android permissions rather than hardcoding everything into a single default stack.
- `src/main/java/gdx/liftoff/Main.java` and the related UI shell demonstrate a second important separation: the app's desktop GUI is only the front-end for collecting user data and dispatching generation, while the real generation logic stays in the Kotlin data/template/platform layer.

### Android Platform Integration

- `src/main/kotlin/gdx/liftoff/data/platforms/Android.kt` and `AndroidGradleFile` are the strongest Android-specific findings in the repository:
  - they add Android Gradle Plugin classpath wiring
  - they write `local.properties`
  - they emit `AndroidManifest.xml`, launcher resources, `strings.xml`, icons, and ProGuard rules
  - they configure AndroidX and desugaring defaults
  - they generate the `copyAndroidNatives` extraction task and an Android `run` task via `adb`
- `AdvancedProjectData` in `Data.kt` keeps several Android defaults in one place:
  - `androidSdkVersion = 35`
  - `androidPluginVersion = 8.9.3`
  - `androidDesugaringLibraryVersion = 2.1.5`
  - this is a practical pattern for treating Android-toolchain recommendations as versioned configuration rather than scattering them across template files
- `src/main/kotlin/gdx/liftoff/data/languages/Kotlin.kt` shows a small but important Android detail: Kotlin support does not just add a plugin globally. It also updates the Android module to apply `kotlin-android` late and adds `src/main/kotlin` to Android source sets, which is exactly the kind of generator detail that teams often get wrong when they hand-roll multi-module templates.

### Toolchain And Packaging Workflow

- `src/main/kotlin/gdx/liftoff/data/platforms/Lwjgl3.kt` and `Lwjgl3GradleFile` show that the generator treats packaging as part of project bootstrap, not as an afterthought:
  - desktop launchers are generated explicitly
  - fat-jar tasks are emitted
  - platform-specific `jarMac`, `jarLinux`, and `jarWin` tasks are emitted
  - `construo` packaging and optional Graal Native hooks are already scaffolded
- `src/main/kotlin/gdx/liftoff/data/platforms/TeaVM.kt` shows the same philosophy for web output:
  - TeaVM builds are generated as explicit tasks
  - the builder class is scaffolded
  - debug vs release output is modeled
  - asset and source registration is generated instead of left to manual setup
- The checked-in workflows complete the picture:
  - `build.yml` verifies build plus sample generation on multiple JDK versions
  - `publish-demos.yml` turns generated samples into continuously published reference outputs

### Build, Release, And Testing

- The build workflow is more reusable than it first looks because the repository treats JDK provisioning as part of the build contract:
  - `settings.gradle` uses `org.gradle.toolchains.foojay-resolver-convention`
  - `gradle/gradle-daemon-jvm.properties` pins downloadable daemon JDKs
  - the lab was able to run `gradlew help` successfully despite the older launcher JVM
- `build.gradle` also shows a pragmatic shipping posture for a desktop tooling app:
  - fat-jar assembly
  - `application` plugin
  - `construo`-backed packaging
  - `ktlint`
  - a `sample` task that exercises the generator rather than only compiling it
- The visible weakness in this area is not build discipline but test visibility:
  - the repo has strong build/sample/demo automation
  - it does not expose an obvious deep unit-test tree in the inspected snapshot
  - confidence comes more from mature generator structure and workflow automation than from a rich test corpus

## Reusable Takeaways

- Treat project generation as a typed pipeline, not as one giant template dump.
- Keep root build logic, per-platform build logic, and version properties separated so generated projects are easier to update later.
- For Android-capable generators, emit the Android-specific boring pieces completely: manifest, resources, SDK path, native extraction, desugaring, and run tasks should be generated from one place.
- Toolchain bootstrapping matters. Checked-in daemon JVM resolution and CI-aligned toolchain provisioning make a tooling repo much easier to use across mixed environments.

## Evidence Summary

- `src/main/kotlin/gdx/liftoff/data/project/Project.kt` - typed project model plus explicit generation pipeline
- `src/main/kotlin/gdx/liftoff/data/project/Data.kt` - centralized Android, Java, GWT, and TeaVM defaults
- `src/main/kotlin/gdx/liftoff/data/files/gradle/RootGradleFile.kt` - root Gradle layout, shared repositories, asset-list task, and Kotlin toolchain wiring
- `src/main/kotlin/gdx/liftoff/data/platforms/Android.kt` - Android module scaffolding, manifest/resources, desugaring, native-copy tasks, and `adb` run task
- `src/main/kotlin/gdx/liftoff/data/platforms/Lwjgl3.kt` - desktop launcher and packaging scaffold, Graal hooks, and `construo` integration
- `src/main/kotlin/gdx/liftoff/data/platforms/TeaVM.kt` - web backend scaffolding and generated builder tasks
- `src/main/kotlin/gdx/liftoff/data/languages/Kotlin.kt` and `data/templates/KotlinTemplate.kt` - Kotlin-specific launcher generation and Android/Kotlin source-set handling
- `src/main/kotlin/gdx/liftoff/data/libraries/Library.kt` and `Repository.kt` - explicit extension repository/dependency modeling
- `src/main/java/gdx/liftoff/Main.java` - desktop UI shell and background project-generation dispatch
- `.github/workflows/build.yml` and `publish-demos.yml` - CI matrix, sample generation, and demo publication
- `settings.gradle` and `gradle/gradle-daemon-jvm.properties` - toolchain resolver and daemon JDK provisioning

## Risks Or Limits

- `gdx-liftoff` is a generator and tooling reference, not a gameplay or runtime reference. Its main value is build/bootstrap architecture, not in-engine mechanics.
- `Architecture.md` is explicitly stale and should not be trusted as a full description of the live repository.
- The visible automation surface is strong, but there is no obvious deep checked-in unit-test tree in the inspected snapshot.
- Android guidance is useful and current in this revision, but it will naturally drift with AGP, SDK, and backend changes over time; this repository should be rechecked if the lab later uses it as a live bootstrap model.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `tooling-pipeline`
- Focus tags: `android`, `multiplatform`, `libgdx`, `editor-tools`, `asset-pipeline`, `testing`
- Follow-up needed:
  - if the lab revisits this repository, do it in a JDK `17+` or `21` environment and isolate either the Android Gradle scaffolding path, the root-versus-module build split, the Kotlin multi-launcher template set, or the daemon-JDK/toolchain bootstrap pattern instead of reopening the whole repo broadly
