{ pkgs, ... }:
{
  homebrew = {
    enable = true;

    onActivation.cleanup = "zap";
    # autoUpdate is disabled due to a bug in nix-homebrew's brew wrapper that
    # breaks PATH handling after Homebrew's auto-update re-exec.
    # See: https://github.com/zhaofengli/nix-homebrew/issues/131
    onActivation.autoUpdate = false;
    onActivation.upgrade = true;

    taps = [
      {
        name = "hashicorp/tap";
        trusted = true;
      }
      {
        name = "jmalloc/grit";
        trusted = true;
      }
      {
        name = "kcl-lang/tap";
        trusted = true;
      }
      {
        name = "twilio/brew";
        trusted = true;
      }
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
      "docker-desktop" # Docker Desktop
      "font-monaspace"
      "ghostty" # Nix package is marked as broken on Darwin
      "live-home-3d" # No Nix package.
      "slack" # Nix package didn't allow loading slack:// links from Safari
      "steam"
    ];

  };
}
