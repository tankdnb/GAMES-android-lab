# Open Tasks

## Active

- Choose the root repository license for the already-public GitHub repository.
- Refresh GitHub search results and prepare the next lightweight batch from not-yet-researched Kotlin game or game-engine repositories.
- Keep following the publication rule: after each completed research batch, prepare the durable outputs and push them to GitHub.
- A minute-based heartbeat automation `games-android-lab-research` is active for this thread; monitor whether the cadence remains useful or should be paused/slowed.

## Next Recommended

- Fresh activity-sorted Android-game results are still mostly zero-signal; unless better candidates appear on the next refresh, prefer `zeganstyl/thelema-engine` or `sreich/ore-infinium` as the next stronger backlog and keep `kotcity/kotcity` plus `wajahatkarim3/DinoCompose` as secondary alternatives.
- If `Quilly-s-Adventure` needs a future follow-up, verify `:core:test` and target builds in a Java `11+` environment, or isolate one subsystem such as the trigger DSL or Tiled-to-ECS map flow instead of reopening the whole repository broadly.
- If `Darkest Pixel Dungeon` needs a future follow-up, isolate one subsystem such as the actor scheduler, procedural dungeon pipeline, or split save-slot architecture rather than reopening the whole repository broadly.
- If `Neon` needs a future follow-up, isolate one subsystem such as the `tinker` scheduler, stage progression, or controller-based collision/powerup flow, or rerun the unit-test surface in a Java `11+` or `17` environment.
- If `compose-game` needs a future follow-up, isolate one subsystem such as the analytical collision math or the render/API seam around the `GameEngineImpl` downcast, or rerun the build/publication path in a Java `17` JDK environment.
- If `minigdx/minigdx` needs a future follow-up, isolate one subsystem such as the Android multitouch adapter or the coroutine script helpers, or rerun build/test verification in a Java `11` environment.
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
