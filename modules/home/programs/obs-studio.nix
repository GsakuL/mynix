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
    ];
  };
}
