# Session Note: KStg Research Batch

## Summary

- Completed `BATCH-2026-07-10-A` for `Koishi-Satori/KStg`.
- Classified the repository as `reference-only`.
- Added durable findings, a catalog card, registry updates, category links, memory updates, cleanup, commit, and push.

## Verified State

- `Koishi-Satori/KStg` is an Apache-2.0 desktop JVM/Kotlin STG engine at commit `d65d9d962903120683aee3d00ce8c828b470121b`.
- Gradle wrapper `7.1`, `gradlew.bat help --no-daemon`, and `gradlew.bat test --dry-run --no-daemon` all succeeded locally under Java `8`.
- No Android target was found.
- Main reusable ideas: fluent bootstrapper, scheduled engine systems, object pools, Java2D buffered rendering, script-loaded assets/audio, subchunk collision filtering, replay recording, plugin jar loading.
- Main caveats: stale activity, desktop-only runtime, unfinished replay playback, suspicious circle-circle collision condition, and broken script-VM division semantics.

## Follow-Up

- Continue the remaining shortlist from `KAMRAN16-byte/Captain-Treasure-Android-Game` and `amirisback/piano-tiles-clone`.
- If `KStg` is revisited, keep it narrow around subchunk collision, resource scripts, replay recording, or a Java2D-to-Android adaptation comparison.

## References

- `research/findings/koishi-satori-kstg.md`
- `catalog/projects/koishi-satori-kstg.md`
- `research/batches/BATCH-2026-07-10-A.md`
- `research/registry/RESEARCHED_REPOS.md`
