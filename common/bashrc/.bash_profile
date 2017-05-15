if test -d ~/.slash/etc/profile.d/; then
	for file in ~/.slash/etc/profile.d/*.sh; do
		test -r "$file" && . "$file"
	done
	unset file
fi
