{
  config,
  pkgs,
  lib,
  _tools,
  ...
}:
let
  inherit (_tools) scriptWithNArgs;
  mkMpv =
    {
      scripts ? [ ],
    }:
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
      libavif
      ffmpeg-full
      puddletag
      mp3gain

      yt-dlg
    ])
    ++ [
      (pkgs.writeShellApplication {
        name = "to-webp";
        runtimeInputs = [ pkgs.libwebp ];
        text = scriptWithNArgs 1 ''
          exec cwebp "$1" -mt -o "''${1}.webp"
        '';
      })
      (pkgs.writeShellApplication {
        name = "from-webp";
        runtimeInputs = [ pkgs.libwebp ];
        text = scriptWithNArgs 2 ''
          exec cwebp "$1" -mt -o "''${1}.''${2}"
        '';
      })
      (pkgs.yt-dlp.override {
        ffmpegSupport = true;
        ffmpeg-headless = pkgs.ffmpeg-full;
      })
    ]
    ++ (lib.optionals config.programs.mpv.enable [
      (pkgs.writeShellApplication {
        name = "mpv-bare";
        runtimeInputs = [ (mkMpv { }) ];
        text = ''
          exec mpv "$@"
        '';
      })
      (pkgs.writeShellApplication {
        name = "mpv-gui";
        text = ''
          exec mpv --player-operation-mode=pseudo-gui "$@"
        '';
      })
    ]);
}
