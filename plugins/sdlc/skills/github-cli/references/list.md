# List Open Pull Requests

Reference doc for the **list** flow of the `github-cli` skill. Read this
only after the SKILL.md has determined the user wants to see which PRs
are open — not to open, review, or fix one.

## Why this skill exists

"Is there anything open?" is the most common question asked of a repo,
and the answer is only useful if it is correct and scannable. Bare
`gh pr list` prints nothing at all when there are no PRs and nothing
when it is pointed at the wrong remote, so an empty result is
ambiguous. This workflow confirms which repo was checked, then reports
every open PR — or an explicit "no open PRs" — in one compact table.

This flow is **read-only**. It never comments, labels, approves,
checks out, or otherwise changes anything.

## The workflow

Run the steps in order.

### Step 1: Resolve the target repo(s)

Run from inside each repo the user means. If the working directory is
not a git repo but contains several (a workspace folder), check each
child repo rather than stopping.

Confirm the remote is GitHub and record what you are listing:

```bash
gh repo view --json nameWithOwner,defaultBranchRef,url \
  -q '"\(.nameWithOwner) (default: \(.defaultBranchRef.name)) \(.url)"'
```

If this fails, the remote is not GitHub or `gh` is not authenticated —
say so (`gh auth status` shows which) instead of reporting "no PRs".

### Step 2: List the PRs

Default to open PRs. Always request JSON so an empty result is explicit:

```bash
gh pr list --state open --limit 100 \
  --json number,title,author,headRefName,baseRefName,isDraft,reviewDecision,updatedAt,url \
  -q 'if length==0 then "no open PRs" else .[] | "#\(.number)\t\(.title)\t\(.headRefName)→\(.baseRefName)\t\(.author.login)\t\(if .isDraft then "draft" else (.reviewDecision // "—") end)\t\(.url)" end'
```

Narrow only when the user asks:

| User says | Add |
|---|---|
| "my PRs" | `--author @me` |
| "waiting on my review" | `--search "review-requested:@me"` |
| "for branch X" | `--head X` (or `--base X` for the target) |
| "closed" / "merged" / "all" | `--state closed` / `merged` / `all` |
| "with label X" | `--label X` |

If exactly 100 PRs come back, say the list may be truncated and offer to
raise `--limit`.

### Step 3: Optionally add CI status

Only when the user asks about checks, or when there are five or fewer
PRs, fetch the rollup per PR:

```bash
gh pr checks <num>
```

Summarize as pass / fail / pending — don't paste the full log.

### Step 4: Report

One table per repo, the repo name and URL above it:

| # | Title | Branch | Author | Status |
|---|---|---|---|---|

Status is `draft`, the review decision (`APPROVED`, `CHANGES_REQUESTED`,
`REVIEW_REQUIRED`), or `—`. When a repo has none, write "no open PRs"
for that repo rather than omitting it.

End by offering the natural next step — reviewing one
(`references/review.md`) or addressing feedback on one of the user's own
(`references/fix.md`) — but don't start it unasked.

## What NOT to do

- Don't report "no open PRs" when `gh repo view` failed — that is an
  auth or remote problem, not an empty repo.
- Don't rely on bare `gh pr list` text output; it is silent when empty.
- Don't modify anything: no comments, labels, checkouts, or merges.
- Don't silently cap results; flag a full page as possibly truncated.
- Don't slip into reviewing or fixing a PR from this flow.
