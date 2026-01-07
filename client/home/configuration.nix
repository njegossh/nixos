{ ... } : {
  programs.git = {
    enable = true;
    settings = {
      pull.rebase = true;
      user = {
        name = "Marko Petrovic";
        email = "markopetrovic3939@gmail.com";
      }; 
    };
  };
  home.stateVersion = "24.11";
}
