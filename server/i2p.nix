{ ... } : {
  services.i2pd = {
    enable = true;
    proto.socksProxy = {
      enable = true;
      port = 4444;
      address = "10.0.0.1"; 
    };
  };

  networking.firewall = {
    interfaces.wg0.allowedTCPPorts = [ 4444 ];
    allowedUDPPorts = [ 12346 ];
  };
}
