{ pkgs, ... } : {
  nixpkgs.config.allowUnfree = true;
  documentation.nixos.enable = false;

  services.syncthing.enable = true;

  programs.steam.enable = true;
  environment = {
    gnome.excludePackages = [ pkgs.gnome-tour ];
    systemPackages = with pkgs; [
      fzf nautilus foliate fragments
      debootstrap gapless gamescope blackbox-terminal
    ];
  };
  services = {
    gnome.core-apps.enable = false;
    xserver.excludePackages = [ pkgs.xterm ];
  };
}
