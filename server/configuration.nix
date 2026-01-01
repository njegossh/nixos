{ pkgs, ... } : {
  security.sudo.wheelNeedsPassword = false;
    
  environment.systemPackages = with pkgs; [ neovim git hydroxide ];

  time.timeZone = "Europe/London";
  nix.settings.experimental-features = "nix-command flakes";
  system.stateVersion = "24.11";
}
