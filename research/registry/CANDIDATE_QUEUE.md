# Candidate Queue

Use this file to manage the shortlist before repositories are cloned.

## Active Batch

Hard limit: no more than 4 new repositories at a time.

| Batch | Repository | Type | Fit | Popularity | Activity | Yield | Stars | Last Pushed | Why Selected | Status | Source |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `BATCH-2026-05-10-A` | `lucasnlm/antimine-android` | `android-game` | `3` | `2` | `2` | `2` | `781` | `2025-08-02` | Compact Kotlin Android puzzle game with enough popularity to matter and a manageable footprint for a full first-pass workflow rehearsal | `done` | `gh search repos --language Kotlin --topic game --archived=false --sort stars` |
| `BATCH-2026-05-10-A` | `korlibs/korge` | `engine-framework` | `3` | `3` | `3` | `3` | `2998` | `2026-05-08` | Major Kotlin multiplatform game engine with direct Android relevance and broad engine architecture value | `done` | `gh search repos --language Kotlin --topic game-engine --archived=false --sort stars` |
| `BATCH-2026-05-10-A` | `libktx/ktx` | `library-sdk` | `2` | `3` | `2` | `3` | `1455` | `2025-06-28` | High-signal Kotlin game-dev library for libGDX; likely to contain reusable Kotlin DSL and extension patterns | `done` | `gh search repos --language Kotlin --topic game-engine --archived=false --sort stars` |
| `BATCH-2026-05-10-A` | `utopia-rise/godot-kotlin-jvm` | `library-sdk` | `2` | `2` | `3` | `3` | `920` | `2026-05-08` | Active Kotlin integration for Godot with likely useful patterns for engine binding, build flow, and Kotlin-first game scripting | `done` | `gh search repos --language Kotlin --topic game --archived=false --sort stars` |
| `BATCH-2026-05-10-B` | `littlektframework/littlekt` | `engine-framework` | `3` | `2` | `2` | `3` | `394` | `2026-01-17` | Modern Kotlin multiplatform framework with WebGPU focus and explicit engine-foundation reuse value for future Android-oriented runtimes | `done` | `gh search repos --language Kotlin --topic game-engine --archived=false --sort stars` |
| `BATCH-2026-05-10-B` | `pandulapeter/kubriko` | `engine-framework` | `3` | `2` | `3` | `3` | `237` | `2026-04-29` | Compose Multiplatform-based 2D engine with direct Android target and reusable declarative rendering and lifecycle patterns | `done` | `gh search repos --language Kotlin --topic game-engine --archived=false --sort stars` |
| `BATCH-2026-05-10-B` | `retrowars/retrowars` | `android-game` | `3` | `2` | `2` | `3` | `238` | `2025-10-24` | Android multiplayer game with likely reusable session, control, and minigame-architecture patterns beyond a single gameplay loop | `done` | `gh search repos --language Kotlin --topic game --archived=false --sort stars` |
| `BATCH-2026-05-10-B` | `AlmasB/FXGL` | `engine-framework` | `2` | `3` | `3` | `3` | `4802` | `2026-04-10` | High-signal engine with Kotlin-primary codebase and strong architectural value, included despite broader JavaFX scope because of maturity and ecosystem relevance | `done` | `gh search repos --language Kotlin --topic game-engine --archived=false --sort stars` |
| `BATCH-2026-05-10-C` | `yairm210/Unciv` | `android-game` | `3` | `3` | `3` | `3` | `10353` | `2026-05-10` | Extremely high-value Kotlin strategy game with direct Android and desktop relevance, promoted into a dedicated heavy-repo batch because its footprint is too large for a mixed pass | `done` | `gh search repos --language Kotlin --topic game --archived=false --sort stars` |
| `BATCH-2026-05-10-D` | `TobseF/Candy-Crush-Clone` | `android-game` | `3` | `1` | `2` | `2` | `155` | `2025-10-15` | Direct Android/KorGE game sample with separated game logic, tests, and documented architecture; selected as a lightweight contrast to the heavier `Unciv` batch | `done` | `gh search repos --language Kotlin --topic game --archived=false --sort stars` |
| `BATCH-2026-05-10-E` | `AntonioNoack/RemsEngine` | `engine-framework` | `3` | `1` | `3` | `3` | `39` | `2026-05-10` | Fresh Kotlin engine wildcard with broad rendering, editor, cache, physics, and export surface; selected after rejecting stale popularity-biased alternatives | `done` | `gh search repos "game engine" --language Kotlin --archived=false --sort updated` |
| `BATCH-2026-05-10-F` | `minigdx/tiny` | `engine-framework` | `2` | `1` | `3` | `2` | `155` | `2026-03-29` | Fresh Kotlin engine/runtime candidate with Lua scripting, hot reload, and lightweight architecture that may transfer into Android-friendly tooling and iteration workflows | `done` | `gh search repos --language Kotlin --topic game-engine --archived=false --sort stars` |

## Backlog Candidates

Keep this short. Move only the strongest candidates here.

| Repository | Type | Fit | Popularity | Activity | Yield | Stars | Last Pushed | Why It Might Matter | Source |
|---|---|---|---|---|---|---|---|---|---|
| `Hugobros3/chunkstories` | `engine-framework` | `2` | `2` | `2` | `3` | `223` | `2025-04-21` | Modding-heavy voxel engine/game stack with rendergraph and hot-reload claims; good future candidate if the lab wants a deeper desktop-to-Android transfer reference | `gh search repos --language Kotlin --topic game --archived=false --sort stars` |

## Status Legend

- `queued`: shortlisted but not yet cloned
- `researching`: currently in the active batch
- `done`: research finished and moved to `RESEARCHED_REPOS.md`
- `dropped`: removed from the queue without full research
