{ pkgs, ... }: {
  home = {
    packages = [ pkgs.gnumake ];

    shellAliases = {
      m = "make";
    };
  };
}
