{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    #./firefox.nix
    ./zsh.nix
    ./git.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "lukas";
  home.homeDirectory = "/home/lukas";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    thunderbird
    signal-desktop
    telegram-desktop
    discord
    wootility
    keepassxc
    ungoogled-chromium

    xwaylandvideobridge
    amdgpu_top
    btop
    neofetch
    powershell

    krita
    libreoffice
    hunspell
    hunspellDicts.de_DE
    hunspellDicts.en_US
    hunspellDicts.en_GB-ise

    teams-for-linux

    p7zip
    pxz

    plasma-applet-caffeine-plus
    caffeine-ng

    nixfmt-rfc-style

    bottles
    lutris

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

  xsession.numlock.enable = true;

  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    mouse = true;
  };

  home.activation = {
    fixCitrix = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      [ -f "$HOME/.ICAClient/wfclient.ini" ] && run sed -i -E 's/^MouseSendsControlV=(True|\*)?$/MouseSendsControlV=False/' "$HOME/.ICAClient/wfclient.ini"
    '';
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/lukas/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # MANGOHUD = "1";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
