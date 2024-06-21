{ ... }:

{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;

    settings = {
      General = {
        # Battery
        Experimental = true;
      };
    };
  };
}
