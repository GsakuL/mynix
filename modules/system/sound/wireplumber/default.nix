{ pkgs, ... }:

{
  services.pipewire.wireplumber.configPackages =
    let
      writeConf =
        n:
        pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/${n}.conf" (
          builtins.readFile (./. + "/conf.d/${n}.conf")
        );
    in
    builtins.map writeConf [
      "70-audeze-maxwell-disable-nopro"
      "70-audeze-maxwell-game-chat"
      "70-bluez-props-no-headset"
      "70-bluez-rules-no-headset"
      "70-no-headset"
      "70-no-webcam-mic"
      "71-output-priority"
    ];
}
