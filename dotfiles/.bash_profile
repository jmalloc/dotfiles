export GOPATH="$HOME/.go"

# Path for "rclone" to clone into ...
GIT_DIR_GITHUB="$HOME/Documents/GitHub"

# Directories to search when using "rcd" ...
# This probably wont work if any of the directory names contain spaces.
GIT_DIR_LIST="$GOPATH/src/github.com $GIT_DIR_GITHUB"

# A space separated list of usernames considered to be "me" ...
DEFAULT_USERNAMES="james"

export DOTFILES_REPO="$HOME/dotfiles"
export PATH="$DOTFILES_REPO/bin:$HOME/bin:$GOPATH/bin:/opt/local/bin:/opt/local/sbin:$PATH"
export HISTCONTROL="ignoreboth"

# Source the library files ...
for filename in $DOTFILES_REPO/lib/*.bash; do
    source $filename
done
unset filename

ulimit -n 8192

composer config -g -- sort-packages true

# Source bashrc file if it exists ...
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
