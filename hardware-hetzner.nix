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
    username = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHwrjcFWLvlh9ia+S2gAikdnUTUxSZajcwDTrRean/5s marko@nixos"
      ];
    };
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

   networking.firewall.allowedTCPPorts = [ 22 ];
   
   system.stateVersion = "24.11";

  environment = {
    systemPackages = with pkgs; [ fzf git neovim ];
  };
}
