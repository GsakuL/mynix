{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  from-marketplace = import ./extensions-from-marketplace.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; [ nixd ];
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    extensions =
      let
        p = pkgs.vscode-extensions;
        m = from-marketplace;
      in
      lib.lists.flatten [
        # files / misc langs
        p.tamasfe.even-better-toml
        p.jnoortheen.nix-ide
        m.janisdd__vscode-edit-csv

        # utils
        p.eamodio.gitlens
        p.mkhl.direnv
        m.medo64__render-crlf

        # spelling
        [
          p.streetsidesoftware.code-spell-checker
          m.streetsidesoftware__code-spell-checker-german
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
          m.raspberry-pi__raspberry-pi-pico
          [
            [
              p.ms-vscode.cpptools-extension-pack
              [
                p.ms-vscode.cpptools
                m.ms-vscode__cpptools-themes
                [
                p.ms-vscode.cmake-tools
                  [ p.twxs.cmake ]
                ]
              ]
            ]
            [
              m.marus25__cortex-debug
              [
                m.mcu-debug__debug-tracker-vscode
                m.mcu-debug__memory-view
                m.mcu-debug__rtos-views
                m.mcu-debug__peripheral-viewer
              ]
            ]
            m.ms-vscode__vscode-serial-monitor
          ]
        ]
      ];
  };
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
