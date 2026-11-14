{ ... }:
let
  entries = builtins.readDir ./claude;
  directories = builtins.filter (name: entries.${name} == "directory") (builtins.attrNames entries);
in
{
  # My personal configuration for Claude Code. Every directory under ./claude
  # has its files linked to the same path under ~/.claude.
  #
  # Skills are managed by apm, not nix. See ./claude/.gitignore.
  home.file = builtins.listToAttrs (
    map (name: {
      name = ".claude/${name}";
      value = {
        source = ./claude + "/${name}";
        recursive = true;
      };
    }) directories
  );
}
