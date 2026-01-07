{ pkgs, ... } : {
  services.desktopManager.gnome.enable = true;
  fonts.packages = [ pkgs.nerd-fonts.fantasque-sans-mono ];
}
