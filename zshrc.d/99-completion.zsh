# Initialize zsh auto-completion, and bash compatibility.
#
# This is done after everything else so that the other scripts have the
# opportunity to modify FPATH.
autoload -U compinit
autoload -U bashcompinit
compinit
bashcompinit

zstyle ':completion:*' matcher-list 'r:|?=**'
zstyle ':completion:*' menu select
