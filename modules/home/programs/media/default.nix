{
  config,
  pkgs,
  lib,
  ...
}:
let
  mkMpv =
    { scripts ? [] }:
    pkgs.mpv-unwrapped.wrapper {
      mpv = pkgs.mpv-unwrapped.override { ffmpeg = pkgs.ffmpeg-full; };
      scripts = scripts;
    };
in
{
  # Bluetooth Media Controls
  services.mpris-proxy.enable = false;

  services.playerctld.enable = true;

  programs.mpv = {
    enable = true;
    package = mkMpv {
      scripts = with pkgs.mpvScripts; [
        mpris
        thumbfast
        modernx
      ];
    };
  };

  home.packages =
    (with pkgs; [
      vlc
      smplayer

      playerctl

      libjxl
      libwebp
      ffmpeg-full
      puddletag
      mp3gain

      yt-dlg
    ])
    ++ [

      (pkgs.yt-dlp.override {
        ffmpegSupport = true;
        ffmpeg = pkgs.ffmpeg-full;
      })
    ]
    ++ (lib.optionals config.programs.mpv.enable [
      (pkgs.writeShellScriptBin "mpv-bare" ''
        ${lib.getExe (mkMpv { })} "$@"
      '')

      (pkgs.writeShellScriptBin "mpv-gui" ''
        mpv --player-operation-mode=pseudo-gui "$@"
      '')
    ]);
}
