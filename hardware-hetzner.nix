{ ... } : {
  fileSystems = {
    "/" = { device = "/dev/disk/by-label/nixos"; fsType = "ext4"; };
    "/boot" = { device = "/dev/disk/by-label/boot"; fsType = "ext4"; };
  };
  swapDevices = [{ device = "/dev/disk/by-label/swap"; }];
  boot = {
    loader.grub = {
      enable = true;
      device = "/dev/sda";
    };
    initrd.availableKernelModules = [ "sd_mod" "virtio_scsi" "virtio_pci" "ahci" "xhci_pci" "ext4" "sr_mod" ];
  };
  time.timeZone = "Europe/London";
  nix.settings.experimental-features = "nix-command flakes";
  system.stateVersion = "24.11";
}
