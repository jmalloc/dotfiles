{ pkgs, ... }:
{
  home = {
    packages = [ pkgs.awscli2 ];

    file.aws = {
      enable = true;
      source = ./aws-config;
      target = ".aws/config";
      force = true;
    };
  };
}
