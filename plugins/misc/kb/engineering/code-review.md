# Code Review Guidelines

## For authors

- Keep PRs under ~400 changed lines. Split larger work into stacked PRs.
- Fill in every section of the PR template: Summary, Changes, Testing, Risk & Rollback, Ticket.
- Review your own diff before requesting review.
- Respond to every comment — resolve it with a change, or reply explaining why not.

## For reviewers

- First response within 1 working day.
- Review in this order: correctness → security → tests → design → style.
- Prefix comments so intent is clear:
  - `blocking:` must be fixed before merge
  - `suggestion:` worth considering, author decides
  - `nit:` trivial, non-blocking
  - `question:` asking for understanding
- Approve once all `blocking:` comments are resolved; don't hold PRs on nits.

## What always blocks a merge

- Secrets or credentials in code or config
- Missing tests for new behaviour or bug fixes
- Failing CI
- Database migrations without a rollback plan
- New dependencies without a stated reason
