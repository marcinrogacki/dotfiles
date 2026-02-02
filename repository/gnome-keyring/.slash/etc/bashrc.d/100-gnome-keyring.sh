# Ensure that GPG can interact correctly with terminal, especially when asking for a passphrase.
# It allows prompt for password in terminal.
export GPG_TTY=$(tty)
