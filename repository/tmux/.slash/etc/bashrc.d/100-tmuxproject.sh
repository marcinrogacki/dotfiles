# Bash completion for tmuxproject
# Installation:
#   1. Drop in ~/.bash_completion.d/tmuxproject  (and source that dir from .bashrc), OR
#   2. Add to ~/.bashrc:  source /path/to/this/file

_tmuxproject_complete() {
    local cur="${COMP_WORDS[COMP_CWORD]}"

    # Only complete the first argument
    [[ $COMP_CWORD -ne 1 ]] && return

    local projects_dir="${HOME}/.tmux/projects"

    [[ -d "$projects_dir" ]] || return

    # Build an array of project names from tmux.NAME.conf files
    local -a projects=()
    local f
    for f in "$projects_dir"/tmux.*.conf; do
        [[ -f "$f" ]] || continue
        f="${f##*/}"   # basename
        f="${f#tmux.}" # strip prefix
        f="${f%.conf}" # strip suffix
        projects+=( "$f" )
    done

    [[ ${#projects[@]} -eq 0 ]] && return

    mapfile -t COMPREPLY < <(compgen -W "${projects[*]}" -- "$cur")
    return 0
}

complete -F _tmuxproject_complete tmuxproject
