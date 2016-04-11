# dotfiles

This is my personal dotfiles repository.

## Installation

```bash
cd ~
git clone https://github.com/jmalloc/dotfiles.git
./dotfiles/install '<lastpass username>'
source ~/.bash_profile
```

## Git Commands

- `git slug` - Print the GitHub slug (e.g. `jmalloc/dotfiles`) for the current path.
- `git clone <slug>` - Clone GitHub repo `<slug>` into `$GIT_PATH/<slug>`.
- `git cd <slug>` - Change the current directory to `$GIT_PATH/<slug>`.
- `git cd <repo>` - Change the current directory to `$GIT_PATH/<user>/<repo>`, auto-detects the GitHub username.
- `git cd --reindex` - Force a rebuild of the slug->directory mapping.
- `git changelog` - Print a changelog in Markdown format based on merge commits and tags.
- `git go link` - Create a symlink to the current path in `$GOPATH/src/github.com/<slug>`.
- `git go unlink` - Remove a symlink in `$GOPATH/src/github.com/<slug>`.
