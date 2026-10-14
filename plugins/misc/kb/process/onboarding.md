# Engineer Onboarding

## Week 1

1. Get access: GitHub org, Slack, SSO, the cloud console (read-only), and the on-call tool.
2. Set up your machine: Git, Node (version from `.nvmrc`), pnpm, JDK 21, Docker, and the `gh` CLI (`gh auth login`).
3. Install Claude Code and the company plugin marketplace:
   ```
   /plugin marketplace add provectus/claude-code-advanced-workshop-toolkits
   ```
   Then install the `sdlc` plugin, plus `frontend` or `backend` for your team.
4. Run `install-kb.sh` from the `misc` plugin so Claude can search this knowledge base.
5. Pair with your onboarding buddy on a "good first issue" ticket.

## Week 2

- Ship your first PR to production.
- Shadow an on-call shift (no pager responsibility yet).
- Read the incident response and release process docs.

## Who to ask

- Your onboarding buddy — anything at all
- Team lead — priorities and scope
- `#eng-help` Slack channel — tooling and environment problems
