{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ 
    minio-client
  ];
  environment.etc."minio/secrets.env" = {
    mode = "0600";
    text = ''
      MINIO_ROOT_USER=admin
      MINIO_ROOT_PASSWORD=strongpassword123
    '';
  };
  services.minio = {
    enable = true;
    listenAddress = "10.0.0.1:5353"; 
    consoleAddress = "10.0.0.1:5354";
    dataDir = [ "/var/lib/minio/data" ];
    rootCredentialsFile = "/etc/minio/secrets.env";
  };

  networking.firewall.interfaces.wg0 = {
    allowedTCPPorts = [ 5353 5354 ];
  };
}
