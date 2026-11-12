{ lib, ... }:
let
  dir = "$HOME/.claude/rules";
in
{
  # My personal rules for Claude Code. It loads every rule in ~/.claude/rules
  # at the start of each session, in every project, alongside the project's
  # own instructions. See https://code.claude.com/docs/en/memory.md
  #
  # Check a change to the rule against ../docs/reviewing-personal-rule.md.
  #
  # The rule is copied, not linked with home.file, because the documentation
  # doesn't say whether symlinks are followed in the user-level directory. The
  # copy is read-only, so that edits are made here and not to the copy.
  #
  # The directory itself stays writable, because "apm install -g" deploys the
  # instructions from global APM packages (see ./apm.nix) to the same place.
  home.activation.claudeRules = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run mkdir -p "${dir}"
    run install -m 0444 ${./claude/rules/personal.md} "${dir}/personal.md"
  '';
}
