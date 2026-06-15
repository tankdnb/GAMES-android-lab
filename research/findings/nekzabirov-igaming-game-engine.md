# Research Note

## Repository Snapshot

- Repository: `nekzabirov/IGaming-Game-Engine`
- Source URL: `https://github.com/nekzabirov/IGaming-Game-Engine`
- Owner: `nekzabirov`
- Batch ID: `BATCH-2026-06-15-G`
- Type: `gameplay-systems`
- License: `Apache-2.0`
- Selection date: `2026-06-15`
- Last pushed at selection: `2026-06-15`
- Stars at selection: `7`
- Investigated commit: `bed2edbe89bc1a237e5b72734be0286fcfd902fb`
- Research status: `accepted`
- Build mode: `static-review + gradle-version + gradle-help-failed-java8-needs-java17`
- Catalog card: [card](../../catalog/projects/nekzabirov-igaming-game-engine.md)

## Why This Repository Was Selected

- Fresh Kotlin game-backend repository with explicit `Apache-2.0` licensing, clear game-domain scope, and higher expected architecture yield than the current Android micro-game fallback queue.
- Indirect Android relevance is acceptable here because the repository preserves reusable game-session, spin, wallet, and event-flow patterns that can inform Android-connected game platforms and live-service features.

## Technical Profile

- Main language(s): `Kotlin`
- Engine / framework: custom iGaming backend over Ktor, gRPC, Exposed, RabbitMQ, Redis, and Koin
- Rendering stack: none; server-side game-session and betting orchestration
- Android target: no native Android target
- Build system: Gradle Kotlin DSL
- Repository layout summary: `api/`, `application/`, `domain/`, and `infrastructure/` layers under one JVM service, plus `docs/` and generated gRPC/protobuf setup
- Key modules reviewed: `main.kt`, `application/Cqrs.kt`, `application/usecase/OpenSessionUsecase.kt`, `application/usecase/ProcessSpinUsecase.kt`, `api/grpc/config/KoinBootstrap.kt`, `api/grpc/config/GrpcModule.kt`, `domain/service/SpinBalanceCalculator.kt`, `infrastructure/aggregator/AggregatorRegistry.kt`, `infrastructure/wallet/WalletAdapter.kt`, `infrastructure/redis/PlayerLimitRedis.kt`, `infrastructure/persistence/repository/SessionRepositoryImpl.kt`, `infrastructure/rabbitmq/PlaceSpinEventConsumer.kt`, `docs/ARCHITECTURE.md`, `src/test/kotlin/domain/service/SpinBalanceCalculatorTest.kt`

## Build And Runtime Notes

- The repository was inspected statically and with lightweight Gradle discovery only.
- `gradlew.bat --version` succeeds and confirms a working wrapper path.
- `gradlew.bat help --no-daemon` fails locally because the lab machine still exposes Java `8`, while this project requires Java `17+` and declares JVM toolchain `21`.
- The build also depends on private GitHub Packages coordinates for wallet and user gRPC clients, so fuller local validation would require credentials and access even after the Java runtime issue is fixed.

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `2`
- Implementation depth: `3`
- Code clarity: `3`
- Novelty: `2`
- Overall verdict: `accepted`
- Why: this is not a client-side game runtime, but it is a strong Kotlin game-domain architecture reference for session lifecycle, authoritative betting flow, wallet split rules, event publication, and adapter-based provider integration.

## Interesting Findings

### Engine Architecture And Core Loop

- `src/main/kotlin/main.kt` wires the whole service as one outer application shell: Ktor bootstrap, database init, serialization, RabbitMQ topology, webhook routes, gRPC services, and background consumers are all composed in one readable startup path.
- `src/main/kotlin/api/grpc/config/KoinBootstrap.kt` keeps dependency assembly in the API layer as a true composition root, which is a useful pattern for any Kotlin game product where the outer shell is the only layer that should know every subsystem.
- `src/main/kotlin/application/Cqrs.kt` defines a deliberately small CQRS bus contract so read/write orchestration can stay explicit and handler lookup remains a DI concern rather than hidden framework magic.

### Rendering And Graphics

- No rendering subsystem is present; this repository is valuable as a backend gameplay/domain reference rather than a rendering reference.

### Gameplay Systems

