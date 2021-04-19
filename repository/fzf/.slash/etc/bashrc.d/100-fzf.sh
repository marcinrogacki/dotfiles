# Those files are provided by the Arch Linux after a installation of the fzf
# package.
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

# Exclude files from .gitignore and search hidden
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
