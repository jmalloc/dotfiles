{ self
, nix-darwin
, mac-app-util
, home-manager
, nix-homebrew
, ...
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
        config = { allowUnfree = true; };
      };

      system = {
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
    (import ./darwin/ssh.nix)
    (import ./darwin/machine.common.nix)
  ];
in
{
  # M4 Mac mini
  "3571D32A-50AE-5E84-B982-06A591BBDD20" = nix-darwin.lib.darwinSystem {
    modules = modules ++ [ (import ./darwin/machine.desktop.nix) ];
  };

  # M1 Mac mini
  "EBCF8D9B-0E58-56ED-806F-D314B2761BB4" = nix-darwin.lib.darwinSystem {
    modules = modules ++ [ (import ./darwin/machine.desktop.nix) ];
  };

  MacBookPro = nix-darwin.lib.darwinSystem {
    modules = modules ++ [ (import ./darwin/machine.laptop.nix) ];
  };
}
