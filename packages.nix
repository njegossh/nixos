{ pkgs, ... } : {
  nixpkgs.config.allowUnfree = true;
  documentation.nixos.enable = false;

  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };
  environment = {
    gnome.excludePackages = [ pkgs.gnome-tour ];
    systemPackages = with pkgs; [
      fzf gnome-console nautilus
      foliate loupe
    ];
  };
  services = {
    printing.enable = false;
    gnome.core-apps.enable = false;
    xserver.excludePackages = [ pkgs.xterm ];
  };
}
