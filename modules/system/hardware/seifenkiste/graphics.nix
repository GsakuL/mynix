{ pkgs, ... }:

{
  hardware.opengl = {
    enable = true;
    ## radv: an open-source Vulkan driver from freedesktop
    driSupport = true;
    driSupport32Bit = true;

    ## amdvlk: an open-source Vulkan driver from AMD
    extraPackages = with pkgs; [ amdvlk ];
    extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
  };
  services.xserver.videoDrivers = [ "amdgpu" ];
}
