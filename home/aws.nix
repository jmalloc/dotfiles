{ config, lib, ... }:
let
  # Each SSO session is one IAM Identity Center instance. Signing in to a
  # session once covers every profile that uses it.
  ssoSessions = {
    dialer-legacy = {
      sso_start_url = "https://dialer-io-legacy.awsapps.com/start";
      sso_region = "us-west-2";
      sso_registration_scopes = "sso:account:access";
    };
    dialer = {
      sso_start_url = "https://dialer-io.awsapps.com/start";
      sso_region = "ap-southeast-2";
      sso_registration_scopes = "sso:account:access";
    };
  };

  # The SSO profiles, one per account and role.
  #
  # Profiles are named after the account, so they're easy to type and to ask
  # for. The "mcp" flag controls whether the AWS MCP agent can use the profile,
  # and is only enabled for readonly roles. Profiles for roles that can make
  # changes are suffixed with the role name.
  ssoProfiles = {
    dialer-legacy = {
      session = "dialer-legacy";
      accountId = "381491966138";
      role = "read-only";
      region = "us-west-2";
      mcp = true;
    };
    dialer-legacy-admin = {
      session = "dialer-legacy";
      accountId = "381491966138";
      role = "admin";
      region = "us-west-2";
      mcp = false;
    };
    dialer-dns = {
      session = "dialer";
      accountId = "431092647609";
      role = "read-only";
      region = "us-west-2";
      mcp = true;
    };
    dialer-dns-break-glass = {
      session = "dialer";
      accountId = "431092647609";
      role = "break-glass";
      region = "us-west-2";
      mcp = false;
    };
    dialer-management = {
      session = "dialer";
      accountId = "013081881709";
      role = "read-only";
      region = "us-west-2";
      mcp = true;
    };
    dialer-management-break-glass = {
      session = "dialer";
      accountId = "013081881709";
      role = "break-glass";
      region = "us-west-2";
      mcp = false;
    };
  };

  profileSections = lib.mapAttrs' (
    name: p:
    lib.nameValuePair "profile ${name}" {
      sso_session = p.session;
      sso_account_id = p.accountId;
      sso_role_name = p.role;
      region = p.region;
    }
  ) ssoProfiles;

  sessionSections = lib.mapAttrs' (name: s: lib.nameValuePair "sso-session ${name}" s) ssoSessions;

  configFile = lib.generators.toINI { } (
    {
      # There's deliberately no default role, so a bare "aws" command can't act
      # with any account's permissions.
      default.region = "ap-southeast-2";
    }
    // profileSections
    // sessionSections
  );
in
{
  options.dotfiles.aws.mcpProfiles = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    readOnly = true;
    description = ''
      The AWS profiles that the AWS MCP server's agent can choose between. The
      proxy only reads profiles at startup, and the first is its default.
    '';
  };

  config = {
    # The agent can only act in the profiles listed here, so every profile in
    # this list is one the agent can use, including any that can make changes.
    dotfiles.aws.mcpProfiles = lib.attrNames (lib.filterAttrs (_: p: p.mcp) ssoProfiles);

    home.file.aws = {
      enable = true;
      text = configFile;
      target = ".aws/config";
      force = true;
    };
  };
}
