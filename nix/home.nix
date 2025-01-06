{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;
  home.stateVersion = "24.11";

  home = {
    username = "james";
    homeDirectory = "/Users/james";
    packages = import ./pkgs.user.nix { inherit pkgs; };
    sessionPath = import ./shell.path.nix;
    sessionVariables = import ./shell.env.nix;
    shellAliases = import ./shell.aliases.nix;

    file = {
      ghostty = {
        enable = true;
        source = ./ghostty.config;
        target = "Library/Application\ Support/com.mitchellh.ghostty/config";
        force = true;
      };
    };
  };

  programs = {
    git = import ./program.git.nix;
    ssh = import ./program.ssh.nix;
    zsh = import ./program.zsh.nix;
  };
}
