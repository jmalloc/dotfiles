# dotfiles

This is my personal dotfiles repository.

## Installation

```bash
cd ~
git clone git@github.com:jmalloc/dotfiles.git
dotfiles/setup/setup-dotfiles
source ~/.bash_profile
# set GITHUB_TOKEN=xxx in ~/.bashrc
dotfiles/setup/setup-machine
```

## Git Commands

- `git clone <user>/<repo>` - Clone a repository from GitHub into `$GIT_PATH/<user>/<repo>`.
- `git cd <repo>` - Change current directory to `$GIT_PATH/<user>/<repo>`, with bash completion.
- `git changelog` - Generate a repository changelog by treating merge commits in between tags as the changelog entries.
