{
  lib,
  pkgs,
  pkgs-alt,
  ...
}:

let
  inherit (pkgs-alt.unstable-future.nix4vscode)
    forVscode
    ;
in
{
  home.packages = with pkgs; [ nixd ];
  programs.vscode = {
    package = (
      pkgs-alt.unstable-future.vscode.override { commandLineArgs = "--password-store=basic"; }
    );
    enable = true;
    mutableExtensionsDir = false;
    profiles.default.extensions = forVscode (
      lib.lists.flatten [
        "ms-vscode-remote.remote-containers"

        # files / misc langs
        "tamasfe.even-better-toml"
        "jnoortheen.nix-ide"
        "janisdd.vscode-edit-csv"

        # web
        "ms-vscode.live-server"

        # utils
        "eamodio.gitlens"
        "mkhl.direnv"
        "medo64.render-crlf"

        # spelling
        [
          "streetsidesoftware.code-spell-checker"
          "streetsidesoftware.code-spell-checker-german"
        ]

        # python
        [
          "ms-python.python"
          [
            "ms-python.vscode-pylance"
            "ms-python.debugpy"
          ]
        ]
        "wholroyd.jinja"
      ]
    );
  };
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
