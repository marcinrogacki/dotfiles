function hostip() {
    /sbin/ifconfig | grep "inet " | awk '{print $2}' | grep -v 127.0.0.1 | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/,/g'
}

# Allows kill a program by searching a string in process list (e.g. by parameter)
function akill() {
    program_name="$1"

    if [[ -z "${program_name// }" ]]; then
        (>&2 echo "Program name cannot be empty. Please provide program name in parameters.")
    else
        ps aux | grep -i "$program_name" | grep -v grep | awk '{print $2}' | xargs kill -9
    fi
}

if [ -f ~/.gitautocomplete ]; then
	. ~/.gitautocomplete
fi

# load not public stuff
if [ -f ~/.slash/home/bash_aliases ]; then
    . ~/.slash/home/bash_aliases
fi
