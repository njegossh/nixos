{ pkgs, lib, ... } : {
  environment.systemPackages = with pkgs.gnomeExtensions; [
    blur-my-shell just-perfection
  ];
  services.desktopManager.gnome.enable = true;
  fonts.packages = [ pkgs.nerd-fonts.fantasque-sans-mono ];
  programs.dconf.profiles.user.databases = [{
    settings = with lib.gvariant; {
      "org/gnome/mutter".experimental-features = [
        "scale-monitor-framebuffer"
      ];
      "org/gnome/desktop/session".idle-delay = mkUint32 0;
      "org/gnome/shell".enabled-extensions = with pkgs.gnomeExtensions; [
        just-perfection.extensionUuid
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
      "org/gnome/shell/extensions/just-perfection" = {
        panel-in-overview = true;
        show-apps-button = false;
        search = false;
        panel = false;
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
  }];
}
