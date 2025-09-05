{ pkgs, ... } : {
  services.gnome.core-apps.enable = false;
	documentation.nixos.enable = false;
  nixpkgs.config.allowUnfree = true;
	services.printing.enable = false;
  programs.firefox.enable = true;

  programs.git = {
    enable = true;
    config.user = {
      name = "Marko";
      email = "markopetrovic3939@gmail.com";
    };
  };

  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  environment.systemPackages = with pkgs; [
    gnome-disk-utility gnome-system-monitor
    syncthing eartag lazygit foliate gcc
    fzf fragments addwater kgx amberol
    nautilus loupe baobab kooha
    vitetris blackbox-terminal
	];

  #services.flatpak = {
  #  enable = true;
  #  packages = [ "com.raggesilver.BlackBox" ];
  #};

	services.xserver.excludePackages = [ pkgs.xterm ];
  environment.gnome.excludePackages = [ pkgs.gnome-tour ];
}
