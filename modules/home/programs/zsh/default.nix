{
  config,
  pkgs,
  lib,
  ...
}:
let
  zshDotDir = ".config/zsh";
in
{
  programs.zsh = {
    enable = true;
    dotDir = zshDotDir;
    history = {
      size = 50000;
      path = "${config.xdg.dataHome}/zsh/history";
      share = true;
      ignoreAllDups = true;
      ignoreSpace = true;
    };

    shellAliases = {
      ll = "ls -l";
      ls = "ls --color=auto --hyperlink=auto";
      grep = "grep --color=auto";
    };

    initExtra = ''
      source $HOME/${zshDotDir}/plugins/my-stuff/my-stuff.zsh
    '';

    plugins = [
      {
        name = "my-stuff";
        src = ./my-stuff;
        file = "my-stuff.zsh";
      }
    ];

    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
      ];
    };
  };

  programs.oh-my-posh = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ../shells/ohmyposh/config.toml);
  };
}
