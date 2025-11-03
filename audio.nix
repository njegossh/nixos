{ pkgs, ... } : {
  environment.systemPackages = [ pkgs.ncmpcpp ];

  services = {
    mpd = {
      enable = true;
      user = "marko";
      musicDirectory = "/home/marko/Music";
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
