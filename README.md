# corporeation-claude-plugin

A Claude Code plugin marketplace. It lists the plugins in `plugins/` through `.claude-plugin/marketplace.json`.

## Plugins

| Plugin | Contents |
|--------|----------|
| `corporate-toolkit` | `standup` command, `pr-description` skill, `security-reviewer` agent, `.env` protection hook |
| `sdlc` | `commit` and `github-cli` skills |
| `frontend` | `typescript` skill, `typescript-engineer` agent, TypeScript LSP |
| `backend` | `kotlin` skill, `kotlin-engineer` agent |
| `misc` | `search-kb` skill (runs the KB setup itself on first use), `qmd` MCP server, sample KB + `install-kb.sh` |

## Layout

```
corporeation-claude-plugin/
├── .claude-plugin/
│   └── marketplace.json              # marketplace catalog
└── plugins/
    ├── corporate-toolkit/
    │   ├── .claude-plugin/plugin.json
    │   ├── commands/standup.md
    │   ├── skills/pr-description/SKILL.md
    │   ├── agents/security-reviewer.md
    │   ├── hooks/hooks.json
    │   └── scripts/protect-env.sh
    ├── sdlc/
    │   ├── .claude-plugin/plugin.json
    │   └── skills/
    │       ├── commit/SKILL.md
    │       └── github-cli/SKILL.md (+ references/)
    ├── frontend/
    │   ├── .claude-plugin/plugin.json
    │   ├── .lsp.json                 # TypeScript LSP (tsc --lsp --stdio)
    │   ├── skills/typescript/SKILL.md
    │   └── agents/typescript-engineer.md
    ├── backend/
    │   ├── .claude-plugin/plugin.json
    │   ├── skills/kotlin/SKILL.md
    │   └── agents/kotlin-engineer.md
    └── misc/
        ├── .claude-plugin/plugin.json
        ├── .mcp.json                 # qmd MCP server (runs the installed `qmd`)
        ├── kb/                       # sample company knowledge base (markdown)
        ├── scripts/install-kb.sh     # installs qmd + the KB, builds the index
        └── skills/search-kb/SKILL.md
```

## Use it

Adding the marketplace installs nothing on its own. Each plugin is installed separately, so pick only the ones you need. For example, a frontend developer only needs:

```
/plugin marketplace add provectus/claude-code-advanced-workshop-toolkits
/plugin install frontend@corporeation-claude-plugin
```

Or install any combination:

```
/plugin install sdlc@corporeation-claude-plugin
/plugin install backend@corporeation-claude-plugin
/plugin install misc@corporeation-claude-plugin
/plugin install corporate-toolkit@corporeation-claude-plugin
```

For local testing use `/plugin marketplace add ./corporeation-claude-plugin` instead.

### Prerequisites

| Plugin | Needs |
|--------|-------|
| `sdlc` | `git`, and `gh` authenticated (`gh auth login`) for `github-cli` |
| `frontend` | TypeScript 7+ on PATH: `npm install -g typescript` (the LSP runs `tsc --lsp --stdio`) |
| `misc` | Node.js 22+. The first time you search the KB, the `search-kb` skill runs `install-kb.sh` for you. If you deny that, it asks you to run it with `!`. The script installs qmd globally, copies the KB to `~/.local/share/corporeation-kb` and indexes it, and the first run downloads ~2 GB of local models. If qmd was missing before, reconnect it with `/mcp` (or restart Claude Code) afterwards. You can also run `bash plugins/misc/scripts/install-kb.sh` yourself ahead of time |

To share it with a team automatically, add it to the project's `.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "corporeation-claude-plugin": {
      "source": { "source": "github", "repo": "provectus/claude-code-advanced-workshop-toolkits" }
    }
  },
  "enabledPlugins": {
    "sdlc@corporeation-claude-plugin": true,
    "frontend@corporeation-claude-plugin": true
  }
}
```

## Add a plugin

1. Create `plugins/<name>/.claude-plugin/plugin.json`.
2. Add an entry to `plugins` in `.claude-plugin/marketplace.json` with `"source": "./plugins/<name>"`.
3. Bump the version in both files when you change a plugin.
4. Run `claude plugin validate ./plugins/<name>` and `claude plugin validate .`.
