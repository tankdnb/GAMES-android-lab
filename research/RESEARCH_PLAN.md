# GitHub Research Plan

## Goal

Build a repeatable workflow for finding Kotlin game and game-engine repositories on GitHub, extracting reusable implementation ideas, and preserving those findings in a structured library.

## Scope

Prioritize repositories that are:

- games written in Kotlin
- game engines or frameworks written in Kotlin
- Android-native Kotlin game projects
- Kotlin-based rendering, tooling, or architecture repositories with clear game-development value

Repositories from other stacks may still be researched only if their Android adaptation value is obvious and worth documenting.

## Batch Rule

- Research no more than 4 new repositories at a time.
- Each batch must contain only repositories that are not already listed in `research/registry/RESEARCHED_REPOS.md`.
- Before cloning anything, record the shortlist in `research/registry/CANDIDATE_QUEUE.md`.
- Create a durable batch note in `research/batches/` before or during the batch.

## Hard Filters

Only shortlist repositories that pass most of these filters:

- public repository
- meaningful Kotlin codebase presence
- clear relevance to game development, game engines, rendering, or game tooling
- readable source code and license information
- not an unchanged mirror or trivial fork
- not already researched

Usually skip:

- archived repositories unless historically important
- tutorial-only repositories with no reusable implementation depth
- repositories with almost no code or no identifiable game-development value

## Discovery Channels

Use GitHub web search or `gh search repos`. The search syntax below is based on GitHub repository search qualifiers such as `language`, `stars`, `pushed`, `topic`, `archived`, and `in:name,description,readme`, plus GitHub CLI repository search filters.

### Seed Query Families

Run these as separate searches and merge the results into the queue:

- `language:Kotlin archived:false topic:game`
- `language:Kotlin archived:false topic:game-engine`
- `language:Kotlin archived:false topic:android-game`
- `"android game" language:Kotlin archived:false in:name,description,readme`
- `"game engine" language:Kotlin archived:false in:name,description,readme`
- `"game framework" language:Kotlin archived:false in:name,description,readme`
- `"libgdx" language:Kotlin archived:false in:name,description,readme`
- `"korge" language:Kotlin archived:false in:name,description,readme`
- `"2d game" language:Kotlin archived:false in:name,description,readme`
- `"3d game" language:Kotlin archived:false in:name,description,readme`

### Sorting Guidance

Use at least two views for each query family:

- popularity-first: highest star count
- activity-first: most recently pushed

This avoids selecting only famous but inactive repositories or only active but low-signal experiments.

## Selection Rubric

Score each candidate before moving it into the active batch.

### Fit Score: 0-3

- `3`: direct Kotlin game, engine, or Android game repository
- `2`: Kotlin repository with clear game-tech relevance
- `1`: partially relevant or cross-stack but still promising
- `0`: weak fit

### Popularity Score: 0-3

- `3`: strong ecosystem signal or high stars for the niche
- `2`: moderate traction
- `1`: low traction but still visible
- `0`: almost no signal

### Activity Score: 0-3

- `3`: pushed recently and clearly active
- `2`: updated within the last year
- `1`: updated within the last two years
- `0`: stale

### Research Yield Score: 0-3

- `3`: likely to contain reusable systems, architecture, engine, or tooling ideas
- `2`: contains some promising patterns
- `1`: mostly simple implementation with narrow reuse value
- `0`: little expected value

Prefer the highest-scoring repositories, but do not use score alone. Keep variety in each batch so the lab learns from different project types.

## Queue Data Standard

For each shortlisted repository, record:

- repository name
- repository type
- fit score
- popularity score
- activity score
- research-yield score
- short reason for selection
- source query or discovery source

## Active Batch Composition

When possible, keep each batch balanced:

- 1 Android-native Kotlin game
- 1 engine, framework, or rendering project
- 1 gameplay-heavy or systems-heavy game project
- 1 wildcard repository with unusual technical value

If the market does not provide all four types, use the best available mix without forcing low-quality picks.

## Research Execution

For each selected repository:

1. Clone into `research/worktrees/<owner>__<repo>/`.
2. Record repository URL, selection date, visible popularity/activity signals, and inspected commit hash.
3. Identify the engine, rendering stack, build system, and platform target.
4. Follow `research/CODE_ANALYSIS_GUIDE.md` for static review, optional build validation, and usefulness assessment.
5. Write a durable note in `research/findings/` using the template in `research/templates/RESEARCH_NOTE_TEMPLATE.md`.

## Batch Outputs

Each finished batch should produce:

- 1 batch note in `research/batches/`
- up to 4 repository findings notes in `research/findings/`
- queue updates in `research/registry/CANDIDATE_QUEUE.md`
- researched history updates in `research/registry/RESEARCHED_REPOS.md`
- category takeaway links in `research/registry/CATEGORY_INDEX.md`
- accepted catalog cards in `catalog/projects/`
- accepted project links in `catalog/index.md` and `catalog/CATEGORY_INDEX.md`

## Required Research Output

A repository only counts as researched when all of the following are done:

- a durable note exists in `research/findings/`
- the repository is added to `research/registry/RESEARCHED_REPOS.md`
- category takeaways are linked in `research/registry/CATEGORY_INDEX.md`
- if worth keeping in the lab, a normalized project card is added under `catalog/projects/`, `catalog/index.md` is updated, and `catalog/CATEGORY_INDEX.md` is updated

## Cleanup Rule

After finishing a batch:

- remove cloned repositories from `research/worktrees/`
- remove temporary scratch files from `research/cache/` and `research/tmp/`
- keep only durable findings, registries, and templates

Use `research/scripts/cleanup-research.ps1` for cleanup.

## Additional Operating Conditions

- Never re-research a repository without first checking whether an earlier note already exists.
- If a repository is inspected and rejected, still record it in `RESEARCHED_REPOS.md` with status `rejected` so it is not reselected later.
- Always store the inspected commit hash and relative code paths in the research note because the local clone will be deleted after cleanup.
- Distinguish between verified findings from the codebase and inferences based on repository metadata.
- Avoid filling the queue with long backlogs. Keep the active batch small and the backlog focused.
- If a repository cannot be built locally, that does not block research, but the limitation must be documented.
- Treat external repositories as untrusted code and prefer static-first analysis.
- Use `catalog/CATEGORY_SCHEMA.md` for accepted project categories and tags instead of inventing ad hoc labels.
