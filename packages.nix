{ pkgs, ... } : {
  nixpkgs.config.allowUnfree = true;

  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  environment.systemPackages = with pkgs; [
    fzf gnome-console nautilus
    foliate loupe rustdesk
	];

  #services.flatpak = {
  #  enable = true;
  #  packages = [ "com.raggesilver.BlackBox" ];
  #};

	services.printing.enable = false;
	documentation.nixos.enable = false;
  services.gnome.core-apps.enable = false;
	services.xserver.excludePackages = [ pkgs.xterm ];
  environment.gnome.excludePackages = [ pkgs.gnome-tour ];
}
