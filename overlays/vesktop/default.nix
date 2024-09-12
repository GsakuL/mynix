# icons by @pigsflew https://github.com/Vencord/Vesktop/issues/401#issuecomment-2014537331
self: super: {
  vesktop = super."vesktop".overrideAttrs (old: {
    preBuild =
      (old.preBuild or "")
      + ''
        cp ${./.}/icon_512x512x32.png ./build/icon.png
        cp ${./.}/icon_512x512x32.png ./static/icon.png
        cp ${./.}/icon.ico ./static/icon.ico
      '';
    postBuild =
      (old.postBuild or "")
      + ''
        pushd build
        rm ./icon_*x32.png
        cp ${./.}/icon_*x32.png .
        popd
      '';
  });
}
