{ ... } : {
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
  networking = {
    nat = {
      enable = true;
      externalInterface = "enp1s0";
      internalInterfaces = [ "wg0" ];
      internalIPs = [ "10.0.0.0/24" ];
    };
    wg-quick.interfaces.wg0 = {
      address = [ "10.0.0.1/24" ];
      dns = [ "10.0.0.1" ];
      listenPort = 51820;
      privateKeyFile = "/env/wg.key";
      peers = [
        {
          publicKey = "nxMSbLowRtKyR/4O/TMVZjkrOKh4aV51Ks8gerLamUU=";
          allowedIPs = [ "10.0.0.2/32" ];
        }
      ];
    };
    firewall = {
      allowedUDPPorts = [ 51820 ];
      trustedInterfaces = [ "wg0" ];
    };
  };
}
