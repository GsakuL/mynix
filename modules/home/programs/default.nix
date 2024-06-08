{ pkgs, ... }:

{
  imports = [
    ./firefox
    ./games.nix
    ./git.nix
    ./vscode.nix
    ./shells/zsh
    ./work.nix
  ];

  programs.tmux = {
    enable = true;
    clock24 = true;
    mouse = true;
  };

  programs.fzf = {
    enable = true;
  };

  home.file."icons/material" = {
    source = pkgs.fetchFromGitHub {
      owner = "google";
      repo = "material-design-icons";
      rev = "4.0.0";
      sha256 = "0c8ah9rj82a1y0jgi5j0hszn7ndv4jb5kxmikv71alqq69xd8zn1";
    };
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    thunderbird
    signal-desktop
    telegram-desktop
    discord
    keepassxc
    ungoogled-chromium

    vlc

    xwaylandvideobridge
    btop
    neofetch
    powershell

    kate
    krita
    libreoffice
    hunspell
    hunspellDicts.de_DE
    hunspellDicts.en_US
    hunspellDicts.en_GB-ise

    p7zip
    pxz
    file
    tree
    bat

    plasma-applet-caffeine-plus
    caffeine-ng

    nixfmt-rfc-style

    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];
}
