# Fix the problem:
# $ secret-tool store --label="MRO" service mro username mro
# Password: secret-tool: Object does not exist at path “/org/freedesktop/secrets/collection/login”
# Source:
# https://wiki.archlinux.org/title/GNOME/Keyring#No_such_secret_collection_at_path:_/
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# Ensure that GPG can interact correctly with terminal, especially when asking for a passphrase.
# It allows prompt for password in terminal.
export GPG_TTY=$(tty)
