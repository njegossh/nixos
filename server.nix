{ pkgs } : {
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

  environment.systemPackages = with pkgs; [ fzf git ];

  networking = {
    firewall = {
      allowedTCPPorts = [
        4444 7657 7654 7655 7656 7658 7659 #I2P 
        22 #SSH
      ];
      allowedUDPPorts = [ 
        21027 #Syncthing 
        12346 #I2P
        51820 #Wireguard
      ];
    };
  };

  services.i2p.enable = true;

  networking.wireguard = {
    enable = true;
    interfaces.wg0.privateKeyFile = "/env/wg.key";
  };
}
