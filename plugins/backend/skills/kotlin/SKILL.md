---
name: kotlin
description: Company Kotlin standards for writing, reviewing and refactoring .kt/.kts code. Use when creating or changing Kotlin backend code, Gradle Kotlin DSL builds, or reviewing a Kotlin diff.
---

# Kotlin Standards

## Before writing code

1. Find the build: `build.gradle.kts` / `settings.gradle.kts` (or `pom.xml`). Always use the wrapper (`./gradlew`, `./mvnw`), never a global install.
2. Note the Kotlin and JVM versions, and the framework in use (Spring Boot, Ktor, Micronaut) — follow its idioms.
3. Match the existing lint/format setup (ktlint, detekt, Spotless).

## Language

- `val` by default; `var` only when reassignment is required. Prefer read-only collections (`List`, `Map`) in APIs.
- Null safety: no `!!`. Use `?.`, `?:`, `requireNotNull`/`checkNotNull` with a message, or redesign the type to be non-null.
- `data class` for value carriers; `sealed interface`/`sealed class` for closed hierarchies, with exhaustive `when` (no `else` branch on sealed types).
- `value class` for typed IDs (`@JvmInline value class UserId(val value: UUID)`) instead of passing raw strings/UUIDs.
- Expression bodies for short functions; named arguments when a call has several parameters of the same type.
- Extension functions for small helpers, not for core domain logic.

## Coroutines

- `suspend` functions for I/O; never `runBlocking` in production code paths.
- Use structured concurrency — no `GlobalScope`. Launch from a scope tied to a lifecycle.
- Switch to `Dispatchers.IO` only around blocking calls, not whole functions.
- Don't catch `CancellationException` (or rethrow it).

## Errors & boundaries

- Throw domain-specific exceptions or return a sealed `Result`-style type — follow the repo's convention. Don't use exceptions for control flow.
- Validate input at the edges (controllers, message consumers); keep the domain layer free of framework types.
- Never log secrets or full request bodies containing personal data.

## Verify

1. Build and test: `./gradlew build` (or `./gradlew test --tests '<Class>'` for a focused run).
2. Lint: `./gradlew ktlintCheck` / `./gradlew detekt` if configured.

Do not report a change as done while compilation or tests fail.
