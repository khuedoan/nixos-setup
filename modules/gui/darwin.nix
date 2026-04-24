{ config, ... }:

{
  homebrew.casks = [
    "brave-browser"
    "handy"
    "helium-browser"
    "kitty"
    "linearmouse"
    "obsidian"
    "secretive"
    "utm"
  ];

  system.defaults = {
    dock = {
      autohide = true;
      expose-group-apps = true;
      minimize-to-application = true;
      mru-spaces = false;
      showhidden = true;
    };
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleKeyboardUIMode = 3;
      ApplePressAndHoldEnabled = false;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
    };
    CustomUserPreferences = {
      "com.apple.Safari" = {
        AlwaysRestoreSessionAtLaunch = true;
        AutoOpenSafeDownloads = false;
        EnableNarrowTabs = false;
        IncludeDevelopMenu = true;
        NeverUseBackgroundColorInToolbar = true;
        ShowFullURLInSmartSearchField = true;
        ShowOverlayStatusBar = true;
        ShowStandaloneTabBar = false;
      };
    };
  };

  home-manager.users.${config.primaryUser.username}.home.file = {
    ".config/karabiner/karabiner.json".source = ./files/karabiner.json;
    ".config/kitty/kitty.d/macos.conf".source = ./files/kitty.conf;
  };
}
