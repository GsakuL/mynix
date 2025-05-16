{
  system-config,
  pkgs,
  lib,
  pkgs-alt,
  ...
}:
{
  home.packages = (
    with pkgs;
    [
      (btop.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [
          # git diff --no-index btop_draw.cpp btop_draw.mod.cpp | sed -e 's|a/btop_draw.cpp|a/src/btop_draw.cpp|' | sed -e 's|b/btop_draw.mod.cpp|b/src/btop_draw.cpp|' > short_cmd_draw.diff
          # git diff --no-index btop_shared.cpp btop_shared.mod.cpp | sed -e 's|a/btop_shared.cpp|a/src/btop_shared.cpp|' | sed -e 's|b/btop_shared.mod.cpp|b/src/btop_shared.cpp|' > short_cmd_shared.diff
          # ./short_cmd_draw.diff
          # ./short_cmd_shared.diff
        ];
      }))
    ]
  );
}
