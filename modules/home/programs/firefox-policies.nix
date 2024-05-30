let
  val = v: { Value = v; };
  valLock = v: {
    Value = v;
    Status = "locked";
  };
  valDefault = v: {
    Value = v;
    # Read/Write: Settings appear as default even if factory default differs.
    Status = "default";
  };

  lock-false = valLock false;
  lock-true = valLock true;
in
{
  # https://mozilla.github.io/policy-templates/
  defaultPolicies = {
    RequestedLocales = [
      "de"
      "en-US"
    ];
    PasswordManagerEnabled = false;
    DisableTelemetry = true;
    DisableFirefoxStudies = true;
    EnableTrackingProtection = {
      Value = true;
      Locked = true;
      Cryptomining = true;
      Fingerprinting = true;
      EmailTracking = true;
    };
    DisablePocket = true;
    Preferences = {
      "browser.uidensity" = valLock 1;
      "widget.gtk.non-native-titlebar-buttons.enabled" = lock-false;
      "browser.tabs.warnOnClose" = lock-true;
      "browser.tabs.warnOnCloseOtherTabs" = lock-true;
      "browser.startup.page" = valLock 3; # tabs and windows from previus session
      "media.autoplay.enabled" = valDefault false;
      "media.eme.enabled" = valDefault true;

      "extensions.pocket.enabled" = lock-false;
      "browser.download.useDownloadDir" = lock-false; # always ask
      "browser.download.always_ask_before_handling_new_types" = valDefault true;
      "browser.newtabpage.activity-stream.showSponsored" = lock-false;
      "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
      "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
    };
  };
  defaultSettings = {
    "font.name.serif.x-western" = "sans-serif";
    "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsored" = false;
    "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
    "urlclassifier.trackingSkipURLs" = "*.reddit.com, *.twitter.com, *.x.com, *.twimg.com, *.tiktok.com";
    "urlclassifier.features.socialtracking.skipURLs" = "*.instagram.com, *.twitter.com, *.x.com, *.twimg.com";
  };
}
