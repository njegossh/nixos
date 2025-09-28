{ ... } : {
  home.username = "Marko";
  home.homeDirectory = "/home/marko";
  
  home.stateVersion = "24.11";
  
  #home.packages = with pkgs; [] ;
  
  # Primer konfiguracije Git-a (ako već nisi podesio)
  programs.git = {
    enable = true;
    userName = "Marko Petrovic";
    userEmail = "markopetrovic3939@gmail.com";
  };

  #home.file.".config/my-dotfile/settings.conf".source = ./files/settings.conf;
}
