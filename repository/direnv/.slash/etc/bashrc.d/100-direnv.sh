# For direnv to work properly it needs to be hooked into the shell.
# Make sure it appears even after rvm, git-prompt and other shell extensions that manipulate the prompt.
# https://direnv.net/docs/hook.html#bash
eval "$(direnv hook bash)"
