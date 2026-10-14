---
description: Generate a daily standup update from recent git activity
argument-hint: "[days-back, default 1]"
allowed-tools: Bash(git log:*), Bash(git status:*), Bash(git branch:*), Bash(git config:*)
---

Write my standup update based on the git activity in this repository over the last $ARGUMENTS day(s). If no number was given, use 1.

Steps:
1. Run `git log --since="<N> days ago" --author="<my git user.email>" --oneline --no-merges` to collect my commits.
2. Run `git status --short` and `git branch --show-current` to see work in progress.
3. Produce the update in exactly this format:

**Yesterday**
- <grouped, human-readable summary of finished work — not raw commit messages>

**Today**
- <what the uncommitted changes and current branch suggest I'm working on>

**Blockers**
- <anything that looks stuck, e.g. merge conflicts; otherwise "None">

Keep it under 10 bullets total.
