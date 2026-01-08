{ ... } : {
  services = {
    pihole-ftl = {
      enable = true;
      settings = {
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
  networking.firewall.interfaces.wg0 = {
    allowedTCPPorts = [ 53 8080 ];
    allowedUDPPorts = [ 53 ];
  };
}
