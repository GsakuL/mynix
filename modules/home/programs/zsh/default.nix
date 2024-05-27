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
      ls = "ls --color=auto";
      grep = "grep --color=auto";
    };

    initExtra = ''
      source $HOME/${zshDotDir}/plugins/powerlevel10k-config/.p10k.zsh
      source $HOME/${zshDotDir}/plugins/my-stuff/my-stuff.zsh
    '';

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./p10k;
        file = "p10k.zsh";
      }
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
        #        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } # Installations with additional options. For the list of options, please refer to Zplug README.
      ];
    };
  };
}
