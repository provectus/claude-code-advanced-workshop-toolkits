---
name: pr-description
description: Write a pull request description that follows the company template. Use when the user asks to write, draft, or improve a PR/MR description, or is about to open a pull request.
---

# PR Description

Write pull request descriptions using the company template below.

## Steps

1. Find the base branch: `git merge-base HEAD origin/main` (fall back to `origin/master`).
2. Read the diff and commit list against that base: `git diff <base>...HEAD --stat`, `git log <base>..HEAD --oneline`.
3. Fill in the template. Describe *why* the change exists, not just *what* changed.
4. If the branch name or commits mention a ticket ID (e.g. `ABC-123`), put it in **Ticket**.

## Template

```markdown
## Summary
<1–3 sentences: the problem and how this PR solves it>

## Changes
- <notable change, grouped by area>

## Testing
- <how this was verified: tests added/run, manual steps>

## Risk & Rollback
<what could break, and how to revert>

## Ticket
<ID or "N/A">
```

## Rules

- No marketing language; keep it factual.
- Flag any database migrations, config changes, or new dependencies under **Risk & Rollback**.
- Do not invent test results — if nothing was tested, say so.
