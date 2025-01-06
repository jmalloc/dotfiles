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
      aws = {
        enable = true;
        source = ./config/aws;
        target = ".aws/config";
        force = true;
      };

      ghostty = {
        enable = true;
        source = ./config/ghostty;
        target = "Library/Application\ Support/com.mitchellh.ghostty/config";
        force = true;
      };
    };
  };

  programs = {
    bat = import ./program.bat.nix;
    git = import ./program.git.nix;
    ssh = import ./program.ssh.nix;
    starship = import ./program.starship.nix;
    zsh = import ./program.zsh.nix;
  };
}
