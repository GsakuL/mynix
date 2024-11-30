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

      vazir-fonts # Persian
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      gentium

      helvetica-neue-lt-std
    ];
    fontconfig = {
      defaultFonts = {
        sansSerif = [
          "Ubuntu"

          "Noto Sans CJK JP"
          "Vazirmatn"
          "Gentium Plus"
        ];
        serif = [
          "Vollkorn"
          "Liberation Serif"

          "Noto Serif CJK JP"
          "Vazirmatn"
          "Gentium Plus"
        ];
        monospace = [
          "FiraCode Nerd Font"
          "FiraCode Nerd Font Mono"
          "Fira Code"
          "Fira Mono"
          "Ubuntu Mono"
          "Noto Sans Mono CJK JP"
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
