{
  enable = true;

  onActivation.cleanup = "zap";
  onActivation.autoUpdate = true;
  onActivation.upgrade = true;

  taps = [
    "datawire/blackbird"
    "jmalloc/grit"
  ];

  brews = [
    "adr-tools"
    "clang-format" # needed for VSCode protobuf extension to support formatting
    "datawire/blackbird/telepresence-arm64"
    "jmalloc/grit/grit"
  ];

  casks = [
    "1password-cli"
    "1password"
    "around"
    "betterdisplay"
    "docker" # Docker Desktop
    "slack"
  ];

  masApps = {
    "magnet" = 441258766;
    "parcel" = 639968404;
  };
}
