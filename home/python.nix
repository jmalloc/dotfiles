{ pkgs, ... }:
{
  home = {
    packages = [
      pkgs.python314
      pkgs.python314Packages.pip
    ];
  };
}
