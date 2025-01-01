# Initialize zsh auto-completion, and bash compatibility.
#
# This is done after _brew_ so that it has an opportunity to add itself to
# FPATH, but before other commands (like Grit) that install Bash
# autocompletions.
autoload -U compinit
autoload -U bashcompinit
compinit
bashcompinit

# zstyle ':completion:*' matcher-list 'r:|?=**'
zstyle ':completion:*' menu select
