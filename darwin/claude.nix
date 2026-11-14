{
  config,
  lib,
  pkgs,
  ...
}:
let
  # The GitHub MCP server's tools that are enabled. Tools that modify anything
  # are listed separately.
  githubTools = [
    "get_commit"
    "get_copilot_job_status"
    "get_file_contents"
    "get_label"
    "get_latest_release"
    "get_me"
    "get_release_by_tag"
    "get_tag"
    "get_team_members"
    "get_teams"
    "issue_read"
    "list_branches"
    "list_commits"
    "list_issue_fields"
    "list_issue_types"
    "list_issues"
    "list_pull_requests"
    "list_releases"
    "list_repository_collaborators"
    "list_tags"
    "pull_request_read"
    "run_secret_scanning"
    "search_code"
    "search_commits"
    "search_issues"
    "search_pull_requests"
    "search_repositories"
    "search_users"
    "ui_get"
  ]
  ++ [
    "add_comment_to_pending_review"
    "add_issue_comment"
    "add_reply_to_pull_request_comment"
    "create_pull_request"
    "issue_write"
    "pull_request_review_write"
    "request_copilot_review"
    "sub_issue_write"
    "update_issue_comment"
    "update_pull_request"
  ];

  # Claude Code's managed MCP servers. According to the documentation, while
  # this file exists Claude Code loads MCP servers only from it, apart from the
  # servers that Claude Code's own apps build in. So "claude mcp add" fails,
  # plugin servers and the claude.ai connectors don't load, and a server
  # changes only by changing this file.
  # See https://code.claude.com/docs/en/managed-mcp.md
  #
  # Credentials never appear here: each server's headersHelper is a command
  # that Claude Code runs to produce the headers, reading the token from the
  # relevant CLI's own credentials.
  mcpServers = {
    github = {
      type = "http";
      url = "https://api.githubcopilot.com/mcp/";
      headers.X-MCP-Tools = lib.concatStringsSep "," githubTools;
      headersHelper = ''printf '{"Authorization":"Bearer %s"}' "$(gh auth token)"'';
    };

    terraform = {
      type = "http";
      url = "https://mcp.terraform.io/mcp";
      headersHelper = ''jq -c "{Authorization: (\"Bearer \" + .credentials[\"app.terraform.io\"].token)}" ~/.terraform.d/credentials.tfrc.json'';
    };

    # Linear's hosted MCP server. It uses OAuth, so there's no token to
    # supply here: authorize it once with /mcp in Claude Code.
    linear = {
      type = "http";
      url = "https://mcp.linear.app/mcp";
    };

    # The managed AWS MCP server, through AWS's local signing proxy. The
    # profiles come from home/aws.nix, and the agent picks one per call. Sign
    # in to each SSO session with "aws sso login" first.
    aws = {
      type = "stdio";
      command = "uvx";
      args = [
        # Pinned, because the proxy signs requests with AWS credentials.
        # Update the version deliberately.
        "mcp-proxy-for-aws-cli==1.8.0"
        "https://aws-mcp.us-east-1.api.aws/mcp"
      ];
      env.AWS_MCP_PROXY_PROFILES = lib.concatStringsSep " " config.home-manager.users.${config.system.primaryUser}.dotfiles.aws.mcpProfiles;
    };
  };

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

    model = "sonnet";

    enabledPlugins = {
      "gopls-lsp@claude-plugins-official" = true;
    };

    # Sends a reply back to the agent when it mentions a file or an issue
    # without a link, which my personal rule asks for but agents often forget.
    # A Stop hook runs only in the main session, not in subagents.
    hooks.Stop = [
      {
        hooks = [
          {
            type = "command";
            command = "${pkgs.python3}/bin/python3 -I ${./claude/check-reply-links.py}";
          }
        ];
      }
    ];

    # GitHub MCP tools that must never be used. The GitHub server's
    # X-MCP-Tools header (see githubTools) doesn't enable them either; this is
    # a second layer.
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

  json = pkgs.formats.json { };
  settingsFile = json.generate "managed-settings.json" settings;
  mcpFile = json.generate "managed-mcp.json" { inherit mcpServers; };
  dir = "/Library/Application Support/ClaudeCode";
in
{
  # Copy rather than link the files, because Claude Code warns about managed
  # settings that are symlinks to a location outside this directory.
  system.activationScripts.extraActivation.text = lib.mkAfter ''
    install -d -m 0755 "${dir}"
    install -m 0644 ${settingsFile} "${dir}/managed-settings.json"
    install -m 0644 ${mcpFile} "${dir}/managed-mcp.json"
  '';
}
