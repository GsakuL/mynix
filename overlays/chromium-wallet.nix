self: super:
let
  mkWrap = (
    name: exe:
    super."${name}".overrideAttrs (old: {
      postFixup =
        (old.postFixup or "")
        + ''
          wrapProgram ${exe} --add-flags --password-store=basic
        '';
    })
  );
in
{
  vscode = mkWrap "vscode" "$out/bin/code";
  discord = mkWrap "discord" "$out/bin/discord";
  ungoogled-chromium = mkWrap "ungoogled-chromium" "$out/bin/chromium";
}
