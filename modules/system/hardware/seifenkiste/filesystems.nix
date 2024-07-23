{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ ntfs3g ];
  services.fstrim.enable = true;
  boot.supportedFilesystems = [ "ntfs" ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/efi";
  boot.loader.systemd-boot.xbootldrMountPoint = "/boot";

  # TODO: UID/GUID
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "ext4";
    };
    "/efi" = {
      device = "/dev/disk/by-label/EFIBOOT";
      fsType = "vfat";
    };
    "/boot" = {
      device = "/dev/disk/by-label/XBOOTLDR";
      fsType = "vfat";
    };
    "/media/Data" = {
      device = "/dev/disk/by-label/Data";
      fsType = "ntfs-3g";
      options = [
        "rw"
        "uid=1000"
        "gid=1000"
        "norecover"
      ];
    };
    "/media/SPEEEEET" = {
      device = "/dev/disk/by-label/SPEEEEET";
      fsType = "ntfs-3g";
      options = [
        "rw"
        "uid=1000"
        "gid=1000"
        "norecover"
      ];
    };
    "/media/SPEEEEEEEED" = {
      device = "/dev/disk/by-label/SPEEEEEEEED";
      fsType = "ntfs-3g";
      options = [
        "rw"
        "uid=1000"
        "gid=1000"
        "norecover"
      ];
    };
  };

  swapDevices = [
    {
      device = "/.swapfile";
      size = 36508;
    }
  ];
}
