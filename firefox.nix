{ config, pkgs, ... }:
let
  val = v: { Value = v; };
  valLock = v: {
    Value = v;
    Status = "locked";
  };

  lock-false = valLock false;
  lock-true = valLock true;

  defaultSettings = {
    "browser.uidensity" = valLock 1;
    "extensions.pocket.enabled" = lock-false;
    "browser.newtabpage.activity-stream.showSponsored" = lock-false;
    "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
    "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
    "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsored" = lock-false;
    "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
  };
in
{
  programs.firefox = {
    enable = true;
    profiles = {
      "default" = {
        name = "default";
        id = 1;
        isDefault = true;
        settings = defaultSettings;
      };
      "Arbeit" = {
        name = "Arbeit";
        id = 2;
        isDefault = false;
        settings = defaultSettings;
      };
    };
  };
}
