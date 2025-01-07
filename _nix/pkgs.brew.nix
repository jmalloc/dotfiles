{
  enable = true;

  onActivation.cleanup = "zap";
  onActivation.autoUpdate = true;
  onActivation.upgrade = true;

  taps = [
    "betsecure/tap"
    "datawire/blackbird"
    "jmalloc/grit"
  ];

  brews = [
    "adr-tools"
    "betsecure/tap/bescuttle"
    "clang-format" # For formatting .proto files in Visual Studio Code
    "datawire/blackbird/telepresence-arm64"
    "jmalloc/grit/grit"
  ];

  casks = [
    "1password-cli"
    "1password"
    "around"
    "autodesk-fusion"
    "betterdisplay"
    "docker" # Docker Desktop
    "ghostty" # Nix package is marked as broken on Darwin
    "slack" # Nix package didn't allow loading slack:// links from Safari
  ];

  masApps = {
    "magnet" = 441258766;
    "p-touch" = 1453365242;
    "parcel" = 639968404;
  };
}
