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

## Backlog Candidates

Keep this short. Move only the strongest candidates here.

| Repository | Type | Fit | Popularity | Activity | Yield | Stars | Last Pushed | Why It Might Matter | Source |
|---|---|---|---|---|---|---|---|---|---|
| `littlektframework/littlekt` | `engine-framework` | `3` | `2` | `2` | `3` | `394` | `2026-01-17` | Modern multiplatform WebGPU-focused Kotlin framework worth researching after the first batch | `gh search repos --language Kotlin --topic game-engine --archived=false --sort stars` |
| `yairm210/Unciv` | `android-game` | `3` | `3` | `3` | `3` | `10353` | `2026-05-10` | Extremely high-value Kotlin strategy game, but too large for a lightweight first rehearsal batch and should be scheduled as a dedicated heavy-repo pass | `gh search repos --language Kotlin --topic game --archived=false --sort stars` |

## Status Legend

- `queued`: shortlisted but not yet cloned
- `researching`: currently in the active batch
- `done`: research finished and moved to `RESEARCHED_REPOS.md`
- `dropped`: removed from the queue without full research
