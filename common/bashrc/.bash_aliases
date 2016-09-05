function hostip() {
    /sbin/ifconfig | grep "inet " | awk '{print $2}' | grep -v 127.0.0.1 | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/,/g'
}

if [ -f ~/.gitautocomplete ]; then
	. ~/.gitautocomplete
fi

# load not public stuff
if [ -f ~/.slash/home/bash_aliases ]; then
    . ~/.slash/home/bash_aliases
fi
