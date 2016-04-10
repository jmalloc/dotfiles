# dotfiles

This is my personal dotfiles repository.

## Installation

```bash
cd ~
git clone https://github.com/jmalloc/dotfiles.git # Needed before SSH cert is available.
git remote set-url origin git@github.com:jmalloc/dotfiles.git
./dotfiles/install
source ~/.bash_profile
```

## Git Commands

- `git clone <user>/<repo>` - Clone a repository from GitHub into `$GIT_PATH/<user>/<repo>`.
- `git cd <repo>` - Change current directory to `$GIT_PATH/<user>/<repo>`, with bash completion.
- `git changelog` - Generate a repository changelog by treating merge commits in between tags as the changelog entries.
