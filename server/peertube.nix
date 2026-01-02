{ ... } : {
  services.peertube = {
    enable = true;
    database.createLocally = true;
    redis.createLocally = true;
    configureNginx = false;
    listenWeb = "10.0.0.1";
    listenHttp = "10.0.0.1";
  };
  networking.firewall.interfaces.wg0.allowedTCPPorts = [ 9000 ];
}
