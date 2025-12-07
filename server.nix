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

  services = {
    i2p.enable = true;
    syncthing.enable = true;
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };
  };

  environment.systemPackages = with pkgs; [ fzf git ];

  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;

  #  environment.etc."i2p/router.config".text = ''
  #routerconsole.host=0.0.0.0
  #i2ptunnel.proxy.dsa.0.host=0.0.0.0
  #'';

  systemd.services.i2p.serviceConfig = {
  # Koristimo opciju 'Service' koja nam dozvoljava da precizno dopunimo unit
  # Koristimo '+' kao prefiks da bismo appendovali (dodali) na originalnu komandu
  # Ali pošto I2P ne podržava append, moramo ga prepisati
  
  # Koristimo Environment File da bi injektovali opcije.
  # I2P ruter skripta često čita konfiguracione opcije iz environment fajla.
  EnvironmentFile = [
    "-/etc/i2p/i2p-bind.env" # Ovo će biti novi fajl sa opcijama
  ];
};

# Kreiramo Environment fajl sa opcijama koje se prosleđuju Java-i
environment.etc."i2p/i2p-bind.env".text = ''
  JAVA_OPTS="-Drouterconsole.host=0.0.0.0 -Di2ptunnel.proxy.dsa.0.host=0.0.0.0"
'';
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
      extraCommands = ''
        iptables -A FORWARD -i wg0 -o enp1s0 -j ACCEPT
        iptables -A FORWARD -o wg0 -i enp1s0 -j ACCEPT
      '';
    };
    nat = {
      enable = true;
      externalInterface = "enp1s0";
      internalInterfaces = [ "wg0" ];
      internalIPs = [ "10.0.0.0/24" ];
    };
    wg-quick.interfaces.wg0 = {
      address = [ "10.0.0.1/24" ];
      dns = [ "1.1.1.1" ];
      listenPort = 51820;
      privateKeyFile = "/env/wg.key";
      peers = [
        {
          publicKey = "nxMSbLowRtKyR/4O/TMVZjkrOKh4aV51Ks8gerLamUU=";
          allowedIPs = [ "10.0.0.2/32" ];
        }
      ];
    };
  };
}
