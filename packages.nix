{ pkgs, ... } : {
  services.gnome.core-apps.enable = false;
	documentation.nixos.enable = false;
  nixpkgs.config.allowUnfree = true;
	services.printing.enable = false;

  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  environment.systemPackages = with pkgs; [
    mission-center gcc fzf kgx lazygit 
    syncthing foliate fragments kew
    nautilus loupe baobab bombadillo
    rustdesk
	];

  #services.flatpak = {
  #  enable = true;
  #  packages = [ "com.raggesilver.BlackBox" ];
  #};

	services.xserver.excludePackages = [ pkgs.xterm ];
  environment.gnome.excludePackages = [ pkgs.gnome-tour ];
}
