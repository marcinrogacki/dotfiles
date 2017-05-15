if test -d ~/.slash/etc/alias.d/; then
	for file in ~/.slash/etc/alias.d/*.sh; do
		test -r "$file" && . "$file"
	done
	unset file
fi
