{ lib, ... }:

{
  environment.etc =
    let
      confs = [
        "70-bluez-props-no-headset"
        # "70-bluez-rules-no-headset"
        "70-no-headset"
        "70-no-webcam-mic"
      ];
      kvp = builtins.map (
        v:
        lib.attrsets.nameValuePair "wireplumber/wireplumber.conf.d/${v}.conf" {
          source = ./. + "/conf.d/${v}.conf";
        }
      ) confs;
      mapping = builtins.listToAttrs kvp;
    in
    mapping;
}
