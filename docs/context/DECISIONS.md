# Decisions

## 2026-05-10 - Use `docs/context/` as the canonical file-memory root

- Status: accepted
- Why: the repository had only a minimal context file and no competing memory system, so extending `docs/context/` keeps memory compact and discoverable.
- Implication: future durable context should be added to this tree instead of introducing parallel note locations.

## 2026-05-10 - Keep root `AGENTS.md` short and route larger context into memory files

- Status: accepted
- Why: repository instructions should stay readable and stable, while longer-lived operational context belongs in dedicated memory files.
- Implication: `AGENTS.md` should describe rules and routing, not become a large knowledge dump.

## 2026-05-10 - Keep `project-overview.md` as a compatibility alias

- Status: accepted
- Why: existing repository references already pointed to `docs/context/project-overview.md`.
- Implication: the canonical brief now lives in `docs/context/PROJECT_BRIEF.md`, but the legacy file remains to avoid broken references.

## 2026-05-10 - Catalog entries must preserve reusable technical context, not just links

- Status: accepted
- Why: the project goal is to build a usable research library, not a bookmark list.
- Implication: each project entry must capture description, stack, Android relevance, reusable ideas, and notable implementations.

## 2026-05-10 - Document every meaningful session and commit each completed work unit locally

- Status: accepted
- Why: the team wants durable traceability of what changed and does not want to rely on chat history or memory.
- Implication: meaningful work must be reflected in project memory files, and once git is initialized in this workspace, each completed work unit should end with a local commit.

## 2026-05-10 - Research new GitHub repositories in batches of no more than 4

- Status: accepted
- Why: the repository should favor focused, high-quality investigation over broad shallow intake.
- Implication: candidate selection must be filtered through the queue, and each batch should stay small enough to document thoroughly.

## 2026-05-10 - Separate transient clones from durable research outputs

- Status: accepted
- Why: external repositories are needed for code inspection, but they should not pollute the main repository history.
- Implication: clones live only in `research/worktrees/`, temporary artifacts live in `research/cache/` and `research/tmp/`, and durable outputs live in findings, registries, and catalog files.

## 2026-05-10 - Record every investigated repository, including rejected ones

- Status: accepted
- Why: avoiding duplicate work is part of the repository's value.
- Implication: `research/registry/RESEARCHED_REPOS.md` is the source of truth for already investigated repositories, even when the verdict is rejection or partial research.

## 2026-05-10 - Store accepted project cards separately from raw research notes

- Status: accepted
- Why: raw research notes are operational and detailed, while catalog cards should stay normalized and easier to scan.
- Implication: accepted repositories get a detailed note in `research/findings/` and a normalized card in `catalog/projects/`.
