# Repository Code Analysis Guide

Use this guide when investigating cloned repositories in `research/worktrees/`.

## Goal

Determine whether a repository contains reusable Kotlin game-development ideas, and capture those findings in a way that remains useful after the clone is deleted.

## Safety Rules

- Treat downloaded repositories as untrusted code.
- Start with static analysis before executing anything.
- Read `README`, license files, Gradle files, wrapper files, and scripts before running build commands.
- Do not run arbitrary install scripts or shell scripts just because the repository suggests them.
- Prefer low-risk commands first, such as listing files, reading docs, and inspecting `build.gradle`, `settings.gradle`, `gradle.properties`, or Gradle Kotlin DSL files.
- If execution is needed, prefer discovery commands such as `./gradlew tasks`, `./gradlew help`, or a targeted module build before any full run.
- Record whether conclusions came from metadata only, static code review, build validation, or runtime validation.

## Investigation Flow

### 1. Metadata Pass

Capture:

- repository purpose from `README`
- license
- active branch and inspected commit
- stars and last pushed date at selection time
- platform claims
- engine or framework claims

Goal: confirm the repository belongs in the batch and understand what it claims to do.

### 2. Structure Mapping Pass

Map the repository layout before deep reading:

- root directories
- Gradle modules
- Android app modules
- engine or core modules
- assets, data, or editor directories
- tests, samples, or benchmark modules

Goal: identify where meaningful implementation work lives.

### 3. Hotspot Search Pass

Use targeted code search to find the most important systems quickly.

Typical search targets:

- `render`
- `update`
- `tick`
- `scene`
- `world`
- `entity`
- `component`
- `system`
- `input`
- `touch`
- `collision`
- `physics`
- `shader`
- `camera`
- `animation`
- `audio`
- `save`
- `network`

Goal: find likely high-value files before reading everything.

### 4. Subsystem Review Pass

Review the repository by subsystem, not file order.

Main subsystems to inspect:

- engine/core loop
- rendering and graphics
- gameplay and world rules
- scene management or ECS
- input mapping and Android controls
- UI and HUD
- physics and collision
- audio
- save/load and data
- AI or behavior logic
- networking
- tooling and content pipeline
- Android integration
- performance techniques

Goal: extract reusable design ideas, not just summarize file names.

### 5. Optional Build Pass

Only do this after the repository looks relevant and safe enough.

Suggested order:

1. Gradle discovery command
2. targeted module build
3. tests if they exist and are clearly scoped
4. runtime launch only when it adds clear research value

If build or run steps are skipped, state that explicitly in the note.

### 6. Usefulness Assessment Pass

Score the repository on dimensions that matter for reuse:

- `reuse-potential` 0-3
- `android-transfer` 0-3
- `implementation-depth` 0-3
- `code-clarity` 0-3
- `novelty` 0-3

Use scores as guidance, not as a rigid formula.

Suggested interpretation:

- `12-15`: strong candidate for catalog acceptance
- `8-11`: useful, but requires judgment or narrower categorization
- `0-7`: likely reject or keep as reference-only unless uniquely important

## Evidence Standard

Every meaningful finding should include:

- relative file path
- class, function, or subsystem name when identifiable
- what the code does
- why it matters for Android or Kotlin game development
- whether the conclusion is verified from code or inferred from metadata

Avoid vague statements like "good architecture" without code evidence.

## What Counts As A Good Finding

Good findings usually have at least one of these properties:

- transferable into another Android game project
- unusually clear or elegant implementation
- solves a common game-development problem
- demonstrates a strong tradeoff or architectural decision
- shows a Kotlin-specific or Android-specific technique worth reusing

## Final Verdict Options

- `accepted`: belongs in the main catalog
- `reference-only`: useful for comparison or niche ideas
- `partial`: promising but not fully investigated yet
- `rejected`: not worth continued attention for this lab

The verdict must be reflected consistently in the research note, researched registry, and catalog outputs.
