# Research Note

## Repository Snapshot

- Repository: `johron/glare`
- Source URL: [https://github.com/johron/glare](https://github.com/johron/glare)
- Owner: `johron`
- Batch ID: [`BATCH-2026-06-04-H`](../batches/BATCH-2026-06-04-H.md)
- Type: `engine-framework`
- License: `MIT`
- Selection date: `2026-06-04`
- Last pushed at selection: `2025-09-01`
- Stars at selection: `4`
- Investigated commit: `3593e76e29399928b798b14aa79aa7295b360701`
- Research status: `reference-only`
- Build mode: `static-review + gradle-help + build-dry-run-with-toolchain22-warning`
- Catalog card: [catalog/projects/johron-glare.md](../../catalog/projects/johron-glare.md)

## Why This Repository Was Selected

- `glare` was the strongest remaining candidate in the carry-over explicit-license shortlist after `benpollarduk/ktvn`.
- Even with very low public signal, it promised a compact Kotlin engine surface with a real loop, a scene/node model, an OpenGL renderer, and an in-process editor shell.
- The main question for this batch was whether it should be kept as a primary engine reference or only as a comparison sample. Static review points to the latter.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: custom Kotlin JVM engine with a node/component scene graph, LWJGL runtime, and ImGui-based editor shell
- Rendering stack: LWJGL + OpenGL + JOML + ImGui Java
- Android target: none found in the checked-in build or runtime; despite the README wording, the inspected tree is desktop JVM-first
- Build system: single-module Gradle Groovy DSL app with generated constants, separate engine/editor jar tasks, and JDK `22` toolchain settings
- Repository layout summary: root Gradle app plus `src/main` engine/editor/runtime code and `src/test` demo harness plus bundled models, shaders, and textures
- Source footprint:
  - total files counted in repository: `90`
  - Kotlin/Java/build-script files counted in repository: `51`
- Test surface:
  - Kotlin files under `src/test/kotlin`: `2`
  - files under `src/test/resources`: `14`
  - meaningful automated assertion-heavy engine tests found: `0`
- Key modules reviewed:
  - `README.md`
  - `build.gradle`
  - `settings.gradle`
  - `gradle.properties`
  - `.github/workflows/gradle.yml`
  - `src/main/kotlin/me/johanrong/glare/engine/core/Engine.kt`
  - `src/main/kotlin/me/johanrong/glare/engine/core/Node.kt`
  - `src/main/kotlin/me/johanrong/glare/engine/core/Physics.kt`
  - `src/main/kotlin/me/johanrong/glare/engine/core/Window.kt`
  - `src/main/kotlin/me/johanrong/glare/engine/io/Input.kt`
  - `src/main/kotlin/me/johanrong/glare/engine/component/Component.kt`
  - `src/main/kotlin/me/johanrong/glare/engine/component/graphics/MeshComponent.kt`
  - `src/main/kotlin/me/johanrong/glare/engine/component/graphics/TextureComponent.kt`
  - `src/main/kotlin/me/johanrong/glare/engine/component/graphics/ShaderComponent.kt`
  - `src/main/kotlin/me/johanrong/glare/engine/component/physics/RigidbodyComponent.kt`
  - `src/main/kotlin/me/johanrong/glare/engine/component/physics/collision/BoxColliderComponent.kt`
  - `src/main/kotlin/me/johanrong/glare/engine/render/Renderer.kt`
  - `src/main/kotlin/me/johanrong/glare/engine/render/MeshRenderer.kt`
  - `src/main/kotlin/me/johanrong/glare/engine/render/LightRenderer.kt`
  - `src/main/kotlin/me/johanrong/glare/engine/render/ImGuiRenderer.kt`
  - `src/main/kotlin/me/johanrong/glare/editor/Editor.kt`
  - `src/main/kotlin/me/johanrong/glare/editor/ui/panel/ExplorerPanel.kt`
  - `src/main/kotlin/me/johanrong/glare/editor/ui/panel/PropertiesPanel.kt`
  - `src/test/kotlin/test/Test.kt`
  - `src/test/kotlin/test/FreecamScript.kt`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeds and reports Gradle `8.10.2` on the current lab machine.
- `cmd /c gradlew.bat help --no-daemon` succeeds, which makes this repo easier to inspect than many recent Android or KorGE stacks in the lab.
- `cmd /c gradlew.bat build --dry-run --no-daemon` also succeeds, but only as task-graph discovery:
  - Gradle warns about an invalid auto-provisioned JDK `22` installation under the local `.gradle` cache
  - no real compile, test, or runtime execution was attempted
- The checked-in build surface itself clearly expects a newer JVM than the current lab runtime:
  - Kotlin JVM plugin `2.1.20`
  - `kotlin { jvmToolchain(22) }`
  - CI workflow pinned to JDK `22`
- No live runtime launch was attempted.

## Usefulness Assessment

- Reuse potential: `2`
- Android transfer: `1`
- Implementation depth: `2`
- Code clarity: `2`
- Novelty: `2`
- Overall verdict: `reference-only`
- Why:
  - `glare` has a few compact ideas worth preserving: dependency-aware node/component wiring, a fixed-step loop wrapped around a simple runtime shell, a shader-backed node renderer, and an editor living inside the same process as the engine.
  - At the same time, the inspected revision is not mature enough to treat as a primary engine baseline for the lab.
  - It is more valuable as a comparison sample and cautionary reference than as a recommended foundation.

## Interesting Findings

### Engine Architecture And Core Loop

- `Engine.kt` owns the whole runtime directly: it creates the root node, input, physics, renderer, window, and panels, then enters a loop that updates scripts, flushes queued node additions, renders, and runs fixed-step physics at `60` Hz through an accumulator.
- `Node.kt` is the stronger architectural piece in the repo. It keeps a parent/child tree, stores components directly on the node, and auto-adds missing component dependencies by mapping dependency enums back into component instances.
- `Node.builder { ... }` refuses parentless nodes except for the root, which keeps the tree shape explicit instead of letting detached scene objects drift around.
- Non-root nodes automatically receive a `ScriptsComponent` if one was not provided, which makes script attachment the default runtime behavior rather than a special case.
- `Editor.kt` is implemented as a normal engine script and mounts `ExplorerPanel` plus `PropertiesPanel` into the same runtime. That editor-in-runtime pattern is one of the more reusable ideas in the repository.

### Rendering And Graphics

- `Renderer.kt` keeps the render path very small: clear, check camera, bind the node shader, then dispatch through `LightRenderer`, `MeshRenderer`, and `ImGuiRenderer`.
- `ShaderComponent.kt` is a practical small-engine example of multi-stage shader setup. It supports vertex, fragment, geometry, tessellation, and compute stages, links them into one GL program, and caches uniform lookups.
- `MeshComponent.kt` loads `.obj` meshes directly into a VAO/VBO layout and makes mesh resources normal scene components instead of separate asset-manager entries.
- `ImGuiRenderer.kt` uses a dockspace window and renders editor panels in the same frame as the 3D scene, which is a useful compact reference for immediate-mode tooling inside a custom engine.
- The main rendering caveat is structural: `Renderer.render()` only walks `engine.root.getChildren()` and does not recurse through the whole scene tree, so nested nodes are not treated as first-class renderables in the current checked-in path.

### Input And Controls

- `Input.kt` is thin but readable: it polls GLFW directly, keeps a small pressed-key set for edge detection, and suppresses held-key gameplay input while ImGui widgets are active.
- `FreecamScript.kt` is a clean example of script-owned editor camera motion using yaw-relative movement plus right-mouse look based on per-frame mouse delta.
- The input stack is desktop-only in the inspected revision, but the separation between raw polling and script-level behavior is still reusable.

### Tooling, Editor, And Content Pipeline

- `ExplorerPanel.kt` and `PropertiesPanel.kt` show the intended editor loop clearly: build or select nodes, publish selection events, then inspect or mutate transform/components/scripts through reflected property fields.
- `generateConstants` writes a `GeneratedConstants.kt` file before compile, which is a lightweight but reusable way to centralize generated engine constants without introducing a larger codegen toolchain.
- The build intentionally emits two artifacts from one module:
  - `buildEngine` packages the runtime-facing jar
  - the main `jar` task builds the editor-facing jar
- The CI workflow mirrors that split and uploads both artifacts, which gives the repo stronger tooling discipline than its runtime maturity would suggest.

## Reusable Takeaways

- A compact node/component runtime can stay readable if dependency rules are encoded close to the component enum and enforced when nodes are assembled.
- Embedding the editor into the same engine runtime can keep inspection and authoring loops simple for small tools, especially when immediate-mode UI is acceptable.
- Separate engine and editor artifacts can still be generated from one small Gradle application if the packaging boundaries are explicit.
- A repository can look stronger at the build/tooling layer than at the runtime layer; the lab should keep treating those two signals separately.

## Evidence Summary

- `Engine.kt`, `Node.kt`, `Editor.kt` - compact loop ownership, queued node insertion, dependency-aware node/component assembly, and editor-as-script pattern
- `Renderer.kt`, `MeshRenderer.kt`, `ShaderComponent.kt`, `ImGuiRenderer.kt` - minimal OpenGL renderer with per-node shaders and docked ImGui tooling
- `Input.kt`, `FreecamScript.kt` - direct GLFW polling with editor-aware suppression and script-level camera behavior
- `build.gradle`, `.github/workflows/gradle.yml` - generated constants, split engine/editor jars, JDK `22` CI, and artifact uploads
- `Physics.kt`, `src/test/kotlin/test/Test.kt` - key caution signals around disabled physics and demo-style tests rather than real verification

## Risks Or Limits

- `Physics.update()` returns immediately at the top of the method, so the checked-in rigidbody/collision path is effectively disabled.
- `Renderer.render()` only iterates the root node's direct children, which makes the current render traversal shallower than the scene tree model implies.
- The README already admits that the example usage is probably outdated, and the checked-in TODO list still includes basic engine/editor gaps.
- The `src/test` tree is mostly a runnable demo scene plus assets, not a real automated regression suite.
- The repository describes itself as cross-platform, but the inspected runtime and build surface are desktop JVM/LWJGL/OpenGL-first today.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `reference-only`
- Focus tags: `3d`, `opengl`, `scene-graph`, `shader`, `editor-tools`
- Follow-up needed:
  - if the lab revisits this repository, do it in a JDK `22` environment and focus narrowly on one seam such as dependency-aware node assembly, editor-in-runtime tooling, or the renderer traversal/physics gaps instead of reopening the whole repo broadly
  - treat the inspected revision as a compact reference and cautionary sample, not as a baseline engine recommendation
