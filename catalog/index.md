# Project Catalog

Use this file as the quick reference index of all reviewed projects.

| Project | Primary Category | Focus Tags | Engine / Stack | Language | Android Relevance | Key Ideas | Source | Research Note |
|---|---|---|---|---|---|---|---|---|
| [Antimine - Minesweeper](projects/lucasnlm-antimine-android.md) | `android-game` | `2d`, `android`, `libgdx`, `save-load`, `procedural-generation` | Android SDK + LibGDX + native SGTatham generator | Kotlin | direct Android game with Wear OS and Android Auto modules | native fallback generation, binary saves, Android form-factor adaptation | [repo](https://github.com/lucasnlm/antimine-android) | [note](../research/findings/lucasnlm-antimine-android.md) |
| [KorGE](projects/korlibs-korge.md) | `engine-framework` | `android`, `multiplatform`, `scene-graph`, `korge`, `performance` | KorGE / Korlibs | Kotlin | strong Android embedding path inside a multiplatform engine | scene routing, host `View` embedding, frame-budgeted coroutine dispatch | [repo](https://github.com/korlibs/korge) | [note](../research/findings/korlibs-korge.md) |
| [KTX](projects/libktx-ktx.md) | `library-sdk` | `libgdx`, `ui-hud`, `ai`, `asset-pipeline`, `performance` | KTX over libGDX | Kotlin | indirect but strong for libGDX-based Android games | coroutine dispatchers, async assets, Scene2D DSL, AI DSL, lightweight DI | [repo](https://github.com/libktx/ktx) | [note](../research/findings/libktx-ktx.md) |
| [Godot Kotlin/JVM](projects/utopia-rise-godot-kotlin-jvm.md) | `reference-only` | `android`, `multiplatform`, `testing` | Godot Kotlin/JVM binding | Kotlin, C++ | indirect; useful for engine-binding and Android export patterns | bootstrap ordering, code generation, JVM bridge lifecycle, Android dex packaging | [repo](https://github.com/utopia-rise/godot-kotlin-jvm) | [note](../research/findings/utopia-rise-godot-kotlin-jvm.md) |
