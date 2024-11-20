{
  system-config,
  pkgs,
  lib,
  pkgs-alt,
  ...
}:
let
  vesktop = pkgs-alt.unstable-future.vesktop;
  ovr1 = vesktop.overrideAttrs (
    final: prev:
    let
      src = pkgs.fetchFromGitHub {
        owner = "PolisanTheEasyNick";
        repo = "Vesktop";
        rev = "edd9f715fdd329461fd109163153b4bdb9c322bd";
        hash = "sha256-1inN9glnECV0y3jxrUGSfD9E7PXspz92xTzRUdH3fsQ=";
      };
    in
    {
      inherit src;
      pnpmDeps = prev.pnpmDeps.overrideAttrs {
        inherit src;
        hash = "";
      };
    }
  );
  ovr2 = vesktop.overrideAttrs (
    final: prev: {
      src = pkgs.fetchFromGitHub {
        owner = "Vencord";
        repo = "Vesktop";
        #rev = "062b5366171918d03b5da7ba54834f4cd902e8ef";
        #hash = "sha256-cqSm7WLY8jjmOVW0zvlkZ/zlFcPSD377vI+5qesoV2A=";

        rev = "ccff1ac3efde2b4fc826d2f411d79e42d80dcb70";
        hash = "sha256-u9aq5cbpaS7cdcbMjuVskv94WlvVG7ASyS/npN5tSR0=";
      };
      patches = (prev.patches or [ ]) ++ [
        ./pr_609.patch
      ];
    }
  );
in
{
  home.packages = [
    vesktop

    # ovr1
    # ovr2
  ];
}
