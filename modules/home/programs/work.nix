{
  lib,
  pkgs,
  system-config,
  ...
}:

{
  home.activation = {
    fixCitrix = lib.hm.dag.entryAfter [ "installPackages" ] ''
      ini="$HOME/.ICAClient/wfclient.ini"
      if [ -f "$ini" ]
      then
        run ${lib.getExe' pkgs.crudini "crudini"} \
          --set "$ini" WFClient DPIMatchingEnabled 1 \
          --set "$ini" WFClient MouseSendsControlV False
      fi
    '';
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    teams-for-linux

    (
      (citrix_workspace.overrideAttrs (old: {
        postInstall =
          (old.postInstall or "")
          + ''
            echo "I re-set TimeZone to local, otherwise my Windows remote (Group Policy) shows completely wrong TZ"
            echo "${system-config.time.timeZone}" > "$ICAInstDir/timezone"
          '';
      })).override
      {
        # https://github.com/NixOS/nixpkgs/issues/348868#issuecomment-2429273888
        libvorbis = pkgs.libvorbis.override {
          libogg = pkgs.libogg.overrideAttrs (prevAttrs: {
            cmakeFlags = (prevAttrs.cmakeFlags or [ ]) ++ [
              (lib.cmakeBool "BUILD_SHARED_LIBS" true)
            ];
          });
        };
      }
    )
  ];

  home.sessionVariables = {
    # https://support.citrix.com/article/CTX209485/how-to-make-a-session-that-spans-multiple-monitors-with-linux-receiver
    # wfica -span h
    WFICA_OPTS = "-span 1";
  };
}
