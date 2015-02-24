if [ -f ~/.gitautocomplete ]; then
	. ~/.gitautocomplete
fi

# load not public stuff
if [ -f ~/.private/bashrc/bash_aliases ]; then
    . ~/.private/bashrc/bash_aliases
fi
