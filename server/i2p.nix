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
  networking.firewall.interfaces.wg0 = {
    allowedTCPPorts = [ 4444 ];
    allowedUDPPorts = [ 12346 ];
  };
}
