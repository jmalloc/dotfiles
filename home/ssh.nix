{ ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "*" = {
        addKeysToAgent = "yes";
        identityFile = "~/Library/Mobile\\ Documents/com~apple~CloudDocs/dotfiles/ssh/id_ed25519";
      };
    };

    extraConfig = ''
      UseKeychain yes
    '';
  };
}
