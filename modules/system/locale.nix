{ ... }:

{
  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";
  console = {
    #   font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    model = "pc104alt";
    layout = "de";
    variant = "deadacute";
    options = ""; # no terminate
  };
  # services.xserver.xkb.options = "eurosign:e,caps:escape";
}
