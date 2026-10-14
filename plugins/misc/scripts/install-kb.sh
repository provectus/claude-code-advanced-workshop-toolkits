#!/usr/bin/env bash
# Install the Corporeation knowledge base and index it with qmd.
#
#   1. Checks Node.js >= 22 (required by qmd)
#   2. Installs qmd globally (pinned version) if missing or outdated
#   3. Copies the bundled markdown KB to $KB_DIR
#   4. Registers it as a qmd collection, indexes it, builds embeddings,
#      and pre-downloads the search models
#
# Usage: install-kb.sh [--skip-embed]
#   KB_DIR    install location (default: ~/.local/share/corporeation-kb)
#   KB_NAME   qmd collection name (default: corporeation-kb)
#
# Safe to re-run: it updates the files and re-indexes.

set -euo pipefail

QMD_VERSION="2.8.3"
KB_NAME="${KB_NAME:-corporeation-kb}"
KB_DIR="${KB_DIR:-$HOME/.local/share/corporeation-kb}"
SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../kb" && pwd)"
SKIP_EMBED=false
[[ "${1:-}" == "--skip-embed" ]] && SKIP_EMBED=true

log()  { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
fail() { printf '\033[1;31merror:\033[0m %s\n' "$*" >&2; exit 1; }

# 1. Node.js
command -v node >/dev/null || fail "Node.js is not installed. Install Node 22+ (e.g. 'nvm install 22')."
node_major="$(node -p 'process.versions.node.split(".")[0]')"
(( node_major >= 22 )) || fail "qmd needs Node 22+, found $(node -v). Run 'nvm install 22 && nvm use 22' and re-run."

# 2. qmd
installed="$(qmd --version 2>/dev/null | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+' | head -1 || true)"
if [[ "$installed" != "$QMD_VERSION" ]]; then
  log "Installing qmd $QMD_VERSION (found: ${installed:-none})"
  npm install -g "@tobilu/qmd@$QMD_VERSION"
else
  log "qmd $QMD_VERSION already installed"
fi
command -v qmd >/dev/null || fail "qmd was installed but is not on PATH. Check 'npm prefix -g'/bin is in your PATH."

# 3. Copy the KB
log "Copying knowledge base to $KB_DIR"
mkdir -p "$KB_DIR"
cp -R "$SRC_DIR/." "$KB_DIR/"

# 4. Register and index
if qmd collection show "$KB_NAME" >/dev/null 2>&1; then
  log "Collection '$KB_NAME' exists — re-indexing"
else
  log "Adding collection '$KB_NAME'"
  qmd collection add "$KB_DIR" --name "$KB_NAME" --mask "**/*.md"
  qmd context add "qmd://$KB_NAME" "Corporeation company knowledge base: engineering guidelines (git, code review, TypeScript, Kotlin) and processes (onboarding, incidents, releases)"
fi
qmd update

if $SKIP_EMBED; then
  log "Skipping embeddings (keyword search only). Run 'qmd embed' later for semantic search."
else
  log "Building embeddings — first run downloads local models (~2 GB) to ~/.cache/qmd/models"
  qmd embed
  # The first query downloads the reranking and query-expansion models;
  # do it now so the first MCP search doesn't stall.
  log "Warming up search models"
  qmd query -n 1 "warm up" >/dev/null
fi

log "Done. Try: qmd query \"how do we handle a SEV1 incident\""
