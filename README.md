# GAMES Android Lab

`GAMES Android Lab` is a research repository for collecting and systematizing interesting game projects that can be useful for Android game development, with an emphasis on Kotlin-based work.

The purpose of the repository is not only to save links, but to build a reusable knowledge base:

- what each project is about
- which ideas are worth reusing
- which engine, framework, or rendering approach it uses
- how relevant it is for Android development
- which technical implementations are noteworthy

## What Goes Into The Catalog

- Open-source game projects from GitHub
- Experimental game prototypes
- Game engines, frameworks, and rendering demos
- Tooling or architectural examples useful for Android game production

## Entry Standard

Each collected project should have:

- a dedicated card or note
- a short explanation of the project
- technical metadata
- a summary of reusable ideas
- links to the original repository and related materials

Use the template in `catalog/templates/project-entry-template.md` for consistency.

## Research Workflow

Repository discovery and code investigation happen in `research/`.

- shortlist no more than 4 new Kotlin game or game-engine repositories per batch
- clone them into `research/worktrees/`
- inspect code and extract reusable ideas
- write durable findings before deleting temporary clones
- track researched repositories so the next batch continues from new material

## Repository Layout

- `catalog/index.md` - overview table of collected projects
- `catalog/CATEGORY_SCHEMA.md` - normalized categories and focus tags
- `catalog/CATEGORY_INDEX.md` - accepted projects grouped by category
- `catalog/projects/` - normalized per-project catalog cards
- `catalog/templates/project-entry-template.md` - template for project entries
- `docs/context/CONTEXT_INDEX.md` - entry point for internal project memory
- `docs/context/PROJECT_BRIEF.md` - durable description of the lab and its goals
- `research/` - research workspace, findings, queue, and cleanup tooling

## Selection Criteria

Projects are especially valuable when they:

- are directly built for Android
- use Kotlin or are easy to adapt to Kotlin-based Android workflows
- demonstrate interesting gameplay systems or rendering approaches
- contain reusable technical patterns
- are well-structured and documented
