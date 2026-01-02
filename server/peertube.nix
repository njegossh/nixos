{ ... } : {
  services.peertube = {
    enable = true;
    database.createLocally = true;
    redis.createLocally = true;
    configureNginx = false;
  };
  networking.firewall.interfaces.wg0.allowedTCPPorts = [ 9000 ];
}
