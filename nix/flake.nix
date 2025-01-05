{
  description = "nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    mac-app-util.url = "github:hraban/mac-app-util";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{
    self,
    nix-darwin,
    nixpkgs,
    mac-app-util,
    nix-homebrew,
    home-manager,
  }:
  let configuration = { pkgs, ... }: {
    users.users.james = {
      name = "james";
      home = "/Users/james";
    };

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
        pkgs.less # GNU less is required for the --quit-if-one-screen option to work properly
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
          "betterdisplay"
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

      environment.shellAliases = {
        d  = "docker";
        e  = "code .";
        g  = "git";
        h  = "helm";
        k  = "kubectl";
        m  = "make";
        tf = "terraform";
        tp = "telepresence";
        ls = "ls -lhG";
        la = "ls -lhGa";
      };

      programs.ssh = {
        extraConfig = ''
          Host *
            IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
        '';

        knownHosts = {
          github_ed25519 = {
            hostNames = ["github.com"];
            publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
          };
          github_ecdsa = {
            hostNames = ["github.com"];
            publicKey = "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg=";
          };
          github_rsa = {
            hostNames = ["github.com"];
            publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCj7ndNxQowgcQnjshcLrqPEiiphnt+VTTvDP6mHBL9j1aNUkY4Ue1gvwnGLVlOhGeYrnZaMgRK6+PKCUXaDbC7qtbW8gIkhL7aGCsOr/C56SJMy/BCZfxd1nWzAOxSDPgVsmerOBYfNqltV9/hWCqBywINIR+5dIg6JTJ72pcEpEjcYgXkE2YEFXV1JHnsKgbLWNlhScqb2UmyRkQyytRLtL+38TGxkxCflmO+5Z8CSSNY7GidjMIZ7Q4zMjA2n1nGrlTDkzwDCsw+wqFPGQA179cnfGWOWRVruj16z6XyvxvjJwbz0wQZ75XK5tKSb7FNyeIEs4TT4jk+S4dhPeAUC5y+bDYirYgM4GC7uEnztnZyaVWQ7B381AK4Qdrwt51ZqExKbQpTUNn+EjqoTwvqNj4kqx5QUCI0ThS/YkOxJCXmPUWZbhjpCg56i+2aB6CmK2JGhn57K5mj0MNdBXA4/WnwH6XoPWJzK5Nyu2zB3nAZp+S5hpQs+p1vN1/wsjk=";
          };
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

        dock = {
          static-only = true;
          persistent-apps = [];
          autohide = true;
          autohide-delay = 1000.0; # "disable" the dock
        };
      };

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

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
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.james = import ./home.nix;
        }
        nix-homebrew.darwinModules.nix-homebrew {
          nix-homebrew = {
            enable = true;
            user = "james";
          };
        }
      ];
    };
  };
}
