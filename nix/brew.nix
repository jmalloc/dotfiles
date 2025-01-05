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
    "datawire/blackbird/telepresence-arm64"
    "jmalloc/grit/grit"
  ];

  casks = [
    "1password"
    "1password-cli"
    "around"
    "betterdisplay"
    "slack"
  ];

  masApps = {
    "magnet" = 441258766;
    "parcel" = 639968404;
  };
}
