#!/usr/bin/env bash

input=$(cat)

message=$(
  jq -r '
    (.workspace_roots
      | map(rtrimstr("/") | split("/") | .[-3:] | join("/"))
      | join("\n"))
  ' <<< "$input"
)

message=${message:-"Workspace roots: unknown"}

notify-send \
  --app-name="Cursor" \
  --icon="$HOME/.cursor/hooks/icon_32x32.png" \
  --urgency=critical \
  --expire-time=10000 \
  --category="dev.tool" \
  "Context compact" \
  "$message"

exit 0
