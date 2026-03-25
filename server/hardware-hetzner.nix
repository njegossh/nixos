{ ... } : {
  fileSystems = {
    "/" = { device = "/dev/disk/by-label/nixos"; fsType = "ext4"; };
    "/boot" = { device = "/dev/disk/by-label/boot"; fsType = "ext4"; };
  };
  boot = {
    loader.grub = { enable = true; device = "/dev/sda"; };
    initrd.availableKernelModules = [ 
      "sd_mod" "virtio_scsi" "virtio_pci" "ahci" "xhci_pci" "ext4" "sr_mod"
    ];
  };
}
