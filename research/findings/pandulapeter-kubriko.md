# Research Note

## Repository Snapshot

- Repository: `pandulapeter/kubriko`
- Source URL: [https://github.com/pandulapeter/kubriko](https://github.com/pandulapeter/kubriko)
- Owner: `pandulapeter`
- Batch ID: [`BATCH-2026-05-10-B`](../batches/BATCH-2026-05-10-B.md)
- Type: `engine-framework`
- License: `MPL-2.0`
- Selection date: `2026-05-10`
- Last pushed at selection: `2026-04-29`
- Stars at selection: `237`
- Investigated commit: `c78e2ced9b72226dd01105873673e0812f0bfea3`
- Research status: `accepted`
- Build mode: `static-review + gradle-discovery-attempt-timeout`
- Catalog card: [catalog/projects/pandulapeter-kubriko.md](../../catalog/projects/pandulapeter-kubriko.md)

## Why This Repository Was Selected

- It is an Android-capable Kotlin engine built directly around Compose Multiplatform instead of around a traditional standalone rendering shell.
- The plugin/tool split suggests reusable patterns for modular engine growth, not just one-off demos.
- It is active and technically unusual enough to justify a full batch slot despite lower stars than the largest engines.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: Kubriko
- Rendering stack: Compose Multiplatform viewport and manager-driven rendering pipeline
- Android target: explicit Android target and Compose embedding path
- Build system: Gradle Kotlin DSL multiplatform monorepo
- Repository layout summary: engine core plus plugin modules, development tools, showcase app targets, and many example modules
- Key modules reviewed:
  - `engine`
  - `plugins:pointer-input`
  - `plugins:collision`
  - `plugins:physics`
  - `plugins:serialization`
  - `tools:debug-menu`

## Build And Runtime Notes

- The repository was primarily investigated statically.
- A Gradle discovery command was attempted via `.\gradlew.bat help`, but it timed out before yielding a useful lightweight validation result.
- Known setup limitations:
  - large multiplatform workspace with many plugins and samples
  - Compose Multiplatform and multi-target startup cost is non-trivial for quick discovery runs

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `3`
- Implementation depth: `3`
- Code clarity: `3`
- Novelty: `3`
- Overall verdict: `accepted`
- Why:
  - the repository shows a convincing Compose-native engine shape rather than bolting game code onto generic UI screens
  - its managers, plugins, and viewport loop contain patterns directly relevant to future Android game architecture
  - physics, collision, input, persistence, and debug tooling are all present as separable subsystems

## Interesting Findings

### Engine Architecture And Core Loop

- `engine/src/commonMain/kotlin/com/pandulapeter/kubriko/Kubriko.kt` defines the engine as a manager container created through `Kubriko.newInstance()`, which is a clean composition-first architecture.
- `engine/src/commonMain/kotlin/com/pandulapeter/kubriko/KubrikoViewport.kt` exposes the engine as a normal Compose `@Composable`, making embedding inside Android apps much more natural than activity-owned engines.
- `engine/src/commonMain/kotlin/com/pandulapeter/kubriko/implementation/InternalViewport.kt` wires lifecycle focus, viewport sizing, aspect-ratio modes, and the frame loop together inside Compose rather than outside it.
- `engine/src/commonMain/kotlin/com/pandulapeter/kubriko/manager/StateManagerImpl.kt` combines focus and running state with a debounced flow, which is a strong pattern for avoiding noisy lifecycle transitions.

### Rendering And Graphics

- `engine/src/commonMain/kotlin/com/pandulapeter/kubriko/manager/ActorManagerImpl.kt` filters visible actors against the current viewport, keeps overlay and scene drawing orders separate, and can put far-away dynamic actors to sleep.
- `engine/src/commonMain/kotlin/com/pandulapeter/kubriko/implementation/InternalViewport.kt` recalculates scaling from actual composable size and aspect-ratio mode, which is useful for Android devices with many screen shapes.

### Gameplay Systems

- Kubriko's main gameplay value is its manager/plugin split rather than a single finished game's rules. The strong reusable idea is that gameplay-adjacent systems can be added as plugins without changing the viewport shell.

### Input And Controls

- `plugins/pointer-input/src/commonMain/kotlin/com/pandulapeter/kubriko/pointerInput/PointerInputManagerImpl.kt` converts raw Compose pointer events into normalized pressed/hovering positions, drag signals, zoom signals, and focus-aware actor callbacks.
- The same pointer manager also compensates for viewport and root offsets, which matters when the game canvas is embedded inside a larger Android UI.

### UI, HUD, And Menus

- `tools/debug-menu/src/commonMain/kotlin/com/pandulapeter/kubriko/debugMenu/implementation/DebugMenuManager.kt` shows a useful overlay/tooling pattern: collect metadata from live managers and render optional body/collision overlays directly through the viewport.

### Physics And Collision

- `plugins/collision/src/commonMain/kotlin/com/pandulapeter/kubriko/collision/CollisionManagerImpl.kt` keeps collision detection as a separate manager that scans `CollisionDetector` actors against filtered `Collidable` actors.
- `plugins/physics/src/commonMain/kotlin/com/pandulapeter/kubriko/physics/PhysicsManagerImpl.kt` uses broad-phase AABB checks, arbiter-based narrow-phase handling, semi-implicit integration, joints, gravity, and drag in a compact engine-managed subsystem.

### Tooling, Android Integration, Or Other Notable Areas

- `plugins/serialization/src/commonMain/kotlin/com/pandulapeter/kubriko/serialization/SerializationManagerImpl.kt` serializes actors through typed metadata registrations instead of runtime reflection. That is a strong save/load pattern for modular engines.
- `engine/src/commonMain/kotlin/com/pandulapeter/kubriko/implementation/InternalViewport.kt` ties lifecycle focus directly to the frame loop, which is especially relevant for Android pause/resume behavior.

## Reusable Takeaways

- Compose-native game runtimes can work cleanly if the viewport, lifecycle, and tick loop are designed as first-class Compose integration points.
- Manager/plugin boundaries are worth preserving because they let physics, input, debugging, and persistence evolve independently.
- Viewport-aware pointer normalization is essential when the game canvas is not full-screen and may sit inside other Android UI.
- Debug overlays become much more valuable when they are treated as just another manager instead of one-off debug code inside gameplay classes.

## Evidence Summary

- `engine/src/commonMain/kotlin/com/pandulapeter/kubriko/Kubriko.kt` - manager-based engine entrypoint
- `engine/src/commonMain/kotlin/com/pandulapeter/kubriko/KubrikoViewport.kt` - Compose embedding surface
- `engine/src/commonMain/kotlin/com/pandulapeter/kubriko/implementation/InternalViewport.kt` - frame loop, lifecycle, aspect ratio, viewport sizing
- `engine/src/commonMain/kotlin/com/pandulapeter/kubriko/manager/StateManagerImpl.kt` - focus/running flow composition
- `engine/src/commonMain/kotlin/com/pandulapeter/kubriko/manager/ActorManagerImpl.kt` - actor visibility filtering, sleeping, drawing order
- `plugins/pointer-input/src/commonMain/kotlin/com/pandulapeter/kubriko/pointerInput/PointerInputManagerImpl.kt` - pointer normalization and gesture dispatch
- `plugins/collision/src/commonMain/kotlin/com/pandulapeter/kubriko/collision/CollisionManagerImpl.kt` - collision manager
- `plugins/physics/src/commonMain/kotlin/com/pandulapeter/kubriko/physics/PhysicsManagerImpl.kt` - physics integration and arbiter flow
- `plugins/serialization/src/commonMain/kotlin/com/pandulapeter/kubriko/serialization/SerializationManagerImpl.kt` - typed actor serialization
- `tools/debug-menu/src/commonMain/kotlin/com/pandulapeter/kubriko/debugMenu/implementation/DebugMenuManager.kt` - runtime debug overlays and metadata aggregation

## Risks Or Limits

- `MPL-2.0` requires care if modified engine code is reused directly.
- The API is explicitly early-stage and may change.
- Build validation was inconclusive because the Gradle discovery attempt timed out.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `engine-framework`
- Focus tags: `2d`, `android`, `multiplatform`, `input`, `physics`, `editor-tools`
- Follow-up needed:
  - inspect the scene editor and example game modules later if the lab wants more content-authoring and production-workflow patterns
