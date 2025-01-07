{ ... }: {
  home = {
    shellAliases = {
      la = "ls -lhGa";
      ls = "ls -lhG";
    };
  };

  programs.zsh = {
    enable = true;

    initExtra = builtins.readFile ./zshrc;

    autosuggestion = {
      enable = true;
    };

    syntaxHighlighting = {
      enable = true;
    };
  };
}
