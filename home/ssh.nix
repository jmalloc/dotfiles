{ ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings."*" = {
      AddKeysToAgent = "yes";
      IdentityFile = "~/Library/Mobile\\ Documents/com~apple~CloudDocs/dotfiles/ssh/id_ed25519";
      UseKeychain = "yes";
    };
  };
}
