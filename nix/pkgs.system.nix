{ pkgs }:
[
  pkgs.git
  pkgs.google-chrome
  pkgs.less # GNU less is required for the --quit-if-one-screen option to work properly
  pkgs.unixtools.watch
  pkgs.vim
]
