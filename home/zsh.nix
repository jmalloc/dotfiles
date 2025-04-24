{ ... }:
{
  home = {
    shellAliases = {
      la = "ls -lhGa";
      ls = "ls -lhG";
    };
  };

  programs.zsh = {
    enable = true;

    initContent = builtins.readFile ./zshrc;

    autosuggestion = {
      enable = true;
    };

    syntaxHighlighting = {
      enable = true;
    };
  };
}
