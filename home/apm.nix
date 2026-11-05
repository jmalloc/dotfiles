{ pkgs, ... }:
let
  # The global APM manifest. "apm install -g" installs these packages and
  # deploys them to each agent's user-level directory, such as ~/.claude/skills.
  # Projects install their own packages into their own directories, and agents
  # read both.
  #
  # "make switch" runs "apm install -g" after switching. It isn't run during
  # activation, because fetching packages relies on the user's own environment,
  # such as git, SSH and the keychain.
  manifest = {
    name = "global";
    version = "0.0.0";
    targets = [ "claude" ];
    dependencies.apm = [
      # Third-party skills are pinned to a commit, because skills run inside the
      # agent's context. Update the commit deliberately, after reviewing the
      # changes.
      "mattpocock/skills/skills/productivity/grill-me#4ae2317ddb22b046e26455e4f9c9b3aaaf62212d"
    ];
  };
in
{
  home.file.".apm/apm.yml".source = (pkgs.formats.yaml { }).generate "apm.yml" manifest;
}
