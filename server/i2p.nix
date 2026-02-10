{ ... } : {
  services.i2p.enable = true;
  networking.firewall.interfaces.wg0.allowedTCPPorts = [ 7657 4444 4445 ];
}
