{ pkgs, ...}:
{
  environment.etc."peertube/secrets.env" = {
    text = ''
      PEERTUBE_DB_USERNAME=peertube_test
      PEERTUBE_DB_PASSWORD=test123
      PEERTUBE_DB_HOST=127.0.0.1
      PEERTUBE_DB_PORT=5432
      PEERTUBE_REDIS_HOST=127.0.0.1
      PEERTUBE_REDIS_PORT=31638
      PEERTUBE_ADMIN_EMAIL=admin@localhost
      PEERTUBE_SIGNUP_ENABLED=false
      PEERTUBE_WEBSERVER_HOSTNAME=10.0.0.1
      PEERTUBE_WEBSERVER_PORT=9000
    '';
    user = "peertube";
    group = "peertube";
  };

  networking.extraHosts = ''
    127.0.0.1 peertube.local
    10.0.0.1 peertube.local
  '';

  environment.etc = {
    "peertube/password-posgressql-db".text = "test123";
    "peertube/password-redis-db".text = "test123";
  };

  services = {
    peertube = {
      enable = true;
      localDomain = "10.0.0.1";
      enableWebHttps = false;
      secrets.secretsFile = "/etc/peertube/secrets.env";
      database = {
        host = "127.0.0.1";
        name = "peertube_local";
        user = "peertube_test";
        passwordFile = "/etc/peertube/password-posgressql-db";
      };
      redis = {
        host = "127.0.0.1";
        port = 31638;
        passwordFile = "/etc/peertube/password-redis-db";
      };
      settings = {
        listen.hostname = "0.0.0.0";
        instance.name = "PeerTube Test Server";
      };
    };

    postgresql = {
      enable = true;
      enableTCPIP = true;
      authentication = ''
        hostnossl peertube_local peertube_test 127.0.0.1/32 md5
      '';
      initialScript = pkgs.writeText "postgresql_init.sql" ''
        CREATE ROLE peertube_test LOGIN PASSWORD 'test123';
        CREATE DATABASE peertube_local TEMPLATE template0 ENCODING UTF8;
        GRANT ALL PRIVILEGES ON DATABASE peertube_local TO peertube_test;
        \connect peertube_local
        CREATE EXTENSION IF NOT EXISTS pg_trgm;
        CREATE EXTENSION IF NOT EXISTS unaccent;
      '';
    };

    redis.servers.peertube = {
      enable = true;
      bind = "0.0.0.0";
      requirePass = "test123";
      port = 31638;
    };
  };

  networking.firewall.interfaces.wg0.allowedTCPPorts = [ 9000 ];
}
