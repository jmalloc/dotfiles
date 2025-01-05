{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.username = "james";
  home.homeDirectory = "/Users/james";
  home.stateVersion = "24.11";

  home.sessionVariables = import ./env.nix;
  home.shellAliases = import ./alias.nix;

  home.packages = [
    pkgs.awscli
    pkgs.evans
    pkgs.go
    pkgs.graphviz
    pkgs.jq
    pkgs.kubectl
    pkgs.kubectx
    pkgs.kubernetes-helm
    pkgs.mob
    pkgs.nixpkgs-fmt
    pkgs.pgcli
    pkgs.terraform
    pkgs.vale
    pkgs.vscode
    pkgs.zoom-us
  ];

  programs = {
    git = import ./git.nix;
    ssh = import ./ssh.nix;
    zsh = import ./zsh.nix;
  };
}
