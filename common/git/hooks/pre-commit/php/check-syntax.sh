#!/bin/sh
#
# this hook will check commited files agains syntax errors and abort
# commit if there's any bad file.

#git diff --staged --cached --name-only | xargs -I {} php -l {} | sed '/No syntax errors detected in/ d'

error=0
for file in `git diff --staged --cached --name-only`; do
#    result=`php -l "$file"`
    result=`git show :"$file" | php -l`
    if [ $? -ne 0 ]; then
        echo "[EE] Syntax error in $file"
        echo "$result"
        error=1
    fi
done

if [ $error -eq 1 ]; then
    exit 1
fi
