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

    localVariables = {
      PROMPT_EOL_MARK = "";
    };

    initContent = builtins.readFile ./initExtra.zsh;

    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
      ];
    };
  };

  programs.oh-my-posh = {
    enable = false;
    settings = builtins.fromTOML (builtins.readFile ../ohmyposh/config.toml);
  };
}
