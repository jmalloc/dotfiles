# dotfiles

This is my personal dotfiles repository.

## Installation

```bash
cd ~
git clone git@github.com:jmalloc/dotfiles.git
ln -s dotfiles/dotfiles/.bash_profile
# update configuration options in .bash_profile
source ~/.bash_profile
update-dotfiles
```

## Git Prompt

The current revision is colored to indicate whether or not it's safe to work on this branch according to the rules of git-flow.

 * green: personal branch
 * white: develop branch
 * orange: master branch or tag
 * grey: empty / no commits
 * red: any other commit

When HEAD is detached, the current revision is shown surrounded in angle brackets.

---
[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/jmalloc/dotfiles/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
