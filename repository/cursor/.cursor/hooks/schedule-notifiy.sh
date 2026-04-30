#!/usr/bin/env bash
# Sends a desktop notification and asks for approval only for risky commands.
# Safe/read-only commands are allowed silently.

input_json=$(cat)
conversation_id=$(jq -r '(.conversation_id)' <<< "$input_json")
chat_db="`find $HOME/.cursor -name "$conversation_id" | grep chats`/store.db"
# Check whether tool need approval
if sqlite3 "$chat_db" "SELECT CAST(data AS TEXT) AS payload FROM blobs;" \
    | grep -a '"role":"assistant"' \
    | tail -n 1 \
    | grep -a -q "pendingToolCallStartedAtMs"
then
  notify-send \
    --app-name="Cursor" \
    --icon="$HOME/.cursor/hooks/icon_32x32.png" \
    --urgency=critical \
    --expire-time=10000 \
    --category="dev.tool" \
    "Pending action" \
    "$message"
fi

exit 0
