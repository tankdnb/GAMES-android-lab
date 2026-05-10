# Project Brief

## Purpose

This repository is a research lab and curated library for collecting game development projects that are useful for Android development.

The primary focus is Android game work in Kotlin. The catalog may also include projects from other stacks when they contain ideas, implementations, or architecture that can be reused in Android game development.

## Repository Goal

Build a practical reference library that explains, for each collected project:

- what the project is
- why it is interesting
- which technical ideas it demonstrates
- how its solutions could be reused in Android game development

## What Must Be Documented Per Project

- project name and source link
- short description
- engine, framework, or rendering stack
- main language(s)
- Android relevance
- key reusable ideas
- notable technical implementations
- license
- repository activity or maintenance status when verifiable

## Current Verified State

- The repository now contains documentation, catalog structure, and an exercised research workflow.
- The first completed GitHub research batch is documented under `research/batches/BATCH-2026-05-10-A.md`.
- Four researched repositories are recorded in `research/registry/RESEARCHED_REPOS.md`.
- Four public-facing catalog cards are present under `catalog/projects/`.
- Public-facing repository guidance now lives in root `README.md` and `CONTRIBUTING.md`.
- Local repository hygiene now includes root `.gitattributes`, expanded `.gitignore`, and default branch `main`.
- Temporary research worktrees are cleaned after each completed batch.
- The workspace is initialized as a local git repository.

## Important Paths

- `AGENTS.md`
- `README.md`
- `catalog/CATEGORY_SCHEMA.md`
- `catalog/CATEGORY_INDEX.md`
- `catalog/index.md`
- `catalog/projects/`
- `catalog/templates/project-entry-template.md`
- `docs/context/`
- `research/`

## Selection Guidance

Projects are especially valuable when they:

- are directly built for Android
- use Kotlin or map cleanly to Kotlin-based Android workflows
- demonstrate reusable gameplay systems, rendering techniques, or tooling patterns
- are structured clearly enough to be studied and referenced later

## Research Workflow Summary

- Discovery and code analysis happen under `research/`.
- New repositories are researched in batches of up to 4.
- Each batch gets its own note under `research/batches/`.
- Temporary clones live in `research/worktrees/` and are cleaned after findings are preserved.
- Durable outputs are the batch notes, findings notes, researched registry, category indexes, and catalog cards for accepted repositories.
- Accepted projects use the normalized category rules in `catalog/CATEGORY_SCHEMA.md`.
