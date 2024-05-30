{
  inputs,
  config,
  pkgs,
  ...
}:
let
  policies = builtins.import ./firefox-policies.nix;
  myBookmarks = builtins.import ./firefox-bookmarks.nix;
in
{
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
        extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
          ublock-origin
          sponsorblock
          darkreader
          keepassxc-browser
          sponsorblock
          auto-tab-discard
          return-youtube-dislikes
        ];
      };
      work = {
        name = "Arbeit";
        id = 1;
        settings = policies.defaultSettings;
      };
    };
  };
}
