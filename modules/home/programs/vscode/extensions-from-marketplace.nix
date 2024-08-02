{ pkgs, ... }:
let
  extDefToAttrs =
    def:
    builtins.map (e: {
      name = "${e.publisher}__${e.name}";
      value = pkgs.vscode-utils.extensionFromVscodeMarketplace e;
    }) def;

  mkExtensionList = (defs: builtins.listToAttrs (extDefToAttrs defs));
in
/*
  {
    # https://marketplace.visualstudio.com/items?itemName=
    publisher = "";
    name = "";
    version = "";
    hash = "";
  }
*/
mkExtensionList [
  {
    # https://marketplace.visualstudio.com/items?itemName=sohamkamani.code-eol
    publisher = "sohamkamani";
    name = "code-eol";
    version = "0.3.3";
    hash = "sha256-XcDrzKQljET7X41Kc3ptQ2lNSD8whMvs70vwYTMpEwE=";
  }
  {
    # https://marketplace.visualstudio.com/items?itemName=medo64.render-crlf
    publisher = "medo64";
    name = "render-crlf";
    version = "1.8.1";
    hash = "sha256-XBSTDC7YmnDppOqtH1xdJigTzfS2G0fAv5nh8wkp8tg=";
  }
  {
    # https://marketplace.visualstudio.com/items?itemName=janisdd.vscode-edit-csv
    publisher = "janisdd";
    name = "vscode-edit-csv";
    version = "0.9.2";
    hash = "sha256-F/YEMrRlkLdIOATq+u6ovdZt21MgVbYH1PAnpyncFqs=";
  }
  {
    # https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker-german
    publisher = "streetsidesoftware";
    name = "code-spell-checker-german";
    version = "2.3.2";
    hash = "sha256-40Oc6ycNog9cxG4G5gCps2ADrM/wLuKWFrD4lnd91Z4=";
  }
  {
    # https://marketplace.visualstudio.com/items?itemName=raspberry-pi.raspberry-pi-pico
    publisher = "raspberry-pi";
    name = "raspberry-pi-pico";
    version = "0.14.0";
    hash = "sha256-GLNwCdrw70mRqswc8koqmt6fJwBYIdFXj8ICFbUr0cY=";
  }
  {
    # https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools-themes
    publisher = "ms-vscode";
    name = "cpptools-themes";
    version = "2.0.0";
    hash = "sha256-YWA5UsA+cgvI66uB9d9smwghmsqf3vZPFNpSCK+DJxc=";
  }
  {
    # https://marketplace.visualstudio.com/items?itemName=marus25.cortex-debug
    publisher = "marus25";
    name = "cortex-debug";
    version = "1.12.1";
    hash = "sha256-ioK6gwtkaAcfxn11lqpwhrpILSfft/byeEqoEtJIfM0=";
  }
  {
    # https://marketplace.visualstudio.com/items?itemName=mcu-debug.debug-tracker-vscode
    publisher = "mcu-debug";
    name = "debug-tracker-vscode";
    version = "0.0.15";
    hash = "sha256-2u4Moixrf94vDLBQzz57dToLbqzz7OenQL6G9BMCn3I=";
  }
  {
    # https://marketplace.visualstudio.com/items?itemName=mcu-debug.memory-view
    publisher = "mcu-debug";
    name = "memory-view";
    version = "0.0.25";
    hash = "sha256-Tck3MYKHJloiXChY/GbFvpBgLBzu6yFfcBd6VTpdDkc=";
  }
  {
    # https://marketplace.visualstudio.com/items?itemName=mcu-debug.rtos-views
    publisher = "mcu-debug";
    name = "rtos-views";
    version = "0.0.7";
    hash = "sha256-VvMAYU7KiFxwLopUrOjvhBmA3ZKz4Zu8mywXZXCEHdo=";
  }
  {
    # https://marketplace.visualstudio.com/items?itemName=mcu-debug.peripheral-viewer
    publisher = "mcu-debug";
    name = "peripheral-viewer";
    version = "1.4.6";
    hash = "sha256-flWBK+ugrbgy5pEDmGQeUzk1s2sCMQJRgrS3Ku1Oiag=";
  }
  {
    # https://marketplace.visualstudio.com/items?itemName=ms-vscode.vscode-serial-monitor
    publisher = "ms-vscode";
    name = "vscode-serial-monitor";
    version = "0.12.0";
    hash = "sha256-G4F5uUILP43QpUteHDMw8WOeftBuNHC+yF/HHtGTKh0=";
  }
]
