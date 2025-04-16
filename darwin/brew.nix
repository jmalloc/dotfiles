{ pkgs, ... }:
{
  homebrew = {
    enable = true;

    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;

    taps = [
      "betsecure/tap"
      "hashicorp/tap"
      "jmalloc/grit"
      "kcl-lang/tap"
    ];

    brews = [
      "adr-tools" # No Nix package. TODO: Try "adrs" Nix package.
      "betsecure/tap/bescuttle"
      "betsecure/tap/telepresence"
      "clang-format" # For formatting .proto files in Visual Studio Code
      "hashicorp/tap/tfstacks" # No Nix package.
      "jmalloc/grit/grit" # No Nix package.
      "kcl-lang/tap/kcl-lsp" # No Nix package.
      "vsce" # No Nix package.
    ];

    casks = [
      "1password-cli" # Nix package is marked as broken.
      "1password" # Nix package is marked as broken.
      "around" # No Nix package.
      "autodesk-fusion" # No nix package.
      "betterdisplay" # No nix package (macOS specific).
      "coscreen" # No Nix package.
      "docker" # Docker Desktop
      "drovio" # No Nix package.
      "ghostty" # Nix package is marked as broken on Darwin
      "live-home-3d" # No Nix package.
      "pop" # No Nix package.
      "slack" # Nix package didn't allow loading slack:// links from Safari
    ];

    masApps = {
      "magnet" = 441258766;
      "p-touch" = 1453365242;
      "parcel" = 639968404;
    };
  };
}
