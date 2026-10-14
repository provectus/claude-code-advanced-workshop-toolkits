# Git Workflow

## Branches

- `main` is always deployable. Direct pushes to `main` are blocked.
- Branch names: `<type>/<ticket>-<short-description>`, e.g. `feat/ABC-123-user-export`.
- Allowed types: `feat`, `fix`, `chore`, `docs`, `refactor`, `test`, `hotfix`.
- Keep branches short-lived — merge or close within 5 working days.

## Commits

- Use Conventional Commits: `type(scope): summary` in the imperative mood, max 72 characters.
- One logical change per commit. Don't mix refactors with behaviour changes.
- Reference the ticket in the body: `Refs: ABC-123`.
- Breaking changes: `feat!:` plus a `BREAKING CHANGE:` footer explaining the migration.

## Pull requests

- Open a draft PR early; mark it ready when CI is green.
- At least one approval is required; two for changes to auth, payments or infrastructure.
- Squash-merge into `main`. The squash commit message must follow the commit rules above.
- Delete the branch after merging.

## Hotfixes

Branch from `main` as `hotfix/<ticket>-<desc>`, get one approval from the on-call lead, merge, and tag a patch release immediately.
