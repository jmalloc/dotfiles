{
  enable = true;
  initExtra = builtins.readFile ../home/zshrc;

  autosuggestion = {
    enable = true;
  };

  syntaxHighlighting = {
    enable = true;
  };
}
