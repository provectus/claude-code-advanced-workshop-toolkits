# TypeScript Guidelines

## Project setup

- `strict: true` in every `tsconfig.json`; also enable `noUncheckedIndexedAccess`.
- Package manager: **pnpm**. Node version is pinned in `.nvmrc`.
- Linting and formatting: ESLint + Prettier, run in CI and on pre-commit.

## Rules

- No `any`; use `unknown` and narrow it. Validate external data with **zod** at the boundary.
- No `!` non-null assertions and no `as` casts to silence the compiler.
- Model state with discriminated unions, and use exhaustive `switch` statements with a `never` check.
- Named exports only.
- Never leave a floating promise — `await` it or handle it explicitly.

## Frontend stack

- React with function components and hooks.
- Server state: TanStack Query. Don't copy server data into local state.
- Styling: Tailwind CSS.
- Tests: Vitest + Testing Library; end-to-end tests with Playwright.

## Definition of done

`pnpm typecheck`, `pnpm lint` and `pnpm test` all pass locally and in CI.
