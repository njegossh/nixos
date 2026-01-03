{ pkgs, ... } : {
  services.xserver.desktopManager.xfce.enable = true;
  environment = {
    systemPackages = with pkgs; [
      chicago95

    xfce.xfce4-terminal
    xfce.xfce4-session
    xfce.thunar
    xfce.xfce4-whiskermenu-plugin
    # Additional useful XFCE packages
    xfce.xfce4-power-manager
    xfce.xfce4-notifyd
    ];
  };
}
