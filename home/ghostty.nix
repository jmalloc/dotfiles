{ ... }:
{
  # Note: ghostty is installed via brew, because the Nix package is marked as
  # broken on Darwin.

  home = {
    file.ghostty = {
      enable = true;
      source = ./ghostty-config;
      target = ".config/ghostty";
      force = true;
    };
  };
}
