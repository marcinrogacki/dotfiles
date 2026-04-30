#!/usr/bin/env bash
# Cancels the pending notification scheduled by schedule-notify.sh.

input_json=$(cat)
tool_use_id=$(jq -r '.tool_use_id' <<< "$input_json")

pid_file="/tmp/cursor-hooks/$tool_use_id.pid"

if [[ -f "$pid_file" ]]; then
  pid=$(cat "$pid_file")
  kill "$pid" 2>/dev/null
  rm -f "$pid_file"
fi

exit 0
