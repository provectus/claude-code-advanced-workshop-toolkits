# Kotlin Guidelines

## Project setup

- Kotlin 2.x on JVM 21. Build with the Gradle Kotlin DSL, and always use `./gradlew`.
- Framework: Spring Boot 3 for services; Ktor is allowed for small internal tools.
- Static analysis: ktlint + detekt, both run in CI.

## Rules

- `val` over `var`; read-only collections in public APIs.
- No `!!`. Use `?:`, `requireNotNull(x) { "message" }`, or a non-null type.
- Sealed interfaces for closed hierarchies, with exhaustive `when` and no `else`.
- `@JvmInline value class` for IDs (`UserId`, `OrderId`).
- Coroutines: no `GlobalScope`, no `runBlocking` outside tests and `main`.

## Layers

- `api` → controllers and DTOs, validation only
- `domain` → business logic, no framework annotations
- `infra` → persistence, clients, messaging

Mapping between DTOs and domain objects happens in `api`, never in `domain`.

## Testing

- Unit tests: JUnit 5 + Kotest assertions + MockK.
- Integration tests: Testcontainers for Postgres and Kafka.
- Definition of done: `./gradlew build` passes, including detekt and ktlint.
