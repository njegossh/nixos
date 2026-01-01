{ ... } : {
  services.searx = {
    enable = true;
    redisCreateLocally = true;
    settings = {
      server = {
        bind_address = "0.0.0.0"; 
        port = 8888;
        secret_key = "hehe";
        real_ip_header = "X-Forwarded-For";
      };
      search.autocomplete = "google";
    };
  };

  networking.firewall.allowedTCPPorts = [ 8888 ];
}
