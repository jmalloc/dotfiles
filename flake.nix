{
  description = "jmalloc's dotfiles flake";

  outputs =
    args@{ ... }:
    {
      darwinConfigurations = import ./darwin.nix args;
    };

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };

    # https://github.com/LnL7/nix-darwin
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # https://github.com/zhaofengli/nix-homebrew
    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
    };

    # https://github.com/hraban/mac-app-util
    # Ensures macOS applications are indexed by Spotlight
    mac-app-util = {
      url = "github:hraban/mac-app-util";
      # mac-app-util pins its own nixpkgs; inputs.nixpkgs.follows is not supported.
    };

    # https://github.com/nix-community/home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
