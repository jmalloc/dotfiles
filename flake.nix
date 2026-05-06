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
      # url = "github:zhaofengli-wip/nix-homebrew";
      # Pinned to 2026-01-26 to avoid masApps installation failure (https://github.com/zhaofengli/nix-homebrew/issues/131)
      url = "github:zhaofengli/nix-homebrew/a5409abd0d5013d79775d3419bcac10eacb9d8c5";
    };

    # https://github.com/hraban/mac-app-util
    # Ensures macOS applications are indexed by Spotlight
    mac-app-util = {
      url = "github:hraban/mac-app-util";
      # nixpkgs is pinned to some specific hash
    };

    # https://github.com/nix-community/home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
