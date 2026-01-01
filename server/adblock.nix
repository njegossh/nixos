{ ... } : {
  services = {
    pihole-ftl = {
      enable = true;
      settings = {
        webserver.listen = [ "10.0.0.1:80" ];
        dns.listen.local = true;
        dns.upstream = [ "9.9.9.9" "149.112.112.112" ];
        dns.listening = [ "wg0" ];
      };
      lists = [{
        url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
        enabled = true;
        type = "block";
        description = "StevenBlack's unified hosts with ad/tracking/malware domains";
      }];
      queryLogDeleter = {
        enable = true;
        age = 30;
      };
    };
    pihole-web = {
      enable = true;
      ports = [ 8080 ];
    };
  };
  networking.firewall.allowedTCPPorts = [ 80 8080 ];
}
