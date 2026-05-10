# Session Note - 2026-05-10 - GitHub Research Workflow

## Summary

- Added a dedicated `research/` workflow for scouting, cloning, inspecting, and documenting Kotlin game repositories from GitHub.
- Added queue and history registries to prevent repeated research and keep batches capped at 4 repositories.
- Added a cleanup script and ignored transient research clones in git.
- Initialized the workspace as a local git repository.

## Verified State

- `research/RESEARCH_PLAN.md` is now the canonical runbook for GitHub scouting and investigation.
- Temporary external clones are isolated under `research/worktrees/`.
- Durable outputs are now separated into findings, registries, catalog cards, and project memory.

## Follow-Up

- Populate the first scouting batch in `research/registry/CANDIDATE_QUEUE.md`.
- Run the first real repository investigation cycle and validate the new workflow against actual projects.

## References

- `research/RESEARCH_PLAN.md`
- `research/registry/CANDIDATE_QUEUE.md`
- `research/registry/RESEARCHED_REPOS.md`
- `research/scripts/cleanup-research.ps1`
