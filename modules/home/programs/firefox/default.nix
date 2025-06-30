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
  programs.firefox = {
    package = pkgs.wrapFirefox (pkgs.firefox-unwrapped.override { pipewireSupport = true; }) { };
    enable = true;
    nativeMessagingHosts = [ pkgs.ff2mpv-rust ];
    policies = policies.defaultPolicies;
    profiles = {
      myDefault = {
        name = "myDefault";
        id = 0;
        isDefault = true;
        settings = policies.defaultSettings;
        search = {
          default = "qwant";
          force = true;
          engines = {
            "qwant" = {
              urls = [
                {
                  template = myBookmarks.getQwantUrl "{searchTerms}";
                }
              ];
            };
            "bing".metaData.hidden = true;
            "google".metaData.hidden = true;
          };
        };
        bookmarks = {
          force = true;
          settings = myBookmarks.bookmarks;
        };
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
        # userChrome = userChrome.default;
      };
      playground = {
        name = "playground";
        id = 2;
      };
    };
  };
}
