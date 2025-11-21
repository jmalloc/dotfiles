{ pkgs, ... }:
{
  home = {
    packages = [ pkgs.go ];

    sessionPath = [
      "$(go env GOPATH)/bin"
    ];

    sessionVariables = {
      GOPRIVATE = "go.dialer.dev";
    };
  };
}