- `src/main/kotlin/application/usecase/OpenSessionUsecase.kt` persists the session before requesting the aggregator launch URL because some providers immediately callback into the operator with the same token; this is a concrete and reusable fix for cross-service session races.
- `src/main/kotlin/application/usecase/ProcessSpinUsecase.kt` separates domain balance calculation, limit checks, persistence, wallet side effects, and event publication, which makes the betting lifecycle unusually easy to reason about and adapt.
- `src/main/kotlin/domain/service/SpinBalanceCalculator.kt` implements a compact but meaningful real-versus-bonus money split with distinct `PLACE`, `SETTLE`, and `ROLLBACK` paths, including same-pool payout and rollback restoration rules.
- `src/main/kotlin/infrastructure/handler/game/PlayGameCommandHandler.kt` shows a useful command-side pattern: product-facing limits are saved up front, then a tokenized session aggregate is created and passed into a dedicated open-session use case instead of mixing orchestration into the transport layer.
- `docs/ARCHITECTURE.md` documents round lifecycle and spin flow in more detail than most low-star repositories, which helps confirm that the codebase is preserving real domain thinking rather than only transport scaffolding.

### Input And Controls

- No gameplay input or Android control layer is present.

### UI, HUD, And Menus

- No UI layer is present; the closest analog is the split between gRPC services and aggregator webhooks as transport adapters over the same domain/application core.

### Physics And Collision

- No physics or collision subsystem is present.

### Tooling, Android Integration, Or Other Notable Areas

- `src/main/kotlin/infrastructure/aggregator/AggregatorRegistry.kt` resolves providers by integration key through Koin-discovered adapter providers, which is a clean zero-touch extensibility pattern for adding new game providers without editing central switch logic.
- `src/main/kotlin/infrastructure/wallet/WalletAdapter.kt` wraps wallet gRPC calls behind a game-domain port and translates them into `PlayerBalance`, which is a strong example of keeping transport DTOs out of the core game model.
- `src/main/kotlin/infrastructure/redis/PlayerLimitRedis.kt` keeps limit storage behind a tiny port using simple Redis keys instead of leaking Redis logic into gameplay code.
- `src/main/kotlin/infrastructure/persistence/repository/SessionRepositoryImpl.kt` loads the exact association chain needed to rehydrate a session with variant, game, provider, and aggregator context, which is useful for authoritative backend flows that must reconstruct domain state from persistence.
- `src/main/kotlin/infrastructure/rabbitmq/PlaceSpinEventConsumer.kt` uses committed `spin.placed` events to update player limits asynchronously, reinforcing the repository's event-after-commit model.
- `src/test/kotlin/domain/service/SpinBalanceCalculatorTest.kt` is stronger than the public signal suggests: it verifies affordability, real-first bonus handling, payout target pool, all-in settle behavior, and rollback restoration rules rather than only trivial happy paths.

## Reusable Takeaways

- Treat authoritative game-session and betting flow as a domain model first, not as a controller/webhook script.
- Persist cross-service session state before calling external providers when callbacks may race immediately.
- Keep money-split logic in a pure domain service with explicit test coverage instead of scattering it across wallet adapters and handlers.
- Use event publication after committed persistence when downstream analytics or limit tracking should not control user-facing success.
- Isolate provider-specific integrations behind registry/factory ports so new game providers do not force edits to central orchestration code.

## Evidence Summary

- `src/main/kotlin/main.kt` - application bootstrap and outer runtime shell
- `src/main/kotlin/api/grpc/config/KoinBootstrap.kt` - composition root and module ordering
- `src/main/kotlin/application/Cqrs.kt` - CQRS bus contracts
- `src/main/kotlin/application/usecase/OpenSessionUsecase.kt` - session-open ordering and event-after-commit pattern
- `src/main/kotlin/application/usecase/ProcessSpinUsecase.kt` - authoritative betting flow orchestration
- `src/main/kotlin/domain/service/SpinBalanceCalculator.kt` - real/bonus split domain rules
- `src/main/kotlin/infrastructure/aggregator/AggregatorRegistry.kt` - provider extensibility seam
- `src/main/kotlin/infrastructure/wallet/WalletAdapter.kt` - wallet transport adapter
- `src/main/kotlin/infrastructure/redis/PlayerLimitRedis.kt` - Redis-backed limit storage
- `src/main/kotlin/infrastructure/persistence/repository/SessionRepositoryImpl.kt` - persistence rehydration path
- `src/main/kotlin/infrastructure/rabbitmq/PlaceSpinEventConsumer.kt` - committed-event consumption pattern
- `src/test/kotlin/domain/service/SpinBalanceCalculatorTest.kt` - meaningful domain-rule verification

## Risks Or Limits

- Android relevance is indirect because this is a backend-oriented repository, not an Android runtime or client product.
- Full local build validation is blocked by the lab's Java `8` environment.
- The repository depends on private GitHub Packages artifacts, which reduces easy reproducibility for outside readers.
- Some text files show encoding artifacts in the current clone, but the underlying architecture remains readable.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `gameplay-systems`
- Focus tags: `networking`, `save-load`, `testing`
- Follow-up needed: `no`, unless the lab later wants a dedicated pass on multiplayer/backend-connected Android game architecture
