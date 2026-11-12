{ lib, pkgs, ... }:
let
  # Claude Code's managed settings. They take precedence over the user's own
  # settings in ~/.claude/settings.json, and Claude Code never writes to them,
  # so they suit settings that Nix owns. The terminal CLI and the VS Code
  # extension both read them. See https://code.claude.com/docs/en/settings.md
  #
  # The model is a starting default that /model can still change for the user.
  settings = {
    env = {
      CLAUDE_CODE_DISABLE_FEEDBACK_SURVEY = "1";
    };

    model = "opus";

    enabledPlugins = {
      "gopls-lsp@claude-plugins-official" = true;
    };

    # GitHub MCP tools that must never be used. The server's X-MCP-Tools header
    # (see home/apm.nix) doesn't enable them either; this is a second layer.
    permissions.deny = [
      "mcp__github__assign_copilot_to_issue"
      "mcp__github__create_branch"
      "mcp__github__create_or_update_file"
      "mcp__github__create_pull_request_with_copilot"
      "mcp__github__create_repository"
      "mcp__github__delete_file"
      "mcp__github__delete_repository"
      "mcp__github__fork_repository"
      "mcp__github__merge_pull_request"
      "mcp__github__push_files"
      "mcp__github__update_pull_request_branch"
    ];
  };

  settingsFile = (pkgs.formats.json { }).generate "managed-settings.json" settings;
  dir = "/Library/Application Support/ClaudeCode";
in
{
  # Copy rather than link the file, because Claude Code warns about managed
  # settings that are symlinks to a location outside this directory.
  system.activationScripts.extraActivation.text = lib.mkAfter ''
    install -d -m 0755 "${dir}"
    install -m 0644 ${settingsFile} "${dir}/managed-settings.json"
  '';
}
