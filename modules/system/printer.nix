{ pkgs, lib, ... }:

{
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.printing = {
    enable = true;
    browsed.enable = lib.mkForce false;
    drivers = with pkgs; [
      epson-escpr
      splix # SPL (Samsung Printer Language).
    ];
  };
}
