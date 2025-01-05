{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.username = "james";
  home.homeDirectory = "/Users/james";
  home.stateVersion = "24.11";

  home.sessionVariables = import ./env.nix;
  home.shellAliases = import ./alias.nix;

  programs = {
    git = import ./git.nix;
    ssh = import ./ssh.nix;
    zsh = import ./zsh.nix;
  };
}
