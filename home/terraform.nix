{ pkgs, ... }:
{
  home = {
    packages = [ pkgs.terraform ];

    shellAliases = {
      tf = "terraform";
    };
  };
}
