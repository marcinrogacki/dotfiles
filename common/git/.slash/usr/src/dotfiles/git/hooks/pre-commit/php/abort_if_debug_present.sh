#!/bin/sh
#
# this hook will looks for var_dump or debug string in changed files, and abort
# commit if there's one. "debug" may be used to mark places which you don't want
# to commit (i.e commented out validation)

VAR=$(git diff --cached | grep -wi "var_dump\|debug")
if [ ! -z "$VAR" ]; then
  echo "[EE] 'var_dump' or 'debug' in commiting code"
  exit 1
fi
