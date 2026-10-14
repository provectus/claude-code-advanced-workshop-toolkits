---
name: search-kb
description: Search the company knowledge base (engineering guidelines, processes, docs) through the qmd MCP server. Use when the user asks to search the KB, find something in the company docs, or asks a question that internal documentation should answer.
allowed-tools: mcp__plugin_misc_qmd__status, mcp__plugin_misc_qmd__query, mcp__plugin_misc_qmd__get, mcp__plugin_misc_qmd__multi_get, Bash(command -v qmd)
---

# Search the Knowledge Base

The knowledge base is indexed by [qmd](https://github.com/tobi/qmd), a local hybrid search engine (BM25 + vector search + LLM reranking) over markdown files. Everything runs on-device.

**Search only with the `qmd` MCP server tools that this plugin ships. Do not search with the `qmd` CLI (or `npx @tobilu/qmd`) through Bash, and don't grep or read the KB files directly.** The only Bash commands this skill runs are `command -v qmd` and the installer, both during setup.

## MCP tools

| Tool | Use for |
|------|---------|
| `status` | Check the index exists and which collections it has — call this first |
| `query` | Search. Combine sub-queries: `lex` (keywords/exact terms), `vec` (meaning), `hyde` (a hypothetical answer) |
| `get` | Read one document: pass `file` as `collection/path.md` or a docid |
| `multi_get` | Read several documents by glob, list, or docids |

## Workflow

1. **Check setup.** Call `status`.
   - `status` works and lists the `corporeation-kb` collection → continue to step 2.
   - `status` works but there's no `corporeation-kb` collection → go to **Setup**.
   - The qmd MCP tools aren't available or the call fails → run `command -v qmd` with Bash to find out why:
     - Nothing found → qmd isn't installed. Go to **Setup** now; don't wait or ask first.
     - A path is printed → qmd is installed but the MCP server isn't connected. Ask the user to run `/mcp` and reconnect `qmd` (or restart Claude Code), then ask the question again. Stop here.
2. **Search** with `query`. Use `lex` for names, IDs and error strings; `vec` for conceptual questions; both when unsure.
3. **Read** the top 2–5 hits with `get`/`multi_get` — don't answer from snippets alone.
4. **Answer** with citations to the source documents (`collection/path.md`). If the KB doesn't contain the answer, say so instead of guessing.

## Setup

The plugin bundles the KB and an installer. In one sentence, tell the user what it does: it installs qmd globally, copies the KB to `~/.local/share/corporeation-kb`, indexes it, and the first time downloads about 2 GB of local models. Then run it with the Bash tool:

```bash
bash "${CLAUDE_PLUGIN_ROOT}/scripts/install-kb.sh"
```

Give the Bash call a 10-minute timeout; the first run takes a few minutes.

- **The Bash call is denied, or you can't run commands:** don't retry it and don't work around it. Ask the user to run it themselves by typing this in the prompt:
  ```
  ! bash "${CLAUDE_PLUGIN_ROOT}/scripts/install-kb.sh"
  ```
- **The script fails:** show the error. The usual one is "qmd needs Node 22+": tell the user to run `nvm install 22 && nvm alias default 22`, then run the installer again.
- **The script succeeds:**
  - If the qmd MCP tools were already available (only the collection was missing), go back to step 1 and continue the search.
  - If the qmd MCP tools weren't available, the MCP server couldn't start before qmd existed. Ask the user to restart Claude Code, or run `/mcp` and reconnect `qmd`, then ask the question again. Don't answer from the files or the CLI in the meantime.
