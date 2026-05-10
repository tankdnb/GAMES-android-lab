# Catalog Category Schema

Use this schema to classify accepted repositories consistently.

## Rules

- Every accepted catalog card must have exactly 1 primary category.
- Every accepted catalog card may also have 0 or more focus tags.
- Reuse the tags from this file instead of inventing new wording each time.
- If a repository fits multiple primary categories, choose the one that best describes its main research value.

## Primary Categories

- `android-game`: a Kotlin game project with direct Android relevance as the main product
- `engine-framework`: a reusable game engine, framework, or runtime foundation
- `rendering-demo`: a repository whose main value is graphics, rendering, shaders, or visual pipeline work
- `gameplay-systems`: a repository whose main value is game logic, combat, progression, world systems, or simulation
- `tooling-pipeline`: a repository focused on tools, editors, asset workflows, or content pipelines
- `library-sdk`: a reusable Kotlin library with direct game-development value
- `reference-only`: interesting technically, but not strong enough for full adoption as a main catalog model

## Focus Tags

Use the smallest useful set.

- `2d`
- `3d`
- `android`
- `multiplatform`
- `ecs`
- `scene-graph`
- `libgdx`
- `korge`
- `opengl`
- `shader`
- `physics`
- `collision`
- `ui-hud`
- `input`
- `audio`
- `ai`
- `networking`
- `save-load`
- `procedural-generation`
- `editor-tools`
- `asset-pipeline`
- `performance`
- `testing`

## Examples

- A LibGDX Android game: primary category `android-game`, focus tags `2d`, `android`, `libgdx`
- A Kotlin rendering playground: primary category `rendering-demo`, focus tags `3d`, `opengl`, `shader`
- A content editor for a Kotlin game framework: primary category `tooling-pipeline`, focus tags `editor-tools`, `asset-pipeline`
