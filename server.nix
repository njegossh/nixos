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
    pihole-ftl = {
      enable = true;
      settings = {
        webserver.listen = [ "10.0.0.1:80" ];
        dns.listen.local = true;
        dns.upstream = [ "9.9.9.9" "149.112.112.112" ];
        dns.listening = [ "wg0" ];
      };
      lists = [
        {
          url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
          enabled = true;
          type = "block";
          description = "StevenBlack's unified hosts with ad/tracking/malware domains";
        }
        {
          url = "https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt";
          enabled = true;
          type = "block";
          description = "AdGuard DNS filter";
        }
        {
          url = "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/multi.txt";
          enabled = true;
          type = "block";
          description = "Hagezi's adblock list";
        }
      ];
      queryLogDeleter = {
        enable = true;
        age = 30;
      };
      openFirewallDNS = true;
    };
    pihole-web = {
      enable = true;
      ports = [ 8080 ];
    };
    searx = {
      enable = true;
      redisCreateLocally = true;
      settings = {
        server = {
          bind_address = "0.0.0.0"; 
          port = 8888;
          secret_key = "hehe";
          real_ip_header = "X-Forwarded-For";
        };
        search = {
          autocomplete = "google";
        };
      };
    };
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };
  };
  environment.systemPackages = with pkgs; [ neovim git hydroxide ];
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
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
      trustedInterfaces = [ "wg0" ];
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
