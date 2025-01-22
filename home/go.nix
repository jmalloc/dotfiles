{ pkgs, ... }:
{
  home = {
    packages = [ pkgs.go ];

    sessionVariables = {
      GOPRIVATE = "github.com/betsecure/*";
    };

    sessionPath = [
      "$(go env GOPATH)/bin"
    ];
  };
}
