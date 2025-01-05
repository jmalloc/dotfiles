{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.username = "james";
  home.homeDirectory = "/Users/james";
  home.stateVersion = "24.11";

  programs = {
    git = import ./git.nix;
  };
}
