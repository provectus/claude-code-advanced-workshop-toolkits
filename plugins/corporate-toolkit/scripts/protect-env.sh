#!/usr/bin/env bash
# PreToolUse hook: block Claude from editing .env files.
# Receives the tool call as JSON on stdin; exit code 2 blocks the call
# and sends stderr back to Claude.

input="$(cat)"

if printf '%s' "$input" | grep -Eq '"file_path"[[:space:]]*:[[:space:]]*"[^"]*(^|/)\.env(\.[^"/]*)?"'; then
  echo "Blocked by corporate-toolkit: editing .env files is not allowed. Ask the user to change secrets manually." >&2
  exit 2
fi

exit 0
