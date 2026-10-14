# Release Process

## Cadence

- Services deploy continuously from `main` after CI passes.
- Mobile and desktop apps release every two weeks on Tuesday; code freeze is the Thursday before.
- No production deploys on Fridays after 14:00 local time, or on public holidays, except hotfixes.

## Versioning

Semantic versioning (`MAJOR.MINOR.PATCH`), tagged from `main` as `vX.Y.Z`. The changelog is generated from Conventional Commit messages.

## Deploy steps

1. Merge to `main` → CI builds and runs tests.
2. Automatic deploy to **staging**; smoke tests run.
3. Promote to **production** via the deploy pipeline (requires approval from the service owner).
4. Watch dashboards and error rates for 30 minutes after the deploy.

## Rollback

- Every deploy must be rollback-safe: database migrations are backward compatible (expand → migrate → contract).
- Roll back by redeploying the previous tag from the pipeline; don't revert commits on `main` under pressure.
- Any rollback in production is at least a SEV3 incident and gets logged in `#incidents`.
