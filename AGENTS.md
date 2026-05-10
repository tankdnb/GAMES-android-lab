# GAMES Android Lab

## Project Intent

- This repository is a research lab and curated library of game-related Android projects.
- Primary focus: projects useful for Android game development with Kotlin.
- Source of discovery: public GitHub repositories and other openly accessible project references.

## Working Rules

- Merge into the existing memory structure; do not create competing instruction systems.
- Document every meaningful work session so the repository preserves what was done and why.
- Run GitHub repository research in batches of no more than 4 new repositories at a time.
- Every collected project must have a dedicated entry with structured metadata.
- Each entry should explain what the project is, what ideas or implementations are reusable, and why it is interesting for the lab.
- Prefer verified facts from the source repository over assumptions.
- If a project is not Android-native but contains ideas relevant to Android game development, document that explicitly.
- Clone transient research repositories only into `research/worktrees/` and clean them after findings are documented.
- Distill reusable context into memory files; do not store raw chat transcripts there.
- Make a local git commit after each completed work unit once this workspace is initialized as a git repository.

## Required Metadata Per Project

- Project name and source link
- Short description
- Engine, framework, or rendering stack
- Main language(s)
- Android relevance
- Key ideas worth reusing
- Notable technical implementations
- Repository activity or maintenance status when verifiable
- License

## Memory Routing

- Start with `docs/context/CONTEXT_INDEX.md`.
- Canonical file-backed memory lives in `docs/context/`.
- Use `research/RESEARCH_PLAN.md` as the runbook for GitHub scouting and repository analysis.
- Check `research/registry/CANDIDATE_QUEUE.md` and `research/registry/RESEARCHED_REPOS.md` before selecting new repositories.
- Update `docs/context/HANDOFF.md` after meaningful sessions.
- Update `docs/context/OPEN_TASKS.md` when active priorities change.
- Record durable repository or workflow decisions in `docs/context/DECISIONS.md`.
- Add a short session note in `docs/context/sessions/` when it preserves useful local context from the current work.
- `docs/context/project-overview.md` is kept as a legacy alias; the canonical project brief is `docs/context/PROJECT_BRIEF.md`.

## Repository Structure

- `README.md`: public overview of the lab
- `docs/context/CONTEXT_INDEX.md`: entry point for project memory
- `docs/context/PROJECT_BRIEF.md`: durable project brief
- `docs/context/HANDOFF.md`: current verified handoff state
- `docs/context/OPEN_TASKS.md`: active work queue
- `docs/context/DECISIONS.md`: durable decisions
- `catalog/index.md`: high-level list of collected projects
- `catalog/templates/project-entry-template.md`: standard entry template
- `research/`: scouting, temporary clones, findings, and research registries
