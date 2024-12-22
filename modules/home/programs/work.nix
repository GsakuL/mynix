{
  lib,
  pkgs,
  pkgs-alt,
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
  home.packages = [
    pkgs-alt.unstable-future.teams-for-linux

    (pkgs.citrix_workspace_24_05_0.overrideAttrs (old: {
      postInstall =
        (old.postInstall or "")
        + ''
          echo "I re-set TimeZone to local, otherwise my Windows remote (Group Policy) shows completely wrong TZ"
          echo "${system-config.time.timeZone}" > "$ICAInstDir/timezone"
        '';
    }))
  ];

  home.sessionVariables = {
    # https://support.citrix.com/article/CTX209485/how-to-make-a-session-that-spans-multiple-monitors-with-linux-receiver
    # wfica -span h
    WFICA_OPTS = "-span 1";
  };
}
