# Research Note

## Repository Snapshot

- Repository: `Saar25/PlanetEngine`
- Source URL: [https://github.com/Saar25/PlanetEngine](https://github.com/Saar25/PlanetEngine)
- Owner: `Saar25`
- Batch ID: [`BATCH-2026-06-04-AG`](../batches/BATCH-2026-06-04-AG.md)
- Type: `engine-framework`
- License: `GPL-3.0`
- Selection date: `2026-06-04`
- Last pushed at selection: `2026-05-29`
- Stars at selection: `7`
- Default branch at selection: `master`
- Investigated commit: `015bd8c61db2a0f08d4144ad60a49e6e9b8d3f90`
- Research status: `accepted`
- Build mode: `static-review + maven-unavailable-local`
- Catalog card: [catalog/projects/saar25-planetengine.md](../../catalog/projects/saar25-planetengine.md)

## Why This Repository Was Selected

- `PlanetEngine` was the strongest remaining candidate in the carry-over exact-license shortlist because it still presents itself as a reusable Kotlin game engine, has explicit GPL-3.0 licensing, and shows fresher repository-level activity than the remaining Android roulette shell or the older fallback engine.
- The main question for this batch was whether the repository is a real engine reference with reusable runtime, rendering, and UI patterns, or mostly a narrow OpenGL hobby sandbox.
- The answer is `accepted`, but with caveats: the code surface is broad enough to matter and contains several reusable engine ideas, yet the direct Android transfer is weak and the visible freshness of the default branch is overstated by activity on the separate `dev` branch.

## Technical Profile

- Main language(s): Java and Kotlin
- Engine / framework: custom LWJGL / OpenGL engine with separate math, low-level binding, core rendering, GUI, and examples modules
- Rendering stack: GLFW windowing + OpenGL + shader-program wrappers + deferred passes + post-processing-ready screen pipeline
- Android target: none found in the inspected default branch
- Build system: Maven multi-module reactor + Kotlin Maven plugin `1.7.20` + Java source or target `11`
- Repository layout summary:
  - `pe-lwjgl-binding/` - strongly typed wrappers for GLFW, OpenGL, OpenAL, Assimp, STB, buffers, and window/input primitives
  - `pe-math/` - vectors, transforms, geometry, and math helpers
  - `pe-core/` - scene nodes, renderers, render paths, lights, meshes, materials, cameras, and component-driven behavior
  - `pe-gui/` - retained-style GUI toolkit with layout, focus, style, text, and components
  - `planet-examples/` - demo applications for rendering, post-processing, normal mapping, GUI, and scene usage
- Source footprint:
  - total files counted in repository: `832`
  - Kotlin or Java files counted in repository: `737`
  - actual test files counted in repository: `0`
- Key modules reviewed:
  - `README.md`
  - `pom.xml`
  - `pe-core/pom.xml`
  - `pe-lwjgl-binding/pom.xml`
  - `pe-math/pom.xml`
  - `pe-gui/pom.xml`
  - `planet-examples/pom.xml`
  - `pe-lwjgl-binding/src/main/java/org/saar/lwjgl/glfw/window/Window.java`
  - `pe-lwjgl-binding/src/main/java/org/saar/lwjgl/opengl/shader/ShaderCode.java`
  - `pe-core/src/main/java/org/saar/core/node/NodeComponent.kt`
  - `pe-core/src/main/java/org/saar/core/node/NodeComponentGroup.kt`
  - `pe-core/src/main/java/org/saar/core/node/ComposableNode.kt`
  - `pe-core/src/main/java/org/saar/core/common/r3d/Node3D.kt`
  - `pe-core/src/main/java/org/saar/core/common/r2d/Renderer2D.kt`
  - `pe-core/src/main/java/org/saar/core/common/r3d/DeferredRenderer3D.kt`
  - `pe-core/src/main/java/org/saar/core/renderer/Renderers.java`
  - `pe-core/src/main/java/org/saar/core/renderer/RendererPrototypeHelper.kt`
  - `pe-core/src/main/java/org/saar/core/renderer/SimpleRenderingPath.kt`
  - `pe-core/src/main/java/org/saar/core/renderer/deferred/DeferredRenderingPath.kt`
  - `pe-core/src/main/java/org/saar/core/renderer/deferred/passes/LightRenderPass.kt`
  - `pe-core/src/main/java/org/saar/core/renderer/deferred/passes/ShadowsRenderPass.kt`
  - `pe-core/src/main/java/org/saar/core/renderer/renderpass/RenderPassPrototypeWrapper.kt`
  - `pe-core/src/main/java/org/saar/core/renderer/uniforms/UniformProperty.java`
  - `pe-core/src/main/java/org/saar/core/renderer/forward/ForwardRenderNodeGroup.kt`
  - `pe-core/src/main/java/org/saar/core/renderer/deferred/DeferredRenderNodeGroup.kt`
  - `pe-core/src/main/java/org/saar/core/renderer/shadow/ShadowsRenderNodeGroup.kt`
  - `pe-core/src/main/java/org/saar/core/common/components/ThirdPersonViewComponent.kt`
  - `pe-gui/src/main/kotlin/org/saar/gui/UIDisplay.kt`
  - `pe-gui/src/main/kotlin/org/saar/gui/UIInputHelper.kt`
  - `pe-gui/src/main/kotlin/org/saar/gui/UIText.kt`
  - `pe-gui/src/main/kotlin/org/saar/gui/component/UIButton.kt`
  - `pe-gui/src/main/kotlin/org/saar/gui/style/WindowStyle.kt`

## Build And Runtime Notes

- The repository was investigated through static code review only plus a local toolchain check.
- The lab environment does not currently provide Maven:
  - `cmd /c mvn -version` fails with `'mvn' is not recognized as an internal or external command`
- The checked-in root `pom.xml` shows the intended compilation floor:
  - Kotlin Maven plugin `1.7.20`
  - Java source `11`
  - Java target `11`
- No Maven wrapper was found in the repository.
- No `.github/workflows/` directory was found in the inspected default branch.
- No actual `src/test` tree or real test suite was found. The only `*Test*` file-name matches in the tree are runtime classes such as `BlendTest.kt`, `DepthTest.kt`, `ClipPlaneTest.kt`, and `StencilTest.kt`, not unit tests.
- A meaningful activity caveat exists:
  - GitHub reports repository-level `pushedAt` `2026-05-29`
  - the cloned default branch `master` resolves to commit `015bd8c...` with committed date `2022-10-28`
  - the fresher visible activity is on `origin/dev`, whose latest visible commit is `714717dd542b74f42a01b4dfc5419fa6238a2fa0` on `2026-05-29` with message `migrated pe-math to only kotlin`
- The result is that the repository is not dead, but the mainline a newcomer gets by default is materially older than the repo-level activity signal implies.

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `1`
- Implementation depth: `3`
- Code clarity: `2`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - `PlanetEngine` earns catalog status because it contains a real engine surface, not just examples: low-level bindings, annotation-driven renderer assembly, scene-node composition, deferred or shadow passes, and a small retained GUI toolkit.
  - Its Android relevance is indirect rather than direct, which keeps the score down, but the rendering and architecture patterns still transfer into Android-oriented internal engines or desktop-side tooling used in Android game production.
  - The main reasons not to rate it higher are the stale default branch, the lack of visible automated verification, no Android host layer, and the inability to validate the Maven build inside the current lab.

## Interesting Findings

### Engine Architecture And Core Loop

- `pe-core/src/main/java/org/saar/core/common/r3d/Node3D.kt` is a good small engine pattern: one node can implement several render interfaces at once, own a `Model3D`, and compose behavior through `NodeComponentGroup` rather than inheritance-heavy subclasses.
- `pe-core/src/main/java/org/saar/core/node/NodeComponent.kt` and `NodeComponentGroup.kt` keep component behavior intentionally simple:
  - `start`
  - `update`
  - `delete`
  - typed component lookup by class or reified Kotlin generic
- `pe-core/src/main/java/org/saar/core/renderer/forward/ForwardRenderNodeGroup.kt`, `DeferredRenderNodeGroup.kt`, and `ShadowsRenderNodeGroup.kt` separate scene traversal by render pass. That is useful when one scene graph needs to participate in several pipelines without one monolithic renderer deciding everything.
- `pe-core/src/main/java/org/saar/core/renderer/SimpleRenderingPath.kt` wraps the full render pass loop around a screen FBO, shared `RenderContext`, and explicit GL state resets. It is a clean reference for how to organize pass-driven rendering without hiding too much inside framework magic.

### Rendering And Graphics

- `pe-core/src/main/java/org/saar/core/renderer/Renderers.java`, `RendererPrototypeHelper.kt`, `RenderPassPrototypeWrapper.kt`, and `UniformProperty.java` form the most reusable architectural seam in the repository:
  - shaders are declared as fields on prototype objects
  - uniforms are tagged with triggers like `ALWAYS`, `PER_INSTANCE`, and `PER_RENDER_CYCLE`
  - helper classes reflect over those declarations and wire the shader program or uniform upload cycle automatically
- `pe-core/src/main/java/org/saar/core/common/r3d/DeferredRenderer3D.kt` shows a clean deferred G-buffer draw path:
  - per-instance specular uniform
  - per-instance MVP matrix
  - per-render-cycle normal matrix
  - explicit GL state toggles before drawing
- `pe-core/src/main/java/org/saar/core/renderer/deferred/passes/LightRenderPass.kt` and `ShadowsRenderPass.kt` show a pass-oriented deferred stack where lighting and shadow evaluation are built as full-screen quad passes over pre-filled buffers, with `ShaderCode.define(...)` used to bake light-count constants into shader compilation.
- `pe-lwjgl-binding/src/main/java/org/saar/lwjgl/opengl/shader/ShaderCode.java` is tiny, but it captures a practical engine-tooling idea: shader source is composed from loaded files plus lightweight generated `#define` values rather than only from handwritten static files.

### Input And Controls

- `pe-lwjgl-binding/src/main/java/org/saar/lwjgl/glfw/window/Window.java` wraps GLFW window, context, keyboard, mouse, resize, and position callbacks behind one strongly typed object instead of exposing raw GLFW state everywhere.
- `pe-gui/src/main/kotlin/org/saar/gui/UIDisplay.kt` pushes raw keyboard and mouse callbacks from the window into the retained UI layer immediately at construction time, which keeps the GUI host contract explicit.
- `pe-gui/src/main/kotlin/org/saar/gui/UIInputHelper.kt` is a compact but useful focus model:
  - hover state
  - pressed state
  - active-element focus
  - drag versus move branching
  - key events gated by focus
- `pe-core/src/main/java/org/saar/core/common/components/ThirdPersonViewComponent.kt` shows the broader component pattern well: components read dependent state once in `start()`, then update transforms each frame without needing a full ECS scheduler.

### UI, HUD, And Menus

- `pe-gui/src/main/kotlin/org/saar/gui/style/WindowStyle.kt` and the surrounding style packages show a CSS-like retained UI direction where width, height, alignment, padding, margin, borders, color modifiers, and font values are all first-class style objects rather than raw coordinates on widgets.
- `pe-gui/src/main/kotlin/org/saar/gui/component/UIButton.kt` is a clean example of componentized retained UI:
  - nested `UIText`
  - pressed-state property
  - hover/press color feedback
  - action callback only when the press-release cycle finishes inside the control
- `pe-gui/src/main/kotlin/org/saar/gui/UIText.kt` derives rendered glyph layout from bound style and content properties, including line wrapping against the current parent width. That is a useful reference for building game UI text systems without jumping straight to HTML or a full desktop toolkit.

### Build, Release, And Testing

- The root `pom.xml` keeps the engine split into meaningful reactor modules rather than one giant jar:
  - low-level bindings
  - math
  - core
  - GUI
  - examples
- `pe-lwjgl-binding/pom.xml` uses Maven OS profiles to select the correct LWJGL native classifier. That is a useful baseline pattern for desktop-first engine repos even if it is not Android-specific.
- The repository currently has several reproducibility weaknesses:
  - no Maven wrapper
  - no visible CI in the inspected default branch
  - no actual tests found
  - local build validation blocked because Maven is unavailable in the lab
- The activity split between `master` and `dev` is itself a build or workflow finding: repository-level recency does not guarantee that the default branch a consumer clones is equally fresh.

## Reusable Takeaways

- Annotation-driven renderer prototypes are a viable middle ground between hand-written GL boilerplate and a much heavier material-graph system.
- Separating forward, deferred, and shadow traversal through typed node groups keeps scene composition simple while still supporting several render paths.
- Strongly typed wrapper layers around GLFW, OpenGL, and shader/uniform plumbing can make raw-LWJGL engines far more readable.
- A retained game UI can stay lightweight if focus, hover, text layout, and widget styling are treated as engine subsystems rather than bolted onto sample code.
- Repository-level GitHub activity signals should be cross-checked against the default branch commit before treating a project as freshly maintained.

## Evidence Summary

- `Node3D.kt`, `NodeComponent.kt`, `NodeComponentGroup.kt`, and the render-node groups - node composition and per-pass scene traversal
- `Renderers.java`, `RendererPrototypeHelper.kt`, `RenderPassPrototypeWrapper.kt`, and `UniformProperty.java` - reflection-driven shader and uniform binding
- `DeferredRenderer3D.kt`, `LightRenderPass.kt`, `ShadowsRenderPass.kt`, `DeferredRenderingPath.kt`, and `SimpleRenderingPath.kt` - deferred rendering, shadowing, and pass orchestration
- `Window.java`, `UIDisplay.kt`, and `UIInputHelper.kt` - typed desktop input plus UI event translation and focus handling
- `WindowStyle.kt`, `UIButton.kt`, and `UIText.kt` - retained GUI styling, controls, and text layout
- root and module `pom.xml` files - Maven module graph, Java 11 target, LWJGL native profiles, and current reproducibility constraints

## Risks Or Limits

- There is no direct Android target in the inspected default branch.
- The default branch `master` looks stale relative to the repository-level `pushedAt` signal; the fresher work is on `origin/dev`.
- No actual test suite was found.
- No visible CI workflows were found.
- The lab cannot validate the Maven build right now because `mvn` is not installed locally.
- The engine surface is large and low-level, so reuse value is strongest for internal engine or tooling work, not for fast Android app-shell adoption.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `engine-framework`
- Focus tags: `3d`, `scene-graph`, `opengl`, `shader`, `input`, `ui-hud`
- Follow-up needed:
  - if the lab revisits this repository, first decide whether to inspect `master` again or switch to the fresher `dev` branch on purpose, then rerun Maven tasks in a Java `11+` environment with Maven installed, or isolate the annotation-driven renderer helpers, the deferred pass stack, or the retained GUI/input system instead of reopening the whole repository broadly
