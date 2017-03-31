#!/bin/bash
base_path_file="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"

if [ -L "$base_path_file" ]; then
    base_path_file=`readlink -f "$base_path_file"`
fi
base_path=`dirname "$base_path_file"`

if [ ! -d .git ]; then
    echo "[EE] Not a git repository. Miss the '.git' directory. Are you in project directory? Aborting."
    exit 1;
fi

all_scripts=`find "$base_path"/hooks -type f`
for script_path in $all_scripts; do
    script_name=`basename "$script_path"`
    category=$(basename $(dirname $script_path))
    destination_hook=$(basename $(dirname $(dirname $script_path)))
    script="$destination_hook/$category/$script_name"
    hook_source_script_dir=.git/hooks/scripts/"$destination_hook/$category"
    hook_source_script_file="$hook_source_script_dir/$script_name"

    if grep -q "$script" .git/hooks/"$destination_hook" 2>/dev/null; then
        if [ ! -f "$hook_source_script_file" ]; then
            if [ ! -d "$hook_source_script_dir" ]; then
                mkdir -p "$hook_source_script_dir"
            fi
            cp "$script_path" "$hook_source_script_dir"
        fi

        echo "Already installed: $script"
    else
        prompt_message="Install: $script? [y/N]"

        echo -n $prompt_message
        read -n 1 prompt
        echo

        if [[ $prompt == "Y" || $prompt == "y" ]]; then
            if [ ! -d "$hook_source_script_dir" ]; then
                mkdir -p "$hook_source_script_dir"
            fi
            cp "$script_path" "$hook_source_script_dir"
            echo "$hook_source_script_dir/$script_name" >> .git/hooks/"$destination_hook"
        fi
    fi

    if [[ -f .git/hooks/"$destination_hook" && ! -x .git/hooks/"$destination_hook" ]]; then
        chmod +x .git/hooks/"$destination_hook"
    fi
done
