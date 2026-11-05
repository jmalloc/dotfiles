{ lib, pkgs, ... }:
let
  # The global APM manifest. "apm install -g" installs these packages and
  # deploys them to each agent's user-level directory, such as ~/.claude/skills.
  # Projects install their own packages into their own directories, and agents
  # read both.
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

  # Installed by Homebrew, see darwin/brew.nix.
  apm = "/opt/homebrew/bin/apm";
in
{
  home.file.".apm/apm.yml".source = (pkgs.formats.yaml { }).generate "apm.yml" manifest;

  # Install the packages listed in the manifest. A failure, such as being
  # offline, doesn't stop the rest of the activation.
  home.activation.apmInstall = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    if [ -x ${apm} ]; then
      run ${apm} install -g || warnEcho "apm install -g failed, run it manually"
    else
      warnEcho "apm is not installed, skipping apm install -g"
    fi
  '';
}
