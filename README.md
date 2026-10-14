# corporeation-claude-plugin

A Claude Code plugin marketplace. It lists the plugins in `plugins/` through `.claude-plugin/marketplace.json`.

## Layout

```
corporeation-claude-plugin/
├── .claude-plugin/
│   └── marketplace.json          # marketplace catalog
└── plugins/
    └── corporate-toolkit/
        ├── .claude-plugin/plugin.json
        ├── commands/standup.md
        ├── skills/pr-description/SKILL.md
        ├── agents/security-reviewer.md
        ├── hooks/hooks.json
        └── scripts/protect-env.sh
```

## Use it

From a local checkout:

```
/plugin marketplace add ./corporeation-claude-plugin
/plugin install corporate-toolkit@corporeation-claude-plugin
```

From GitHub:

```
/plugin marketplace add provectus/claude-code-advanced-workshop-toolkits
```

To share it with a team automatically, add it to the project's `.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "corporeation-claude-plugin": {
      "source": { "source": "github", "repo": "provectus/claude-code-advanced-workshop-toolkits" }
    }
  },
  "enabledPlugins": {
    "corporate-toolkit@corporeation-claude-plugin": true
  }
}
```

## Add a plugin

1. Create `plugins/<name>/.claude-plugin/plugin.json`.
2. Add an entry to `plugins` in `.claude-plugin/marketplace.json` with `"source": "./plugins/<name>"`.
3. Bump the version in both files when you change a plugin.
