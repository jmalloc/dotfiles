{ ... }:
{
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";

    # Note that this configuration is placed into a "Host *" block, not at the
    # "root" of the ssh config file.
    extraConfig = ''
      UseKeychain yes
      IdentityFile "~/Library/Mobile Documents/com~apple~CloudDocs/dotfiles/ssh/id_ed25519"
    '';
  };
}
