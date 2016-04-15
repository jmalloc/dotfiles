# dotfiles

This is my personal dotfiles repository.

## Installation

```bash
cd ~
git clone https://github.com/jmalloc/dotfiles.git
./dotfiles/install '<lastpass username>'
source ~/.bash_profile
```

## Git[Hub] Commands

- `git slug` - Print the GitHub slug (e.g. `jmalloc/dotfiles`) for the current path.
- `git clone <slug>` - Clone GitHub repo `<slug>` into `$GIT_PATH/<slug>`.
- `git cd <slug>` - Change the current directory to `$GIT_PATH/<slug>`.
- `git cd <repo>` - Change the current directory to `$GIT_PATH/<user>/<repo>`, auto-detects the GitHub username.
- `git cd --reindex` - Force a rebuild of the slug->directory mapping.
- `git open` - Open the current GitHub repository in a browser, opens the current tag, branch or commit.
- `git open -i|--issue` - If the current branch name begins with a number, opens that issue number, otherwise opens the issue list. 
- `git open -i|--issue <number>` - Open the specified issue for the current repository in a browser.
- `git changelog` - Print a changelog in Markdown format based on merge commits and tags.
- `git go link` - Create a symlink to the current path in `$GOPATH/src/github.com/<slug>`.
- `git go unlink` - Remove a symlink in `$GOPATH/src/github.com/<slug>`.
