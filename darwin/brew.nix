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
      "twilio/brew"
    ];

    brews = [
      "adr-tools" # No Nix package. TODO: Try "adrs" Nix package.
      "awscli" # Nix package is an older version.
      "clang-format" # For formatting .proto files in Visual Studio Code
      "hashicorp/tap/tfstacks" # No Nix package.
      "jmalloc/grit/grit" # No Nix package.
      "kcl-lang/tap/kcl-lsp" # No Nix package.
      "mise" # Nix package is much older.
      "skills" # No Nix package.
      "twilio/brew/twilio" # CLI, no Nix package.
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
      "voiceink"
    ];

    masApps = {
      "p-touch" = 1453365242;
      "magnet" = 441258766;
      "parcel" = 639968404;
      "xcode" = 497799835;
    };
  };
}
