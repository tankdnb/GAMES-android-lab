# GAMES Android Lab

`GAMES Android Lab` is a public research repository for collecting, studying, and systematizing game projects that are useful for Android game development, with a primary focus on Kotlin.

The repository is not just a bookmark list. Its goal is to build a reusable, referenceable library of ideas and implementations that records:

- what each project is
- which ideas and implementations are worth reusing
- which engine, framework, or rendering stack it uses
- how relevant it is to Android game production
- which technical decisions deserve future reuse or comparison
- where the supporting evidence lives so the repository can be cited later from design notes, task discussions, or new game projects

## Current Status

- Research workflow is implemented and documented.
- As of `2026-06-15`, `84` real GitHub research batches are completed end-to-end.
- `90` researched repositories are recorded in `research/registry/RESEARCHED_REPOS.md`.
- Current registry split:
  - `accepted`: `75`
  - `reference-only`: `15`
  - `partial`: `0`
  - `rejected`: `0`
- The latest researched addition is `amirroid/mafiauto` as an `accepted` gameplay-systems reference whose main reusable value is its shared Mafia rules engine, explicit phase-state ownership, delayed role resolution, and direct Android product-shell integration.
- The latest accepted addition is `amirroid/mafiauto`.
- Use `research/registry/RESEARCHED_REPOS.md` and `catalog/index.md` as the live public indexes.

## What Goes Into The Catalog

- Open-source game projects from GitHub
- Experimental game prototypes
- Game engines, frameworks, and rendering demos
- Tooling or architectural examples useful for Android game production

## Entry Standard

Each collected project should have:

- a durable research note
- a normalized catalog card when the repository is worth keeping
- technical metadata
- a summary of reusable ideas
- links to the original repository and supporting evidence
- enough context to be referenced later without reopening the whole external repository

Use the template in `catalog/templates/project-entry-template.md` for consistency.

## Research Workflow

Repository discovery and code investigation happen under `research/`.

1. Shortlist no more than 4 new repositories per batch.
2. Record the active shortlist in `research/registry/CANDIDATE_QUEUE.md`.
3. Create a batch note in `research/batches/`.
4. Clone temporary worktrees into `research/worktrees/`.
5. Review repositories with the static-first method from `research/CODE_ANALYSIS_GUIDE.md`.
6. Write durable findings in `research/findings/`.
7. Promote accepted repositories into `catalog/projects/`, `catalog/index.md`, and `catalog/CATEGORY_INDEX.md`.
8. Clean temporary research artifacts after the batch.

The canonical runbook is [research/RESEARCH_PLAN.md](research/RESEARCH_PLAN.md).

## Quick Links

- [Catalog index](catalog/index.md)
- [Catalog category index](catalog/CATEGORY_INDEX.md)
- [Research plan](research/RESEARCH_PLAN.md)
- [Code analysis guide](research/CODE_ANALYSIS_GUIDE.md)
- [Candidate queue](research/registry/CANDIDATE_QUEUE.md)
- [Researched repository registry](research/registry/RESEARCHED_REPOS.md)

## Repository Layout

- `catalog/index.md` - overview table of collected projects
- `catalog/CATEGORY_SCHEMA.md` - normalized categories and focus tags
- `catalog/CATEGORY_INDEX.md` - accepted projects grouped by category
- `catalog/projects/` - normalized per-project catalog cards
- `catalog/templates/project-entry-template.md` - template for project entries
- `docs/context/CONTEXT_INDEX.md` - entry point for internal project memory
- `docs/context/PROJECT_BRIEF.md` - durable description of the lab and its goals
- `research/` - research workspace, findings, queue, and cleanup tooling

## Operating Rules

- Research only repositories that are not already recorded in `research/registry/RESEARCHED_REPOS.md`.
- Keep each research batch small enough to document thoroughly.
- Distinguish verified code findings from metadata-level inference.
- Treat external repositories as untrusted code and prefer static-first analysis.
- Document every meaningful session so the repository remains resumable.
- Make a local git commit after each completed work unit.
- Write notes and catalog cards so they work as future reference material, not only as session output.
- After each completed research batch, prepare the durable outputs for public consumption and push them to GitHub.

## Selection Criteria

Projects are especially valuable when they:

- are directly built for Android
- use Kotlin or are easy to adapt to Kotlin-based Android workflows
- demonstrate interesting gameplay systems or rendering approaches
- contain reusable technical patterns
- are well-structured and documented

## Contributing

Contribution guidelines for new research batches, catalog updates, and documentation changes live in [CONTRIBUTING.md](CONTRIBUTING.md).
