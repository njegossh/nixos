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
    gcc fzf gnome-console nautilus
    foliate loupe rustdesk
	];

  #services.flatpak = {
  #  enable = true;
  #  packages = [ "com.raggesilver.BlackBox" ];
  #};

	services.xserver.excludePackages = [ pkgs.xterm ];
  environment.gnome.excludePackages = [ pkgs.gnome-tour ];
}
