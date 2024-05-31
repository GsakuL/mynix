{ lib, pkgs, ... }:

{
  home.activation = {
    fixCitrix = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      [ -f "$HOME/.ICAClient/wfclient.ini" ] && run sed -i -E 's/^MouseSendsControlV=(True|\*)?$/MouseSendsControlV=False/' "$HOME/.ICAClient/wfclient.ini"
    '';
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [ teams-for-linux ];
}