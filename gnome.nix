{ pkgs, lib, ... } : {
  environment.systemPackages = (with pkgs.gnomeExtensions; [
    blur-my-shell just-perfection rounded-window-corners-reborn
  ]) ++ [ pkgs.nautilus-open-any-terminal ];
  services.desktopManager.gnome = {
    enable = true;
    extraGSettingsOverrides = ''
      [org.gnome.mutter]
      experimental-features=['scale-monitor-framebuffer']
    '';
  };
  fonts = {
    packages = [ pkgs.nerd-fonts.fantasque-sans-mono ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "FantasqueSansM Nerd Font Mono" ];
        sansSerif = [ "FantasqueSansM Nerd Font Mono" ];
        serif     = [ "FantasqueSansM Nerd Font Mono" ];
      };
    };
  };
  programs.dconf.profiles.user.databases = [{
    settings = with lib.gvariant; {
      "org/gnome/desktop/session".idle-delay = mkUint32 0;
      "org/gnome/shell".enabled-extensions = with pkgs.gnomeExtensions; [
        rounded-window-corners-reborn.extensionUuid
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
        panel = false;
        search = false;
        panel-in-overview = true;
      };
      "org/gnome/desktop/interface" = {
        monospace-font-name = "FantasqueSansM Nerd Font Mono 10";
        document-font-name  = "FantasqueSansM Nerd Font Mono 10";
        font-name           = "FantasqueSansM Nerd Font Mono 10";
      };
      "org/gnome/desktop/wm/preferences" = {
        titlebar-font = "FantasqueSansM Nerd Font Mono 10";
      };
    };
  }];
}
