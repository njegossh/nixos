{ ... } : {
  services.i2pd = {
    enable = true;
    address = "10.0.0.1"; 
    proto.http = {
      enable = true;
      port = 4444;
      address = "0.0.0.0"; 
    };
  };
  networking.firewall = {
    allowedTCPPorts = [ 22 4444 ];
    allowedUDPPorts = [ 12346 ];
  };
}
