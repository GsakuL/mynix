# https://github.com/NixOS/nixpkgs/issues/311673
# https://github.com/coreyoconnor/nix_configs/blob/bbfe68fbb6518e65ff479217af55e42656b5fede/defaults/nixpkgs-config/overlays/streamdeck.nix
self: super: {
  streamdeck-ui = super.streamdeck-ui.overridePythonAttrs (old: rec {
    version = "4.1.2";

    src = self.fetchFromGitHub {
      repo = "streamdeck-linux-gui";
      owner = "streamdeck-linux-gui";
      rev = "v${version}";
      sha256 = "sha256-CSsFPGnKVQUCND6YOA9kfO41KS85C57YL9LcrWlQRKo=";
    };

    # GUI tests require https://github.com/boylea/qtbot which is unmaintained
    doCheck = false;

    patches = [
      ./fc-list.patch
      ./update-dependencies.patch
    ];

    preBuild = ''
      export HOME="$TMP"
    '';

    propagatedBuildInputs =
      with self.python3Packages;
      [
        evdev
        importlib-metadata
      ]
      ++ old.propagatedBuildInputs;
  });

  python3 = super.python3.override {
    packageOverrides = python-self: python-super: {
      streamdeck = python-super.streamdeck.overridePythonAttrs (old: rec {
        version = "0.9.5";

        src = python-self.fetchPypi {
          inherit (old) pname;
          inherit version;
          hash = "";
        };
      });
    };
  };
}
