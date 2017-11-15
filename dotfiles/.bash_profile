export PATH="$HOME/bin:$HOME/go/bin:$HOME/.gem/ruby/2.4.0/bin:$PATH"
export USERNAMES="james jmalloc"
export HISTCONTROL="ignoreboth"
export EDITOR="vim"
export VISUAL="$EDITOR"

ulimit -n 8192

for FILE in "$HOME/.bash_profile.d/"*; do
    source "$FILE"
done

for FILE in "$HOME/dotfiles/bash_profile.d/"*; do
    source "$FILE"
done

if [ -f "$HOME/.bashrc" ]; then
    source "$HOME/.bashrc"
fi
