self: super:
let
  asList = x: if builtins.isList x then x else [ x ];
  mkWrap = (
    name: exe:
    let
      exes = asList exe;
      lines = builtins.map (e: "wrapProgram ${e} --add-flags --password-store=basic") exes;
      text = builtins.concatStringsSep "\n" lines;
    in
    super."${name}".overrideAttrs (old: {
      postFixup = (old.postFixup or "") + "\n" + text;
    })
  );
in
{
  vscode = mkWrap "vscode" "$out/bin/code";
  discord = mkWrap "discord" [
    "$out/bin/discord"
    "$out/bin/Discord"
  ];
  ungoogled-chromium = mkWrap "ungoogled-chromium" "$out/bin/chromium";
}
