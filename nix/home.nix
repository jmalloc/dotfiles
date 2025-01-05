{ config, pkgs, ... }:

{
    programs.home-manager.enable = true;

    home.username = "james";
    home.homeDirectory = "/Users/james";
    home.stateVersion = "24.11";

    home.sessionVariables = {
        EDITOR = "code";
        LESS = "--quit-if-one-screen --hilite-search --hilite-unread --ignore-case --LONG-PROMPT --RAW-CONTROL-CHARS --chop-long-lines --window=-4";
        SSH_AUTH_SOCK = "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
    };

    programs = {
        git = import ./git.nix;
        ssh = import ./ssh.nix;
        zsh = import ./zsh.nix;
    };
}
