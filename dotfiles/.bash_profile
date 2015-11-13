# Path for "rclone" to clone into ...
GIT_DIR_GITHUB="$HOME/Documents/GitHub"

# Path for "rclone-cwx" to clone into ...
GIT_DIR_CWX="$HOME/Documents/Codeworx"

# Directories to search when using "rcd" ...
# This probably wont work if any of the directory names contain spaces.
GIT_DIR_LIST="$GIT_DIR_GITHUB $GIT_DIR_CWX"

# A space separated list of usernames considered to be "me" ...
DEFAULT_USERNAMES="james"

export DOTFILES_REPO="$HOME/dotfiles"

export PATH="$HOME/bin:$DOTFILES_REPO/bin:/opt/local/bin:/opt/local/sbin:$PATH:/opt/local/lib/mariadb-10.0/bin"
export HISTCONTROL="ignoreboth"

# Source the library files ...
for filename in $DOTFILES_REPO/lib/*.bash; do
    source $filename
done

unset filename

# Source bashrc file if it exists ...
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
