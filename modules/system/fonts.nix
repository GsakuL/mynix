{ pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "FiraMono"
        ];
      })
      fira-code
      fira-mono
      vollkorn
      ubuntu_font_family
      noto-fonts-monochrome-emoji
      twitter-color-emoji
      unicode-emoji
    ];
    fontconfig = {
      defaultFonts = {
        sansSerif = [
          "Vazirmatn"
          "Ubuntu"
        ];
        serif = [
          "Vollkorn"
          "Liberation Serif"
          "Vazirmatn"
        ];
        monospace = [
          "FiraCode Nerd Font"
          "FiraCode Nerd Font Mono"
          "Fira Code"
          "Fira Mono"
          "Ubuntu Mono"
        ];
        emoji = [
          "Twitter Color Emoji"
          "Noto Color Emoji"
          "Noto Emoji"
        ];
      };
    };
  };
}
