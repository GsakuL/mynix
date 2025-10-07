{ ... }:

{
  hardware.graphics = {
    enable = true;
    ## radv: an open-source Vulkan driver from freedesktop
    enable32Bit = true;
  };
  services.xserver.videoDrivers = [ "amdgpu" ];
}
