{ ... } : { 
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
