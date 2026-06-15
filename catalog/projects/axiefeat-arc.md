# Arc

- Project: [AxieFeat/Arc](https://github.com/AxieFeat/Arc)
- Category: `engine-framework`
- Status: `accepted`
- License: `MIT`
- Language: `Kotlin`
- Engine / stack: custom Kotlin engine with OpenGL, OpenGLES/ANGLE, Vulkan, GLFW, and extension modules
- Android relevance: indirect today; valuable mainly as a reusable engine-architecture reference

## Short Description

`Arc` is a lightweight modular Kotlin engine workspace built around a backend-neutral core API plus backend-specific graphics hosts and optional extension modules.

## Why It Matters

- Keeps public engine contracts intentionally separate from OpenGL or Vulkan implementation details.
- Demonstrates a clean module split across core, common, backend, and extension layers.
- Preserves several reusable rendering and subsystem-registration patterns even though the visible checked-in runtime is desktop-first.

## Key Reusable Ideas

- backend-neutral `Application` and `RenderSystem` contracts
- shared scene timing with explicit delta and FPS ownership
- extension bootstrap pattern for audio or input or other optional subsystems
- demo-level voxel helpers such as block raycast stepping, AABB highlighting, and UBO-backed light upload

## Main Caveats

- no direct Android host module was found in the reviewed revision
- Vulkan render backend is still visibly incomplete
- local Gradle discovery in the lab is blocked by missing JDK compiler tooling, while the repo expects Java `21`

## Suggested Focus Tags

`3d`, `opengl`, `vulkan`, `input`, `audio`, `asset-pipeline`, `testing`
