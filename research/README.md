# Research Workspace

This directory contains the operational workflow for discovering, cloning, studying, and documenting GitHub repositories relevant to Kotlin game development.

## Quick Workflow

1. Use `research/RESEARCH_PLAN.md` to scout candidate repositories.
2. Check `research/registry/CANDIDATE_QUEUE.md` and `research/registry/RESEARCHED_REPOS.md` before selecting anything new.
3. Move at most 4 new repositories into the active batch.
4. Clone each repository into `research/worktrees/`.
5. Study the codebase and write a durable note in `research/findings/`.
6. If the repository is worth keeping in the lab, add a normalized card under `catalog/projects/` and update `catalog/index.md`.
7. Run `research/scripts/cleanup-research.ps1` after the batch to clear temporary clones and throwaway artifacts.

## Directory Layout

- `research/worktrees/`: temporary cloned repositories for active research
- `research/cache/`: temporary exported notes, logs, or cache files
- `research/tmp/`: scratch files created during a batch
- `research/findings/`: durable per-repository research notes
- `research/registry/`: queue, history, and category indexes
- `research/templates/`: research note templates
- `research/scripts/`: cleanup helpers
