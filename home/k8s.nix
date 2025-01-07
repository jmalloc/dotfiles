{ pkgs, ... }: {
  home = {
    packages = [
      pkgs.kubectl
      pkgs.kubectx
      pkgs.kubernetes-helm
    ];

    shellAliases = {
      h = "helm";
      k = "kubectl";
    };
  };
}
