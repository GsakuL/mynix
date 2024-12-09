{ inputs, pkgs-alt, ... }:
let
  pkgs = pkgs-alt.unstable-future;
  policies = builtins.import ./policies.nix;
  myBookmarks = builtins.import ./bookmarks.nix;
  ffa = inputs.firefox-addons.packages.${pkgs.system};
in
{
  # https://gitlab.com/rycee/nur-expressions/blob/master/pkgs/firefox-addons/generated-firefox-addons.nix
  programs.firefox = {
    package = pkgs.wrapFirefox (pkgs.firefox-unwrapped.override { pipewireSupport = true; }) { };
    enable = true;
    policies = policies.defaultPolicies;
    profiles = {
      default = {
        name = "default";
        id = 0;
        isDefault = true;
        settings = policies.defaultSettings;
        bookmarks = myBookmarks;
        extensions = with ffa; [
          dictionary-german

          canvasblocker
          ublock-origin
          sponsorblock
          darkreader
          keepassxc-browser
          sponsorblock
          auto-tab-discard
          return-youtube-dislikes
          stylus
          noscript
          violentmonkey
          indie-wiki-buddy
          redirector
        ];
      };
      work = {
        name = "Arbeit";
        id = 1;
        settings = policies.defaultSettings // {
          "extensions.activeThemeID" = "firefox-compact-light@mozilla.org";
          "browser.theme.content-theme" = 1;
          "browser.theme.toolbar-theme" = 1;
        };
        extensions = with ffa; [ violentmonkey ];
      };
    };
  };
}
