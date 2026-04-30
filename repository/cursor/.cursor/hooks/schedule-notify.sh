#!/usr/bin/env bash
# Schedules a delayed notification (1 min) that a tool is waiting for approval.
# If postToolUse fires before the delay, cancel-notify.sh kills the process.

return 0
input_json=$(cat)
tool_use_id=$(jq -r '.tool_use_id' <<< "$input_json")
workspace=$(
  jq -r '
    (.workspace_roots
      | map(rtrimstr("/") | split("/") | .[-3:] | join("/"))
      | join("\n"))
  ' <<< "$input"
)

pid_dir="/tmp/cursor-hooks"
mkdir -p "$pid_dir"
pid_file="$pid_dir/$tool_use_id.pid"

(
  sleep 60
  notify-send \
    --app-name="Cursor" \
    --icon="$HOME/.cursor/hooks/icon_32x32.png" \
    --urgency=critical \
    --expire-time=0 \
    --category="dev.tool" \
    "Pending approval" \
    "$workspace"
  rm -f "$pid_file"
) &

echo $! > "$pid_file"

exit 0
