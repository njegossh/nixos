{ config, pkgs, ... } : let
	home = config.users.users.marko.home;
	sdkHome = "${home}/.local/share";
	androidHome = "${sdkHome}/android-sdk";
	flutterHome = "${sdkHome}/flutter-sdk";
in {
  programs.nix-ld.enable = true;
  environment = {
    variables = {
      ANDROID_HOME = androidHome;
      JAVA_HOME = pkgs.openjdk17.home;
      PATH = [ "$PATH" "${flutterHome}/bin/" ];
    };
    systemPackages = with pkgs; [ openjdk17 sdkmanager unzip];
  };
}
