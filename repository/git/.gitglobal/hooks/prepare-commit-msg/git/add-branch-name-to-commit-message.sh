#!/bin/sh
COMMIT_MSG_FILE=$1
COMMIT_SOURCE=$2
SHA1=$3

# --amend case
if [ "$SHA1" == "HEAD" ]; then
    exit 0
fi

# Add branch name at the beginning of the commit message
echo -e "`git rev-parse --abbrev-ref HEAD`\n$(cat "$COMMIT_MSG_FILE")" > $COMMIT_MSG_FILE
