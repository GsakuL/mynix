{
  lib,
  pkgs,
  pkgs-alt,
  ...
}:

{
  home.packages = with pkgs; [ nixd ];
  programs.vscode = {
    package = (
      pkgs-alt.unstable-future.vscode.override { commandLineArgs = "--password-store=basic"; }
    );
    enable = true;
    mutableExtensionsDir = false;
    profiles.default.extensions =
      let
        p = m;
        m = pkgs-alt.unstable-future.vscode-marketplace;
      in
      lib.lists.flatten [
        m.ms-vscode-remote.remote-containers

        # files / misc langs
        p.tamasfe.even-better-toml
        p.jnoortheen.nix-ide
        m.janisdd.vscode-edit-csv

        # web
        p.ms-vscode.live-server

        # utils
        p.eamodio.gitlens
        p.mkhl.direnv
        m.medo64.render-crlf

        # spelling
        [
          p.streetsidesoftware.code-spell-checker
          m.streetsidesoftware.code-spell-checker-german
        ]

        # python
        [
          p.ms-python.python
          [
            p.ms-python.vscode-pylance
            p.ms-python.debugpy
          ]
        ]
        p.wholroyd.jinja
      ];
  };
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
