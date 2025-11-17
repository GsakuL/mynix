{ pkgs, ... }:
{
  # https://docs.pipewire.org/page_pulse_modules.html
  services.pipewire.configPackages =
    let
      writeConf2 =
        dir: n:
        pkgs.writeTextDir "share/pipewire/${dir}/${n}.conf" (
          builtins.readFile (./. + "/conf.d/${dir}/${n}.conf")
        );
      writePipewireConf = n: writeConf2 "pipewire.conf.d" n;
      writePulseConf = n: writeConf2 "pipewire-pulse.conf.d" n;
    in
    (builtins.map writePipewireConf [
      "80-combine-mic"
    ])
    ++ (builtins.map writePulseConf [
      "80-pulse-local-tcp"
    ]);
}
