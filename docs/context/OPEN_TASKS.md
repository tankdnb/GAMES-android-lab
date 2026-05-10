# Open Tasks

## Active

- Choose the root repository license for the already-public GitHub repository.
- Refresh GitHub search results and prepare the next lightweight batch from not-yet-researched Kotlin game or game-engine repositories.
- Keep following the publication rule: after each completed research batch, prepare the durable outputs and push them to GitHub.
- A minute-based heartbeat automation `games-android-lab-research` is active for this thread; monitor whether the cadence remains useful or should be paused/slowed.

## Next Recommended

- Prefer fresh queue refreshes over carrying stale backlog rows; shortlist one or two newer Kotlin game/game-engine repositories with good architecture depth and reasonable Android transfer value, and keep `sreich/ore-infinium` only as a later systems-heavy backlog candidate rather than a default next pick.
- If `Quilly-s-Adventure` needs a future follow-up, verify `:core:test` and target builds in a Java `11+` environment, or isolate one subsystem such as the trigger DSL or Tiled-to-ECS map flow instead of reopening the whole repository broadly.
- If `chunkstories` needs a future follow-up, scope it narrowly to the rendergraph/shader path, the mod/plugin loader, or the content-translator and mod-sync path rather than reopening the whole repository.
- If `Unciv` needs a future follow-up, scope it narrowly to map generation, server internals, or another single subsystem instead of repeating a full heavy batch.
- If `RemsEngine` needs a future follow-up, target a single subsystem such as export, render graph tooling, or Android-adjacent porting details.
- If `minigdx/tiny` needs a future follow-up, scope it to tooling internals such as the debugger/web editor protocol or later mobile-target work rather than reopening the whole repository blindly.
- If `Terrarum` needs a future follow-up, target one subsystem such as module loading, world generation, or the light/weather pipeline rather than reopening the full workspace.
- If `korlibs/korge-fleks` needs a future follow-up, verify `commonTest` and the live asset-reload path in a Java `21+` environment instead of reopening the whole repository for another broad static pass.
- When a batch is finished, ensure findings, registry updates, catalog cards, cleanup, commit, and GitHub push are all completed in the same work cycle.

## Deferred

- Deeper subsystem follow-up inside already accepted repositories unless future product work needs it.
- More aggressive third-party build execution until the lightweight static-first workflow proves worth extending.
