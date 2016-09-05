if [ -f ~/.gitautocomplete ]; then
	. ~/.gitautocomplete
fi

# load not public stuff
if [ -f ~/.slash/home/bash_aliases ]; then
    . ~/.slash/home/bash_aliases
fi
