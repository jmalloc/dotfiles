# Initialize zsh auto-completion, and bash compatibility.
autoload -U compinit
autoload -U bashcompinit
compinit
bashcompinit

setopt clobber # allow output redirection to clobber existing files

for FILE in "$HOME/.dotfiles/zshrc.d/"*; do
    source "$FILE"
done

function git {
    if [[ "$1" == "checkout" ]]; then
        echo 'ERROR: Use "git switch" or "git restore" instead' >&2
        return 1
    else
        command git "$@"
    fi
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
