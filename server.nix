{ pkgs, ... } : {
  users.users = {
    root.hashedPassword = "!"; # Disable root login
    marko = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHwrjcFWLvlh9ia+S2gAikdnUTUxSZajcwDTrRean/5s marko@nixos"
      ];
    };
    nikola = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPs1Vxf1az3yuRlRSJyYBNAFr3mYdHTzRLMF70CsWhsX nikola@nikola-All-Series"
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
        2200 #Syncthing
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
  services.syncthing.enable = true;

  networking.wg-quick.interfaces.wg0 = {
    address = [ "10.0.0.1/24" ];
    dns = [ "1.1.1.1" ];
    listenPort = 51820;
    privateKeyFile = "/env/wg.key";
    peers = [
      {
        publicKey = "nxMSbLowRtKyR/4O/TMVZjkrOKh4aV51Ks8gerLamUU=";
        allowedIPs = [ "10.0.0.2/32" ];
        #endpoint = "10.0.0.2/32";
      }
    ];
  };
}
