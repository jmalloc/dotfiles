# Intallation

    cd ~
    git clone git://github.com/jmalloc/dotfiles.git
    cp dotfiles/.bash_profile ~
    source ~/.bash_profile

# Git Prompt

The current revision is colored to indicate whether or not it's safe to work on this branch according to the rules of git-flow.

 * green: personal branch
 * white: develop branch
 * orange: master branch
 * gold: detached head (tag)
 * red: detached head (other)
 * grey: detached head (empty / no commits)

When HEAD is detached, the current revision is shown surrounded in angle brackets.
