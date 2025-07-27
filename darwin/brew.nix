{ pkgs, ... }:
{
  homebrew = {
    enable = true;

    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;

    taps = [
      "hashicorp/tap"
      "jmalloc/grit"
      "kcl-lang/tap"
    ];

    brews = [
      "adr-tools" # No Nix package. TODO: Try "adrs" Nix package.
      "clang-format" # For formatting .proto files in Visual Studio Code
      "hashicorp/tap/tfstacks" # No Nix package.
      "jmalloc/grit/grit" # No Nix package.
      "kcl-lang/tap/kcl-lsp" # No Nix package.
      "vsce" # No Nix package.
    ];

    casks = [
      "autodesk-fusion" # No nix package.
      "betterdisplay" # No nix package (macOS specific).
      "coscreen" # No Nix package.
      "docker-desktop" # Docker Desktop
      "font-monaspace"
      "ghostty" # Nix package is marked as broken on Darwin
      "inkscape" # Nix package crashes.
      "live-home-3d" # No Nix package.
      "slack" # Nix package didn't allow loading slack:// links from Safari
      "steam"
    ];

    masApps = {
      "magnet" = 441258766;
      "p-touch" = 1453365242;
      "parcel" = 639968404;
      "xcode" = 497799835;
    };
  };
}
