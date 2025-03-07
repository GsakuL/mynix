{
  inputs,
  pkgs-alt,
  lib,
  ...
}:
let
  pkgs = pkgs-alt.unstable-future;
  policies = builtins.import ./policies.nix;
  myBookmarks = builtins.import ./bookmarks.nix;
  ffa = inputs.firefox-addons.packages.${pkgs.system};
  userChrome = builtins.import ./userChrome { inherit lib; };
in
{
  # https://gitlab.com/rycee/nur-expressions/blob/master/pkgs/firefox-addons/generated-firefox-addons.nix
  programs.librewolf = {
    package = pkgs.wrapFirefox (pkgs.librewolf-unwrapped.override { pipewireSupport = true; }) { };
    enable = true;
    nativeMessagingHosts = [ pkgs.ff2mpv-rust ];
    policies = policies.defaultPolicies;
    settings = policies.softLibrewolfSettings;
    profiles = {
      default = {
        name = "default";
        id = 0;
        isDefault = true;
        settings = policies.defaultSettings;
        bookmarks = myBookmarks;
        extensions = {
          packages = with ffa; [
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
            ff2mpv
          ];
        };
        userChrome = userChrome.default;
      };
      work = {
        name = "Arbeit";
        id = 1;
        settings = policies.defaultSettings // {
          "extensions.activeThemeID" = "firefox-compact-light@mozilla.org";
          "browser.theme.content-theme" = 1;
          "browser.theme.toolbar-theme" = 1;
        };
        # extensions = with ffa; [ violentmonkey ];
      };
    };
  };
}
