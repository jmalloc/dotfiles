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

  # The global APM manifest. "apm install -g" installs these packages and
  # deploys them to each agent's user-level directory, such as ~/.claude/skills.
  # Projects install their own packages into their own directories, and agents
  # read both.
  #
  # "make install" runs "apm install -g" after switching. It isn't run during
  # activation, because fetching packages relies on the user's own environment,
  # such as git, SSH and the keychain.
  manifest = {
    name = "global";
    version = "0.0.0";
    targets = [ "claude" ];
    dependencies = {
      apm = [
        # Third-party skills are pinned to a commit, because skills run inside
        # the agent's context. Update the commit deliberately, after reviewing
        # the changes.
        "mattpocock/skills/skills/productivity/grill-me#5863806dd4e15c63174bee4e7515a4256792ecfa"
        "mattpocock/skills/skills/productivity/teach#5863806dd4e15c63174bee4e7515a4256792ecfa"
      ];

      # MCP servers. Credentials never appear here: each server's
      # headersHelper is a command that Claude Code runs to produce the
      # headers, reading the token from the relevant CLI's own credentials.
      mcp = [
        {
          name = "github";
          registry = false;
          transport = "http";
          url = "https://api.githubcopilot.com/mcp/";
          headersHelper = "printf '${
            builtins.toJSON {
              Authorization = "Bearer %s";
              X-MCP-Tools = lib.concatStringsSep "," githubTools;
            }
          }' \"$(gh auth token)\"";
        }
        {
          name = "terraform";
          registry = false;
          transport = "http";
          url = "https://mcp.terraform.io/mcp";
          headersHelper = ''jq -c "{Authorization: (\"Bearer \" + .credentials[\"app.terraform.io\"].token)}" ~/.terraform.d/credentials.tfrc.json'';
        }
        # Linear's hosted MCP server. It uses OAuth, so there's no token to
        # supply here: authorize it once with /mcp in Claude Code.
        {
          name = "linear";
          registry = false;
          transport = "http";
          url = "https://mcp.linear.app/mcp";
        }
        # The managed AWS MCP server, through AWS's local signing proxy. The
        # profiles come from home/aws.nix, and the agent picks one per call.
        # Sign in to each SSO session with "aws sso login" first.
        {
          name = "aws";
          registry = false;
          transport = "stdio";
          command = "uvx";
          args = [
            # Pinned, because the proxy signs requests with AWS credentials.
            # Update the version deliberately.
            "mcp-proxy-for-aws-cli==1.8.0"
            "https://aws-mcp.us-east-1.api.aws/mcp"
          ];
          env.AWS_MCP_PROXY_PROFILES = lib.concatStringsSep " " config.dotfiles.aws.mcpProfiles;
        }
      ];
    };
  };
in
{
  home.file.".apm/apm.yml".source = (pkgs.formats.yaml { }).generate "apm.yml" manifest;
}
