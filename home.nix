{ ... } : {
  home.stateVersion = "24.11";
  
  #home.packages = with pkgs; [] ;
  
  programs.git = {
    enable = true;
    userName = "Marko Petrovic";
    userEmail = "markopetrovic3939@gmail.com";
  };

  programs.cmus = {
    enable = true;
    theme = "gruvbox";
  };

  programs.firefox = {
    enable = true;
    profiles = { 
      default = {
        id = 0;
        name = "Marko";
        isDefault = true;
        containers = {
          Personal =  { color = "orange";   icon = "fingerprint"; id = 0; };
          Work =      { color = "red";      icon = "briefcase";   id = 1; };
          Shop =      { color = "green";    icon = "cart";        id = 2; };
          Uni =       { color = "purple";   icon = "fence";       id = 3; };
          I2P =       { color = "toolbar";  icon = "chill";       id = 4; };
        };
      };
    };
  };
}
