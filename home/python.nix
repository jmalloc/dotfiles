{ pkgs, ... }:
{
  home = {
    packages = [
      pkgs.python311
      pkgs.python311Packages.pip
    ];
  };
}
