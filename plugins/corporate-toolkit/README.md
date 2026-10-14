# corporate-toolkit

Team-wide Claude Code standards packaged as a plugin.

| Component | Name | What it does |
|-----------|------|--------------|
| Command | `/corporate-toolkit:standup [days]` | Drafts a standup update from your recent git activity |
| Skill | `pr-description` | Writes PR descriptions using the company template (auto-triggers) |
| Agent | `security-reviewer` | Reviews changes for secrets, injection, and auth issues |
| Hook | `protect-env.sh` (PreToolUse) | Blocks Claude from editing `.env` / `.env.*` files |

## Install

```
/plugin marketplace add provectus/claude-code-advanced-workshop-toolkits
/plugin install corporate-toolkit@corporeation-claude-plugin
```
