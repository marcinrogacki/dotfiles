#!/bin/sh
COMMIT_MSG_FILE=$1
COMMIT_SOURCE=$2
SHA1=$3

# When empty we are in simple commit case (no --amend nor non fast-forward merge)
if [[ -z "$SHA1" && -z "$COMMIT_SOURCE" ]]; then
    # Add branch name at the beginning of the commit message
    echo -e "`git rev-parse --abbrev-ref HEAD`\n$(cat "$COMMIT_MSG_FILE")" > $COMMIT_MSG_FILE
fi
