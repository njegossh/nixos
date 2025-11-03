{ ... } : {
  programs = {
    git = {
      enable = true;
      settings.user = {
        name = "Marko Petrovic";
        email = "markopetrovic3939@gmail.com";
      }; 
    };
    firefox = {
      enable = true;
      profiles = { 
        default = {
          id = 0;
          name = "Marko";
          isDefault = true;
          containers = {
            Personal =  { color = "orange";   icon = "fingerprint"; id = 1; };
            Work =      { color = "red";      icon = "briefcase";   id = 2; };
            Shop =      { color = "green";    icon = "cart";        id = 3; };
            Uni =       { color = "purple";   icon = "fence";       id = 4; };
            I2P =       { color = "toolbar";  icon = "chill";       id = 5; };
            Business =  { color = "yellow";   icon = "briefcase";   id = 6; };
          };
        };
      };
    };
  };
  home.stateVersion = "24.11";
}
