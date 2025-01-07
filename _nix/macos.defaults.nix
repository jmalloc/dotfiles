{
  NSGlobalDomain = {
    AppleKeyboardUIMode = 3;
    "com.apple.keyboard.fnState" = true;

    ApplePressAndHoldEnabled = false;
    InitialKeyRepeat = 15;
    KeyRepeat = 2;

    NSAutomaticCapitalizationEnabled = false;
    NSAutomaticDashSubstitutionEnabled = false;
    NSAutomaticPeriodSubstitutionEnabled = false;
    NSAutomaticQuoteSubstitutionEnabled = false;
    NSAutomaticSpellingCorrectionEnabled = false;

    "com.apple.mouse.tapBehavior" = 1;
    "com.apple.sound.beep.feedback" = 1; # beep when adjusting volume
  };

  controlcenter = {
    Sound = true; # show sound icon on menubar
  };

  screensaver = {
    askForPassword = true;
    askForPasswordDelay = 0;
  };

  dock = {
    static-only = true;
    persistent-apps = [ ];
    autohide = true;
    autohide-delay = 1000.0; # "disable" the dock
  };

  finder = {
    FXRemoveOldTrashItems = true;
  };

  screencapture = {
    location = "/tmp";
    type = "png";
    show-thumbnail = false;
  };

  CustomUserPreferences = {
    NSGlobalDomain = {
      "com.apple.sound.uiaudio.enabled" = 0; # disable UI sound effects
    };

    "com.apple.dock" = {
      wvous-tr-corner = 5; # top-right hot-corner = screensaver
      wvous-tr-modifier = 1048576; # command key
    };
  };
}
