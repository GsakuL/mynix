{ pkgs, ... }:

{
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-freeze-filter
      obs-gstreamer
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vkcapture
      obs-vaapi
    ];
  };

  home.packages = (
    with pkgs;
    [
      gst_all_1.gstreamer
      gst_all_1.gst-vaapi
      gst_all_1.gst-plugins-base
      gst_all_1.gst-plugins-good
      gst_all_1.gst-libav
    ]
  );
}
