{ config }:

self: super: {
  citrix_workspace = super."citrix_workspace".overrideAttrs (old: {
    postInstall =
      (old.postInstall or "")
      + ''
        echo "I re-set TimeZone to local, otherwise my Windows remote (Group Polcy) shows completely wrong TZ"
        echo "${config.time.timeZone}" > "$ICAInstDir/timezone"
      '';
  });
}
