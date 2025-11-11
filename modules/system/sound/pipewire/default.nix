{ pkgs, ... }:
{
  # https://docs.pipewire.org/page_pulse_modules.html
  services.pipewire.configPackages =
    let
      writeConf =
        n:
        pkgs.writeTextDir "share/pipewire/pipewire.conf.d/${n}.conf" (
          builtins.readFile (./. + "/conf.d/${n}.conf")
        );
    in
    (builtins.map writeConf [
      "80-combine-mic"
      "80-pulse-local-tcp"
    ]);
}
