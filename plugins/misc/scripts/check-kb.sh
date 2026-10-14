#!/usr/bin/env bash
# SessionStart hook: check that qmd and the KB collection are set up.
# Prints nothing when everything is ready. Otherwise shows the user a
# one-line setup hint and tells Claude the KB is unavailable. Never
# installs anything itself.

KB_NAME="${KB_NAME:-corporeation-kb}"
INSTALL="bash \"${CLAUDE_PLUGIN_ROOT}/scripts/install-kb.sh\""

if ! command -v qmd >/dev/null 2>&1; then
  problem="qmd is not installed (or Node 22+ is not on PATH)"
elif ! qmd collection show "$KB_NAME" >/dev/null 2>&1; then
  problem="the '$KB_NAME' collection is missing"
else
  exit 0
fi

msg="Knowledge base not set up: $problem. Run: $INSTALL — then restart Claude Code."

# JSON-escape the message for the hook output.
json_msg="$(printf '%s' "$msg" | sed 's/\\/\\\\/g; s/"/\\"/g')"
printf '{"systemMessage":"%s","hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"%s The search-kb skill will not work until the user runs the installer."}}\n' "$json_msg" "$json_msg"
exit 0
