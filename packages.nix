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
    gnome-disk-utility mission-center
    syncthing eartag lazygit foliate gcc
    fzf fragments addwater kgx cmus
    nautilus loupe baobab bombadillo
    recordbox rustdesk
	];

  #services.flatpak = {
  #  enable = true;
  #  packages = [ "com.raggesilver.BlackBox" ];
  #};

	services.xserver.excludePackages = [ pkgs.xterm ];
  environment.gnome.excludePackages = [ pkgs.gnome-tour ];
}
