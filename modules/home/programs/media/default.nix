{ pkgs, ... }:

{
  # Bluetooth Media Controls
  services.mpris-proxy.enable = false;

  services.playerctld.enable = true;

  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      mpris
      thumbfast
      modernx
    ];
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
    ];
}
