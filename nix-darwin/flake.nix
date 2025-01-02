{
  description = "nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = inputs@{
    self,
    nix-darwin,
    nixpkgs,
    mac-app-util,
    nix-homebrew,
  }:
  let configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = [
        pkgs.awscli
        pkgs.evans
        pkgs.git
        pkgs.go
        pkgs.google-chrome
        pkgs.graphviz
        pkgs.jq
        pkgs.kubectl
        pkgs.kubectx
        pkgs.kubernetes-helm
        pkgs.less # required for the --quit-if-one-screen option to work properly
        pkgs.mob
        pkgs.pgcli
        pkgs.terraform
        pkgs.unixtools.watch
        pkgs.vale
        pkgs.vim
        pkgs.vscode
        pkgs.zoom-us
      ];

      homebrew = {
        enable = true;

        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;

        taps = [
          "datawire/blackbird"
          "jmalloc/grit"
        ];

        brews = [
          "adr-tools"
          "datawire/blackbird/telepresence-arm64"
          "jmalloc/grit/grit"
        ];

        casks = [
          "1password"
          "1password-cli"
          "around"
          "slack"
        ];

        masApps = {
          "magnet" = 441258766;
          "parcel" = 639968404;
        };
      };

      programs.direnv.enable = true;

      environment.etc = {
        "zshrc.local" = {
          enable = true;
          text = ''
            eval "$(grit shell-integration)"
          '';
        };
      };

      power = {
        restartAfterPowerFailure = true;
        restartAfterFreeze = true;

        sleep = {
          computer = "never";
          display = "never";
        };
      };

      # programs.zsh = {
      #   variables = {
      #     SSH_AUTH_SOCK = "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
      #   };
      # };

      system.defaults = {
        NSGlobalDomain = {
          AppleKeyboardUIMode = 3;
          "com.apple.keyboard.fnState" = true;

          ApplePressAndHoldEnabled = false;
          InitialKeyRepeat = 15;
          KeyRepeat = 2;

          NSAutomaticCapitalizationEnabled = false;
          NSAutomaticDashSubstitutionEnabled = false;
          NSAutomaticPeriodSubstitutionEnabled = false;
          NSAutomaticQuoteSubstitutionEnabled = false;
          NSAutomaticSpellingCorrectionEnabled = false;
        };
      };

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      # Allow unfree (non-open-source) packages.
      nixpkgs.config.allowUnfree = true;
    };
  in {
    darwinConfigurations.common = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        mac-app-util.darwinModules.default
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            user = "james";
          };
        }
      ];
    };
  };
}
