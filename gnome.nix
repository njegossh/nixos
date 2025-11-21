{ pkgs, lib, ... } : {
  environment.systemPackages = with pkgs.gnomeExtensions; [
    blur-my-shell just-perfection rounded-window-corners-reborn
  ];
  services.desktopManager.gnome = {
    enable = true;
    extraGSettingsOverrides = ''
      [org.gnome.mutter]
      experimental-features=['scale-monitor-framebuffer']
    '';
  };
  fonts = {
    packages = [ pkgs.nerd-fonts.jetbrains-mono ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font Mono Semi-Bold" ];
        sansSerif = [ "JetBrainsMono Nerd Font Mono Semi-Bold" ];
        serif     = [ "JetBrains MonoNerd Font Mono Semi-Bold" ];
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
        command = "kgx";
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
        monospace-font-name = "JetBrainsMono Nerd Font Bold 10";
        document-font-name  = "JetBrainsMono Nerd Font Bold 10";
        font-name           = "JetBrainsMono Nerd Font Bold 10";
      };
      "org/gnome/desktop/wm/preferences" = {
        titlebar-font = "JetBrainsMono Nerd Font Bold 10";
      };
    };
  }];
}
