{ ... }:
let
  agent = "Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
in
{
  home = {
    sessionVariables = {
      SSH_AUTH_SOCK = "$HOME/${agent}";
    };
  };

  programs.ssh = {
    enable = true;

    # Note that this configuration is placed into a "Host *" block, not at the
    # "root" of the ssh config file.
    extraConfig = ''
      IdentityAgent "~/${agent}"
    '';
  };
}
