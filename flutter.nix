{ config, pkgs, ... } : let
	home = config.users.users.marko.home;
	sdkHome = "${home}/.local/share";
	androidHome = "${sdkHome}/android-sdk";
	flutterHome = "${sdkHome}/flutter-sdk";
in {
  environment = {
    variables = {
      ANDROID_HOME = androidHome;
      JAVA_HOME = pkgs.openjdk17.home;
      PATH = [ "$PATH" "${flutterHome}/bin/" ];
    };
    systemPackages = [ pkgs.openjdk17 pkgs.sdkmanager ];
  };
  programs = {
    nix-ld.enable = true;
    adb.enable = true;
  };
}
