# dotfiles

This is my personal dotfiles repository.

## Installation

```bash
cd ~
git clone git@github.com:jmalloc/dotfiles.git
ln -s dotfiles/dotfiles/.bash_profile
mkdir -p .ssh
ln -s dotfiles/res/ssh-config .ssh/config
# update configuration options in .bash_profile
source ~/.bash_profile
dotfiles/setup
```

## Git Prompt

The current revision is colored to indicate whether or not it's safe to work on this branch according to the rules of git-flow.

 * green: personal branch
 * white: develop branch
 * orange: master branch or tag
 * grey: empty / no commits
 * red: any other commit

When HEAD is detached, the current revision is shown surrounded in angle brackets.

## Link Sublime Settings to Dropbox

```bash
DIR="/Users/james/Library/Application Support/Sublime Text 3/Packages/User"
rmdir "$DIR"
ln -s "/Users/james/Dropbox/Sublime User Package/" "$DIR"
```
