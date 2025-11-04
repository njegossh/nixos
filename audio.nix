{ pkgs, ... } : {
  environment.systemPackages = with pkgs; [ inori ncmpcpp vimpc rmpc ];

  services = {
    mpd = {
      enable = true;
      musicDirectory = "/home/marko/Music";
      extraConfig = ''
        audio_output {
          type "pipewire"
          name "PipeWire Output"
        }
      '';
      user = "marko";
      network.listenAddress = "any";
      startWhenNeeded = true;
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
  };

  systemd.services.mpd.environment = {
    XDG_RUNTIME_DIR = "/run/user/1000";
  };
}
