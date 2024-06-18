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
    Preferences =
      let
        lock = v: {
          Value = v;
          Status = "locked";
        };
        default = v: {
          Value = v;
          # Read/Write: Settings appear as default even if factory default differs.
          Status = "default";
        };
      in
      {
        "browser.aboutConfig.showWarning" = lock false;
        "browser.uidensity" = lock 1;
        "widget.gtk.non-native-titlebar-buttons.enabled" = lock false;
        "widget.gtk.overlay-scrollbars.enabled" = lock false;
        "widget.non-native-theme.gtk.scrollbar.thumb-size" = lock 1;
        "widget.non-native-theme.scrollbar.size.override" = lock 12;

        # might show checkbox, but can't save changes, still locked
        "browser.tabs.warnOnClose" = lock true;
        "browser.tabs.warnOnCloseOtherTabs" = lock true;
        "browser.sessionstore.warnOnQuit" = lock true;
        "browser.warnOnQuit" = lock true;
        "browser.warnOnQuitShortcut" = lock true;

        "browser.fixup.alternate.enabled" = lock false; # Don't try to guess domain names when entering an invalid domain name in URL bar
        "layout.testing.overlay-scrollbars.always-visible" = lock true;

        "browser.startup.page" = lock 3; # tabs and windows from previus session
        "media.autoplay.enabled" = default false;
        "media.eme.enabled" = default true;
        "media.autoplay.default" = default 5; # block audio and video by default

        "browser.pocket.enabled" = lock false;
        "extensions.pocket.enabled" = lock false;
        "browser.download.useDownloadDir" = lock false; # always ask
        "browser.download.always_ask_before_handling_new_types" = lock true;
        "browser.newtabpage.activity-stream.showSponsored" = lock false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock false;
        "browser.newtabpage.activity-stream.system.showSponsored" = lock false;
        "browser.newtabpage.activity-stream.default.sites" = default "";
        "browser.newtabpage.activity-stream.feeds.telemetry" = lock false;
        "browser.newtabpage.activity-stream.feeds.system.topstories" = lock false;
      };
  };
  defaultSettings = {
    "pocket.enabled" = false;

    "toolkit.telemetry.enabled" = false;
    "toolkit.telemetry.unified" = false;
    "toolkit.telemetry.server" = "data:=";
    "toolkit.telemetry.archive.enabled" = false;
    "toolkit.telemetry.reportingpolicy.firstRun" = false;

    "font.name.serif.x-western" = "sans-serif";
    "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsored" = false;
    "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
    "urlclassifier.trackingSkipURLs" = "*.reddit.com, *.twitter.com, *.x.com, *.twimg.com, *.tiktok.com";
    "urlclassifier.features.socialtracking.skipURLs" = "*.instagram.com, *.twitter.com, *.x.com, *.twimg.com";

    "privacy.trackingprotection.socialtracking.enabled" = true;
  };
}
