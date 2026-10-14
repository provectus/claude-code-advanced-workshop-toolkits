---
name: search-kb
description: Search the company knowledge base (engineering guidelines, processes, docs) through the qmd MCP server. Use when the user asks to search the KB, find something in the company docs, or asks a question that internal documentation should answer.
allowed-tools: mcp__plugin_misc_qmd__status, mcp__plugin_misc_qmd__query, mcp__plugin_misc_qmd__get, mcp__plugin_misc_qmd__multi_get
---

# Search the Knowledge Base

The knowledge base is indexed by [qmd](https://github.com/tobi/qmd), a local hybrid search engine (BM25 + vector search + LLM reranking) over markdown files. Everything runs on-device.

**Use only the `qmd` MCP server tools that this plugin ships. Do not run the `qmd` CLI (or `npx @tobilu/qmd`) through Bash, and don't grep or read the KB files directly.**

## MCP tools

| Tool | Use for |
|------|---------|
| `status` | Check the index exists and which collections it has — call this first |
| `query` | Search. Combine sub-queries: `lex` (keywords/exact terms), `vec` (meaning), `hyde` (a hypothetical answer) |
| `get` | Read one document: pass `file` as `collection/path.md` or a docid |
| `multi_get` | Read several documents by glob, list, or docids |

## Workflow

1. Call `status`.
   - If the qmd MCP tools aren't available, or the `corporeation-kb` collection is missing, stop. Tell the user to run the setup script (below) and restart Claude Code. Don't fall back to the CLI.
2. Search with `query`. Use `lex` for names, IDs and error strings; `vec` for conceptual questions; both when unsure.
3. Open the top 2–5 hits with `get`/`multi_get` and read the relevant parts — don't answer from snippets alone.
4. Answer with citations to the source documents (`collection/path.md`). If the KB doesn't contain the answer, say so instead of guessing.

## First-time setup (for the user)

The plugin bundles a company KB and an installer. Tell the user to run it in their own terminal:

```bash
bash "${CLAUDE_PLUGIN_ROOT}/scripts/install-kb.sh"
```

It needs Node 22+. The script installs qmd globally, copies the KB to `~/.local/share/corporeation-kb`, adds it as the `corporeation-kb` collection and builds the embeddings. The first run downloads about 2 GB of local models. After it finishes, the user needs to restart Claude Code so the qmd MCP server connects.
