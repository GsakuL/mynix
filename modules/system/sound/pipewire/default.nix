{ pkgs, ... }:
{
  services.pipewire.configPackages = [
    # https://docs.pipewire.org/page_pulse_modules.html
    (pkgs.writeTextDir "share/pipewire/pipewire-pulse.conf.d/pulse-local-tcp.conf" ''
      pulse.cmd = [
          { cmd = "load-module" args = "module-native-protocol-tcp port=53972 auth-ip-acl=127.0.0.1" flags = [ ] }
      ]
    '')
  ];
}
