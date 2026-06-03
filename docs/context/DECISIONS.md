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

## 2026-05-10 - Use a normalized category schema for accepted catalog entries

- Status: accepted
- Why: free-form categories would quickly drift and make the catalog inconsistent.
- Implication: accepted projects must use `catalog/CATEGORY_SCHEMA.md` and be linked in `catalog/CATEGORY_INDEX.md`.

## 2026-05-10 - Keep one durable note per research batch

- Status: accepted
- Why: repository-level notes are not enough to explain how a batch was discovered, balanced, and judged.
- Implication: each scouting and research cycle should create a batch note in `research/batches/`.

## 2026-05-10 - Analyze external repositories with a static-first code review workflow

- Status: accepted
- Why: the lab needs consistent, evidence-based findings while minimizing risk from arbitrary third-party code execution.
- Implication: cloned repositories should be inspected through `research/CODE_ANALYSIS_GUIDE.md`, with build or runtime execution treated as optional and explicitly documented.

## 2026-05-10 - Treat Gradle discovery timeout as a valid documented research outcome

- Status: accepted
- Why: the first real batch showed that third-party Kotlin game repositories can still be highly valuable even when a lightweight `gradlew help` attempt times out.
- Implication: `Build Mode` must record the exact level of validation, and research may continue from static evidence instead of forcing full build success.

## 2026-05-10 - Put oversized repositories into dedicated heavy-repo batches

- Status: accepted
- Why: `yairm210/Unciv` had strong research value but proved too large for a lightweight first rehearsal batch.
- Implication: footprint should be checked early, and very large repositories should be isolated from balanced mixed batches.

## 2026-05-10 - Use `main` as the default branch for public publication

- Status: accepted
- Why: the repository is being prepared for public GitHub publication and should use the modern default branch name.
- Implication: future public pushes should target `main`, and new remote defaults should align with it.

## 2026-05-10 - Keep public-facing repository workflow in root `README.md` and `CONTRIBUTING.md`

- Status: accepted
- Why: public GitHub visitors need a clean entry point without reading internal memory files first.
- Implication: root docs should explain repository purpose, contribution flow, and research workflow, while deeper operational memory remains under `docs/context/`.

## 2026-05-10 - Treat the repository as a referenceable library of game-development ideas

- Status: accepted
- Why: the repository is meant to be cited later during design and implementation work, not only used as an internal research scratchpad.
- Implication: research notes, catalog cards, and public docs should preserve enough distilled evidence and context to be referenced without reopening the full external repository.

## 2026-05-10 - Push completed research batches to GitHub after preparation

- Status: accepted
- Why: finished research should become publicly available as part of the repository's normal operating cycle, not remain only in local history.
- Implication: after each completed research batch, the durable outputs should be cleaned up, prepared for public readability, committed locally, and pushed to GitHub.

## 2026-06-03 - Prefer explicit GitHub license metadata when refreshing the short backlog

- Status: accepted
- Why: the carry-over candidate `Efimj/GameOfLife` still exposed `licenseInfo: null` on GitHub during the latest shortlist review, and the team chose conservative reuse confidence over ambiguous licensing.
- Implication: shortlist refreshes should prefer repositories with explicit license metadata and drop ambiguous-license candidates from the short backlog unless there is a stronger reason to inspect them anyway.
