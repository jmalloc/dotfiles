{ pkgs, ... }: {
  # These packages do not require any additional configuration.
  #
  # If a package _does_ require further configuration, or has related shell
  # variables, aliases, etc, then move it to a separate module and add it to the
  # import list below.
  home.packages = [
    pkgs.evans
    pkgs.google-chrome
    pkgs.graphviz
    pkgs.jq
    pkgs.kcl
    pkgs.mob
    pkgs.nixpkgs-fmt
    pkgs.nodejs
    pkgs.pgcli
    pkgs.unixtools.watch
    pkgs.vale
    pkgs.wabt
    pkgs.wasmer
    pkgs.yarn
    pkgs.yq-go
    pkgs.zoom-us
  ];

  # Aliases for things that are installed via Brew.
  home.shellAliases = {
    b = "bsctl";
    d = "docker";
    tp = "telepresence";
  };

  imports = [
    ./home/aws.nix
    ./home/bat.nix
    ./home/ghostty.nix
    ./home/git.nix
    ./home/go.nix
    ./home/k8s.nix
    ./home/less.nix
    ./home/make.nix
    ./home/ssh.nix
    ./home/starship.nix
    ./home/terraform.nix
    ./home/vscode.nix
    ./home/zsh.nix
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}
