---
name: typescript
description: Company TypeScript standards for writing, reviewing and refactoring .ts/.tsx code. Use when creating or changing TypeScript or React code, fixing type errors, or reviewing a TypeScript diff.
---

# TypeScript Standards

## Before writing code

1. Read `tsconfig.json` and respect its settings (`strict`, `module`, path aliases). Never loosen them to make code compile.
2. Detect the package manager from the lockfile (`pnpm-lock.yaml`, `yarn.lock`, `package-lock.json`, `bun.lockb`) and use it for every command.
3. Match the existing lint/format setup (ESLint, Prettier, Biome) — don't introduce a new one.

## Types

- No `any`. Use `unknown` at trust boundaries and narrow it with type guards or a schema validator (e.g. zod) already used in the repo.
- No non-null assertions (`!`) or `as` casts to silence errors; fix the type instead. `as const` and `satisfies` are fine.
- Prefer `type` for unions and composition, `interface` for object shapes meant to be extended. Follow the repo if it has picked one.
- Model state with discriminated unions instead of optional flags:
  ```ts
  type Request =
    | { status: "loading" }
    | { status: "error"; error: Error }
    | { status: "success"; data: User[] };
  ```
- Exhaustive `switch` over unions with a `never` check in `default`.
- Export explicit return types on public functions and module boundaries.

## Code

- `const` by default, `let` only when reassigned; never `var`.
- `async`/`await` over raw promise chains; never leave a promise floating — `await` it or handle it explicitly.
- Named exports over default exports.
- Errors: throw `Error` subclasses, never strings. Don't swallow errors in empty `catch` blocks.
- React: function components and hooks only; keep components pure; derive state instead of syncing it with `useEffect`.

## Verify

Run the project's own scripts (check `package.json`), typically:

1. Type check: `tsc --noEmit` (or the `typecheck` script)
2. Lint: the `lint` script
3. Tests: the `test` script for the files you touched

Use LSP diagnostics after each edit when available. Do not report a change as done while the type check fails.
