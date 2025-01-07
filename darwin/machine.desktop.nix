{
  power = {
    restartAfterPowerFailure = true;
    restartAfterFreeze = true;

    sleep = {
      computer = "never";
      display = "never";
    };
  };

  system.defaults = {
    CustomUserPreferences = {
      "~/Library/Preferences/ByHost/com.apple.controlcenter" = {
        "WiFi" = 24; # 24 == hide (of course!)
      };
    };
  };
}
