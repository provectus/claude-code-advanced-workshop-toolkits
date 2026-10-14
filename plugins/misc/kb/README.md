# Corporeation Knowledge Base

Sample company knowledge base for the Claude Code Advanced workshop. It's installed on your machine by `install-kb.sh` and indexed by [qmd](https://github.com/tobi/qmd), so Claude can search it through the `search-kb` skill.

| Section | Contents |
|---------|----------|
| `engineering/` | Git workflow, code review, TypeScript and Kotlin guidelines |
| `process/` | Onboarding, incident response, release process |

To add your own documents, put `.md` files in the installed KB folder and run `qmd update && qmd embed`.
