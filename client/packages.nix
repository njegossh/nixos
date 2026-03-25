{ pkgs, ... } : {
  nixpkgs.config.allowUnfree = true;
  documentation.nixos.enable = false;
  services.gnome.core-apps.enable = false;
  programs.steam.enable = true;
  environment = {
    gnome.excludePackages = [ pkgs.gnome-tour ];
    systemPackages = with pkgs; [
      nautilus neovim gapless blackbox-terminal
      gamescope shortwave rustup gcc mullvad-browser
    ];
  };
}
