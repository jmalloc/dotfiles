export USERNAMES="james jmalloc" # prompt shows username if not in this list
export HISTCONTROL="ignoreboth"
export EDITOR="vim"
export VISUAL="$EDITOR"
export PATH="$HOME/bin:$HOME/.gem/ruby/2.4.0/bin:$PATH:$HOME/go/bin"

for FILE in "$HOME/.bash_profile.d/"*; do
    source "$FILE"
done

for FILE in "$HOME/dotfiles/bash_profile.d/"*; do
    source "$FILE"
done

if [ -f "$HOME/.bashrc" ]; then
    source "$HOME/.bashrc"
fi
