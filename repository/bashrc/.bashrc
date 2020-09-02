# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if test -d ~/.slash/etc/bashrc.d/; then
	for file in ~/.slash/etc/bashrc.d/*.sh; do
		test -r "$file" && . "$file"
	done
	unset file
fi
