{
  enable = true;
  initExtra = builtins.readFile ./config/zshrc;

  autosuggestion = {
    enable = true;
  };

  syntaxHighlighting = {
    enable = true;
  };
}
