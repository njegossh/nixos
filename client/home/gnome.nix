{ lib, pkgs, ... } : {
  xdg.desktopEntries.nvim = { name = ""; noDisplay = true; };
  home.packages = with pkgs; [
    gnomeExtensions.blur-my-shell 
    gnomeExtensions.rounded-window-corners-reborn
    nerd-fonts.fantasque-sans-mono
  ];
  dconf.settings = with lib.gvariant; {
    "org/gnome/mutter".experimental-features = [
      "scale-monitor-framebuffer"
    ];
    "org/gnome/desktop/session".idle-delay = mkUint32 0;
    "org/gnome/shell".enabled-extensions = with pkgs.gnomeExtensions; [
      rounded-window-corners-reborn.extensionUuid
      blur-my-shell.extensionUuid
    ];
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Terminal";
      command = "blackbox";
      binding = "<Super>Return";
    };
    "org/gnome/settings-daemon/plugins/media-keys".custom-keybindings = [
      "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
    ];
    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      static-blur = false;
      sigma = 0;
      override-background = true;
      style-panel = 3;
    };
    "org/gnome/desktop/interface" = {
      monospace-font-name = "FantasqueSansM Nerd Font Mono 12";
      document-font-name  = "FantasqueSansM Nerd Font Mono 12";
      font-name           = "FantasqueSansM Nerd Font Mono 12";
    };
    "org/gnome/desktop/wm/preferences" = {
      titlebar-font = "FantasqueSansM Nerd Font Mono 12";
    };
  };

}
