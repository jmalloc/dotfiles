{ pkgs, ... }: {
  home = {
    packages = [ pkgs.vscode ];

    shellAliases = {
      e = "code .";
    };

    sessionVariables = {
      EDITOR = "code -w";
    };
  };
}
