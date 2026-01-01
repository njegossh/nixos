{ ... } : {
  services.searx = {
    enable = true;
    redisCreateLocally = true;
    settings = {
      server = {
        bind_address = "10.0.0.1"; 
        port = 8888;
        secret_key = "hehe";
        real_ip_header = "X-Forwarded-For";
      };
      search.autocomplete = "google";
    };
  };

  networking.firewall = {
    interfaces.wg0.allowedTCPPorts = [ 8888 ];
  };
}
