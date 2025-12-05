{ pkgs, ... } : {
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
    initrd.availableKernelModules = [ 
      "sd_mod" "virtio_scsi" "virtio_pci"
      "ahci" "xhci_pci" "ext4" "sr_mod"
    ];
  };
  users.users = {
    root.hashedPassword = "!"; # Disable root login
    marko = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHwrjcFWLvlh9ia+S2gAikdnUTUxSZajcwDTrRean/5s marko@nixos"
      ];
    };
  };

  security.sudo.wheelNeedsPassword = false;

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  nix.settings = {
    experimental-features = "nix-command flakes";
  };

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  system.stateVersion = "24.11";

  environment = {
    systemPackages = with pkgs; [ fzf git ];
  };

  networking = {
    firewall = {
      allowedTCPPorts = [
        4444 7657 7654 7655 7656 7658 7659 #I2P 
        22 #SSH
      ];
      allowedUDPPorts = [ 
        21027 #Syncthing 
        12346 #I2P
      ];
    };
  };

  services.i2p.enable = true;

  networking.wireguard = {
    enable = true;
    interfaces.wg0 = {
      privateKeyFile = "/env/wg.key";
      listenPort = 51820;
    };
  };
}
