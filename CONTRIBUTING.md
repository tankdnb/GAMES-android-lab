# Contributing

This repository is maintained as a research lab for Android-relevant game development projects, with a primary focus on Kotlin.

## What Contributions Are Welcome

- new GitHub research batches
- improvements to existing research notes
- catalog normalization fixes
- better categorization, tagging, or navigation
- workflow and documentation improvements that support repeatable research

## Ground Rules

- Do not replace the repository workflow with a competing structure.
- Reuse the existing catalog, research, and memory files instead of inventing parallel systems.
- Document meaningful work so the repository remains resumable.
- Make a local git commit after each completed work unit.

## Research Contribution Workflow

1. Check `research/registry/RESEARCHED_REPOS.md` first so already investigated repositories are not repeated.
2. Add new candidates to `research/registry/CANDIDATE_QUEUE.md`.
3. Keep the active batch to no more than 4 new repositories.
4. Create a batch note in `research/batches/`.
5. Clone temporary repositories only into `research/worktrees/`.
6. Follow `research/CODE_ANALYSIS_GUIDE.md` for investigation.
7. Write durable findings in `research/findings/`.
8. If a repository is worth keeping, add or update its card under `catalog/projects/` and update `catalog/index.md` plus `catalog/CATEGORY_INDEX.md`.
9. Run `research/scripts/cleanup-research.ps1` after the batch.

## Research Standards

- Prefer verified facts from source code and repository metadata over assumptions.
- Record inspected commit hashes and code paths in research notes.
- If build validation is skipped or times out, document that explicitly.
- Use the normalized category and tag rules from `catalog/CATEGORY_SCHEMA.md`.
- Record rejected or reference-only repositories too, so they are not reselected later.

## Safety Rules

- Treat external repositories as untrusted code.
- Prefer static-first analysis.
- Do not run arbitrary third-party scripts just because a repository suggests them.

## Public Repository Notes

- Public-facing overview lives in `README.md`.
- Public contribution flow lives in this file.
- Internal resumability notes live in `docs/context/`, but repository state always takes priority over stale notes.
