# dotfiles

This is my personal dotfiles repository.

## Installation

```bash
cd ~
git clone https://github.com/jmalloc/dotfiles.git
./dotfiles/install '<lastpass username>'
source ~/.bash_profile
```

## Git[Hub] Commands and Aliases

- `git slug` - Print the GitHub slug (e.g. `jmalloc/dotfiles`) for the current path.
- `git open` - Open the current GitHub repository in a browser, opens the current tag, branch or commit.
- `git open -i|--issue` - If the current branch name begins with a number, opens that issue number, otherwise opens the issue list.
- `git open -i|--issue <number>` - Open the specified issue for the current repository in a browser.
- `git changelog` - Print a changelog in Markdown format based on merge commits and tags.
- `git unstage` - Unstage files (alias for `reset HEAD --`).
- `git scrub` - Remove all unstaged changes in the working directory.
- `git destroy` - Remove **all** changes in the working directory.
