{ pkgs, ... } : {
  nixpkgs.config.allowUnfree = true;
  documentation.nixos.enable = false;
  programs.steam.enable = true;
  environment = {
    gnome.excludePackages = [ pkgs.gnome-tour ];
    systemPackages = with pkgs; [
      nautilus python3 cmus neovim
      gamescope blackbox-terminal mutt
    ];
  };
  services = {
    gnome.core-apps.enable = false;
    xserver.excludePackages = [ pkgs.xterm ];
  };
}
