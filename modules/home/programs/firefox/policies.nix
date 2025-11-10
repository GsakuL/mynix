rec {
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

        "browser.startup.page" = lock 3; # tabs and windows from previous session
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

        "browser.urlbar.suggest.trending" = lock false;

        "browser.toolbars.bookmarks.visibility" = lock "always";

        "dom.private-attribution.submission.enabled" = lock false;

        "browser.translations.neverTranslateLanguages" = lock "de,en";

        "signon.rememberSignons" = lock false;
        "extensions.formautofill.addresses.enabled" = lock false;
        "extensions.formautofill.creditCards.enabled" = lock false;

        "browser.ml.chat.enabled" = lock false;
        "browser.ml.chat.menu" = lock false;
        "browser.ml.chat.page" = lock false;
        "browser.ml.chat.shortcuts" = lock false;
        "browser.ml.chat.sidebar" = lock false;
      };
    ExtensionSettings = import ./extensions.nix;
  };
  softLibrewolfSettings = {
    # "privacy.resistFingerprinting.letterboxing" = true;

    "webgl.disabled" = false;

    "privacy.clearOnShutdown.history" = false;
    "privacy.clearOnShutdown.downloads" = false;

    "middlemouse.paste" = false;
    "general.autoScroll" = true;
  };
  defaultSettings = softLibrewolfSettings // {
    "pocket.enabled" = false;

    "toolkit.telemetry.enabled" = false;
    "toolkit.telemetry.unified" = false;
    "toolkit.telemetry.server" = "data:=";
    "toolkit.telemetry.archive.enabled" = false;
    "toolkit.telemetry.reportingpolicy.firstRun" = false;

    "font.name.serif.x-western" = "sans-serif";
    "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsored" = false;
    "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
    "urlclassifier.trackingSkipURLs" =
      "*.reddit.com, *.twitter.com, *.x.com, *.twimg.com, *.tiktok.com";
    "urlclassifier.features.socialtracking.skipURLs" =
      "*.instagram.com, *.twitter.com, *.x.com, *.twimg.com";

    "privacy.trackingprotection.socialtracking.enabled" = true;

    "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
    "browser.theme.content-theme" = 0;
    "browser.theme.toolbar-theme" = 0;
    "browser.tabs.tabMinWidth" = 100; # "fix" sound-playing width change

    "identity.fxaccounts.enabled" = false;
    "privacy.clearOnShutdown.cookies" = true;
    "dom.security.https_only_mode" = true;

    #"toolkit.legacyUserProfileCustomizations.stylesheets" = true;
  };
}
