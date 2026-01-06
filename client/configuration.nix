{ ... } : {
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  time.timeZone = "Europe/Belgrade";
  security.rtkit.enable = true;
  services = {
    displayManager = {
      gdm.enable = true;
      autoLogin.user = "marko";
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };
  users.users.marko = {
    isNormalUser = true;
    description = "Marko";
    extraGroups = [ "networkmanager" "wheel" "adbusers" "docker" "fuse" ];
  };
  systemd.services = {
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
  };
  nix.settings = {
    trusted-users = [ "root" "marko" ];
    experimental-features = [ "nix-command" "flakes"];
  };
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };
  virtualisation.docker.enable = true;
  system.stateVersion = "24.11"; 
}
