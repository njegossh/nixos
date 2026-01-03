{ ... } : {
  services.minio = {
    enable = true;
    listenAddress = "10.0.0.1:5353";
    consoleAddress = "10.0.0.1:5353";
    dataDir = "/var/lib/minio";
    accessKey = "access-key";
    secretKey = "secret-key";
  };
  networking.firewall.interfaces.wg0.allowedTCPPorts = [ 5353 ];
}
