# Initialize zsh auto-completion, and bash compatibility.
autoload -U compinit
autoload -U bashcompinit
compinit
bashcompinit

zstyle ':completion:*' matcher-list 'r:|?=**'
zstyle ':completion:*' menu select

# Undo aliasing of run-help to man, so it can be used to get help on zsh builtins.
unalias run-help
autoload run-help

setopt clobber # allow output redirection to clobber existing files
ulimit -n 8192 # set shell's open file handle limit

for FILE in "$HOME/.dotfiles/public/zshrc.d/"*.zsh; do
    source "$FILE"
done

for FILE in "$HOME/.dotfiles/private/zshrc.d/"*.zsh; do
    source "$FILE"
done

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
