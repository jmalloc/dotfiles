{
  self,
  nix-darwin,
  mac-app-util,
  home-manager,
  nix-homebrew,
  ...
}:
let
  user = {
    name = "james";
    home = "/Users/james";
  };

  modules = [
    {
      nix = {
        settings = {
          experimental-features = "nix-command flakes";
        };
      };

      nixpkgs = {
        hostPlatform = "aarch64-darwin";
        config = {
          allowUnfree = true;
        };
      };

      system = {
        primaryUser = user.name;
        configurationRevision = self.rev or self.dirtyRev or null;
        stateVersion = 5;
      };

      users.users.${user.name} = user;
    }

    mac-app-util.darwinModules.default

    home-manager.darwinModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        sharedModules = [ mac-app-util.homeManagerModules.default ];
        users.${user.name} = import ./home.nix;
      };
    }

    nix-homebrew.darwinModules.nix-homebrew
    {
      nix-homebrew = {
        enable = true;
        user = user.name;
      };
    }

    (import ./darwin/brew.nix)
    (import ./darwin/mas.nix)
    (import ./darwin/ssh.nix)
    (import ./darwin/machine.common.nix)
  ];
in
{
  # M4 Mac mini
  "XLHWC6CH2D" = nix-darwin.lib.darwinSystem {
    modules = modules ++ [
      (import ./darwin/machine.desktop.nix)
      { networking.hostName = "studio-mac"; }
    ];
  };

  # M1 Mac mini
  "C07G60W2Q6P0" = nix-darwin.lib.darwinSystem {
    modules = modules ++ [
      (import ./darwin/machine.desktop.nix)
      { networking.hostName = "workshop-mac"; }
    ];
  };

  # MacBook Pro (Silver)
  "H34L3QX9TT" = nix-darwin.lib.darwinSystem {
    modules = modules ++ [
      (import ./darwin/machine.laptop.nix)
      { networking.hostName = "james-mpb-old"; }
    ];
  };

  # MacBook Pro (Black)
  "J2XM7FJ26H" = nix-darwin.lib.darwinSystem {
    modules = modules ++ [
      (import ./darwin/machine.laptop.nix)
      { networking.hostName = "james-mpb"; }
    ];
  };
}
