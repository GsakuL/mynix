{
  lib,
  pkgs,
  pkgs-alt,
  ...
}:

{
  home.packages = with pkgs; [ nixd ];
  programs.vscode = {
    package = pkgs-alt.unstable-future.vscode;
    enable = true;
    mutableExtensionsDir = false;
    profiles.default.extensions =
      let
        n = pkgs-alt.unstable-future.vscode-extensions;
        p = m;
        m = pkgs-alt.unstable-future.vscode-marketplace;
      in
      lib.lists.flatten [
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

        # c/c++
        [
          m.raspberry-pi.raspberry-pi-pico
          [
            [
              p.ms-vscode.cpptools-extension-pack
              [
                n.ms-vscode.cpptools # https://github.com/nix-community/nix-vscode-extensions/issues/69
                m.ms-vscode.cpptools-themes
                [
                  p.ms-vscode.cmake-tools
                  [ p.twxs.cmake ]
                ]
              ]
            ]
            [
              m.marus25.cortex-debug
              [
                m.mcu-debug.debug-tracker-vscode
                m.mcu-debug.memory-view
                m.mcu-debug.rtos-views
                m.mcu-debug.peripheral-viewer
              ]
            ]
            m.ms-vscode.vscode-serial-monitor
          ]
        ]
      ];
  };
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
