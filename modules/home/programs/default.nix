{ pkgs, ... }:

{
  imports = [
    ./firefox
    ./games.nix
    ./git.nix
    ./vscode.nix
    ./zsh
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

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    thunderbird
    signal-desktop
    telegram-desktop
    discord
    keepassxc
    ungoogled-chromium

    xwaylandvideobridge
    btop
    neofetch
    powershell

    krita
    libreoffice
    hunspell
    hunspellDicts.de_DE
    hunspellDicts.en_US
    hunspellDicts.en_GB-ise

    p7zip
    pxz

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
