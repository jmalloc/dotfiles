{ pkgs, ... }: {
  homebrew = {
    enable = true;

    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;

    taps = [
      # "betsecure/tap"
      "datawire/blackbird"
      "jmalloc/grit"
    ];

    brews = [
      "adr-tools" # No Nix package. TODO: Try "adrs" Nix package.
      # "betsecure/tap/bescuttle" # TODO: Install as Nix package.
      "clang-format" # For formatting .proto files in Visual Studio Code
      "datawire/blackbird/telepresence-arm64" # TODO: Try Nix package.
      "jmalloc/grit/grit" # No Nix package.
    ];

    casks = [
      "1password-cli" # Nix package is marked as broken.
      "1password" # Nix package is marked as broken.
      "around" # No Nix package.
      "autodesk-fusion" # No nix package.
      "betterdisplay" # No nix package (macOS specific).
      "docker" # Docker Desktop
      "ghostty" # Nix package is marked as broken on Darwin
      "slack" # Nix package didn't allow loading slack:// links from Safari
    ];

    masApps = {
      "magnet" = 441258766;
      "p-touch" = 1453365242;
      "parcel" = 639968404;
    };
  };
}
