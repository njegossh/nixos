{ ... } : {
  programs.dconf.enable = true;
  programs.dconf.settings = {
    "org/gnome/system/proxy" = {
      mode = "auto";
      autoconfig-url = "file:///etc/proxy.pac";
    };
  };

  environment.etc."proxy.pac".text = ''
    function FindProxyForURL(url, host) {
      if (dnsDomainIs(host, ".i2p")) {
        // Change this IP to your VPS's WireGuard IP
        return "PROXY 10.0.0.1:4444";
      }
      
      return "DIRECT";
    }
  '';
}
