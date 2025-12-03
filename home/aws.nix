{ pkgs, ... }:
{
  home = {
    file.aws = {
      enable = true;
      source = ./aws-config;
      target = ".aws/config";
      force = true;
    };
  };
}
