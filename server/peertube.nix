{ ... } : {
  environment.etc."peertube/secrets.env" = {
    text = ''
      PEERTUBE_DB_USERNAME=peertube
      PEERTUBE_DB_PASSWORD=peertube
      PEERTUBE_DB_HOST=127.0.0.1
      PEERTUBE_DB_PORT=5432
      PEERTUBE_REDIS_HOST=127.0.0.1
      PEERTUBE_REDIS_PORT=6379
      PEERTUBE_ADMIN_EMAIL=admin@localhost
      PEERTUBE_SIGNUP_ENABLED=false
      PEERTUBE_WEBSERVER_HOSTNAME=10.0.0.1
      PEERTUBE_WEBSERVER_PORT=9000
    '';
    user = "peertube";
    group = "peertube";
  };
  services.peertube = {
    enable = true;
    database.createLocally = true;
    redis.createLocally = true;
    configureNginx = false;
    listenWeb = 9000;
    listenHttp = 9000;
    localDomain = "peertube";
    secrets.secretsFile = "/etc/peertube/secrets.env";
  };
  networking.firewall.interfaces.wg0.allowedTCPPorts = [ 9000 ];
}
